using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.IO;
using SmartCMS.Filters;
using SmartCMS.Models;
using SmartCMS.Extensions;

namespace SmartCMS.Controllers
{
    [SmartCMSAuth(Roles = Constants.Roles.ROLE_ADMIN + "," + Constants.Roles.ROLE_CHIEF_EDITOR + "," + Constants.Roles.ROLE_EDITOR)]
    public class CMSController : BaseController
    {

        public ActionResult Index()
        {
            return RedirectToAction("Categories");
        }


        #region 分类管理

        public ActionResult Categories()
        {
            var model = from row in db.Categories
                        where row.ParentCategoryId == 0
                        orderby row.Id
                        select new CategoryViewModel
                        {
                            Id = row.Id,
                            ParentId = row.ParentCategoryId,
                            Name = row.Name,
                            Comment = row.Comment,
                        };

            List<CategoryViewModel> result = new List<CategoryViewModel>();
            for (int i = 0; i < model.Count(); i++)
            {
                CategoryViewModel s = model.ToArray()[i];
                s.SubCategories = setSubCategoires(s);
                result.Add(s);
            }

            return View(result);
        }

        public ActionResult Category(int id)
        {
            var categories = from row in db.Categories
                             where row.Id == id
                             select new CategoryViewModel
                             {
                                 Id = row.Id,
                                 ParentId = row.ParentCategoryId,
                                 Name = row.Name,
                                 Comment = row.Comment,
                             };

            var model = categories.SingleOrDefault();
            model.SubCategories = from sr in db.Categories
                                  where sr.ParentCategoryId == model.Id
                                  orderby sr.Name
                                  select new CategoryViewModel
                                  {
                                      Id = sr.Id,
                                      ParentId = sr.ParentCategoryId,
                                      Name = sr.Name,
                                      Comment = sr.Comment,
                                  };
            model.Articles = from a in db.Knowledges
                             where a.CategoryId == model.Id
                             orderby a.Topic
                             select new KnowledgeViewModel
                             {
                                 Id = a.Id,
                                 CategoryId = a.CategoryId.Value,
                                 Question = a.Topic,
                                 Answer = a.Content,
                                 Hits = a.Hits.Value,
                                 Keywords = a.Keywords,
                                 CreatedAt = a.CreatedAt,
                                 CreatedBy = a.User.RealName,
                                 Attachment = a.Attachment,
                             };
            ViewBag.Breadcrumbs = setBreadcrumbs(model.Id);
            return View(model);
        }

        [SmartCMSAuth(Roles = Constants.Roles.ROLE_ADMIN + "," + Constants.Roles.ROLE_CHIEF_EDITOR)]
        public ActionResult AddCategory(int? id)
        {
            var model = new CategoryViewModel
            {
                ParentId = id.HasValue ? id.Value : 0,
            };
            if (id > 0)
                ViewBag.Category = db.Categories.SingleOrDefault(m => m.Id == id).Name;
            ViewBag.Breadcrumbs = setBreadcrumbs(id.HasValue ? id.Value : 0);
            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [SmartCMSAuth(Roles = Constants.Roles.ROLE_ADMIN + "," + Constants.Roles.ROLE_CHIEF_EDITOR)]
        public ActionResult AddCategory(CategoryViewModel model)
        {
            if (string.IsNullOrWhiteSpace(model.Name))
                ModelState.AddModelError("", "请输入分类名称");
            if (ModelState.IsValid)
            {
                model.Name = model.Name.Trim();
                var i = db.Categories.Count(m => m.Name.Equals(model.Name, StringComparison.OrdinalIgnoreCase) && m.ParentCategoryId == model.ParentId);
                if (i > 0)
                {
                    ModelState.AddModelError("", "分类已经存在，请勿重复添加!");
                }
                else
                {
                    db.Categories.Add(new Category
                    {
                        Name = model.Name.Trim(),
                        Comment = model.Comment,
                        CreatedAt = DateTime.Now,
                        CreatedBy = CurrentUser.Id,
                        ParentCategoryId = model.ParentId,
                    });
                    db.SaveChanges();
                    ViewBag.SuccessMessage = "问题分类添加成功！";
                    Log("添加分类:" + model.Name);
                }
            }
            if (model.ParentId > 0)
                ViewBag.Category = db.Categories.SingleOrDefault(m => m.Id == model.ParentId).Name;
            ViewBag.Breadcrumbs = setBreadcrumbs(model.ParentId);
            return View(model);
        }

        [SmartCMSAuth(Roles = Constants.Roles.ROLE_ADMIN + "," + Constants.Roles.ROLE_CHIEF_EDITOR)]
        public ActionResult EditCategory(int id)
        {
            var model = from row in db.Categories
                        where row.Id == id
                        select new CategoryViewModel
                        {
                            Id = row.Id,
                            Name = row.Name,
                            Comment = row.Comment,
                            ParentId = row.ParentCategoryId,
                            CreatedAt = row.CreatedAt,
                            CreatedBy = row.User.RealName,
                        };
            ViewBag.Category = db.Categories.SingleOrDefault(m => m.Id == id).Name;
            ViewBag.Breadcrumbs = setBreadcrumbs(id);
            return View(model.SingleOrDefault());
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [SmartCMSAuth(Roles = Constants.Roles.ROLE_ADMIN + "," + Constants.Roles.ROLE_CHIEF_EDITOR)]
        public ActionResult EditCategory(int id, CategoryViewModel model)
        {
            if (string.IsNullOrWhiteSpace(model.Name))
                ModelState.AddModelError("", "请输入分类名称");
            if (ModelState.IsValid)
            {
                var c = db.Categories.SingleOrDefault(m => m.Id == id);
                c.Name = model.Name.Trim();
                c.Comment = model.Comment;
                db.SaveChanges();
                ViewBag.SuccessMessage = "分类修改成功！";
                Log("修改分类:" + model.Name);
            }
            var newModel = from row in db.Categories
                           where row.Id == id
                           select new CategoryViewModel
                           {
                               Id = row.Id,
                               Name = row.Name,
                               Comment = row.Comment,
                               ParentId = row.ParentCategoryId,
                               CreatedAt = row.CreatedAt,
                               CreatedBy = row.User.RealName,
                           };
            ViewBag.Category = db.Categories.SingleOrDefault(m => m.Id == id).Name;
            ViewBag.Breadcrumbs = setBreadcrumbs(id);
            return View(newModel.SingleOrDefault());
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [SmartCMSAuth(Roles = Constants.Roles.ROLE_ADMIN + "," + Constants.Roles.ROLE_CHIEF_EDITOR)]
        public ActionResult DeleteCategory(int id)
        {
            var u = db.Categories.SingleOrDefault(m => m.Id == id);
            if (u != null)
            {
                var c = db.Categories.Where(m => m.ParentCategoryId == id);
                if (c.Count() > 0 || u.Knowledges.Count() > 0)
                {
                    ModelState.AddModelError("", "问题分类不为空，无法删除！");
                }
                else
                {
                    db.Categories.Remove(u);
                    db.SaveChanges();
                    Log("删除分类:" + u.Name);
                    ViewBag.SuccessMessage = "删除分类成功！";
                }
            }
            else
            {
                ModelState.AddModelError("", "找不到指定分类");
            }
            return RedirectToAction("Categories");
        }

        #endregion



        #region 知识管理

        public ActionResult AddArticle(int id, int? uid)
        {
            var model = new KnowledgeViewModel
            {
                CategoryId = id,
            };
            if (uid.HasValue)
            {
                var k = db.Questions.SingleOrDefault(m => m.Id == uid);
                model.Question = k.Content;
                model.PendingId = uid.Value;
                model.Answer = db.Answers.FirstOrDefault(m => m.QuestionId == uid && m.Accepted).Content;
            }
            ViewBag.Category = db.Categories.SingleOrDefault(m => m.Id == id).Name;
            ViewBag.Breadcrumbs = setBreadcrumbs(id);
            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AddArticle(KnowledgeViewModel model)
        {
            if (ModelState.IsValid)
            {
                model.Question = model.Question.Trim();
                var i = db.Knowledges.Count(m => m.Topic.Equals(model.Question, StringComparison.OrdinalIgnoreCase) && m.CategoryId == model.CategoryId);
                if (i > 0)
                {
                    ModelState.AddModelError("", "同类别下相同知识条目已经存在，请勿重复添加!");
                }
                else
                {
                    var attachmentPath = "";
                    //upload file
                    HttpRequestBase request = this.Request;
                    if (request.Files.Count == 1 && !string.IsNullOrWhiteSpace(request.Files[0].FileName))
                    {
                        string originalName = (new FileInfo(request.Files[0].FileName)).Name;
                        string fileName = DateTime.Now.ToString("yyyyMMddHHmmss") + "" + originalName.Substring(originalName.LastIndexOf("."));
                        string dir = System.Web.HttpContext.Current.Server.MapPath("~/" + Constants.UploadFolder + DateTime.Now.ToString("yyyyMM"));
                        if (!Directory.Exists(dir))
                        {
                            Directory.CreateDirectory(dir);
                        }
                        attachmentPath = Path.Combine(dir, fileName);
                        request.Files[0].SaveAs(attachmentPath);
                        attachmentPath = Constants.UploadFolder + DateTime.Now.ToString("yyyyMM") + "/" + fileName;
                    }

                    db.Knowledges.Add(new Knowledge
                    {
                        Topic = model.Question,
                        Content = model.Answer,
                        Keywords = model.Keywords,
                        Hits = 0,
                        CreatedAt = DateTime.Now,
                        CreatedBy = CurrentUser.Id,
                        CategoryId = model.CategoryId,
                        Attachment = attachmentPath
                    });

                    //If it's pending Question remove it
                    /*
                    if (model.PendingId > 0)
                    {
                        var p = db.Questions.SingleOrDefault(m => m.Id == model.PendingId);
                        if (p != null)
                            db.Questions.Remove(p);
                    }
                    */
                    

                    //Check and add hot words.
                    var keys = model.Keywords.Trim().Split(new char[1] { ' ' });
                    foreach (var k in keys)
                    {
                        if (!String.IsNullOrWhiteSpace(k))
                        {
                            int t = db.HotWords.Count(m => m.KeyWord == k);
                            if (t <= 0)
                            {
                                db.HotWords.Add(new HotWord
                                {
                                    KeyWord = k,
                                    CreatedAt = DateTime.Now,
                                    Hits = 0,
                                    CreatedBy = CurrentUser.Id,
                                });
                            }
                        }
                    }
                    CurrentUser.Score += Constants.UserScore.AddKnowedgeScore;
                    db.SaveChanges();
                    ViewBag.SuccessMessage = "知识添加成功！";
                    Log("添加知识");
                }
            }

            ViewBag.Category = db.Categories.SingleOrDefault(m => m.Id == model.CategoryId).Name;
            ViewBag.Breadcrumbs = setBreadcrumbs(model.CategoryId);
            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteArticle(int id)
        {
            int pid = 0;
            var u = db.Knowledges.SingleOrDefault(m => m.Id == id);
            if (u != null)
            {
                pid = u.CategoryId.Value;
                if (u.Attachment != "" && u.Attachment != null)
                {
                    try
                    {
                        string path = System.Web.HttpContext.Current.Server.MapPath("~" + u.Attachment);
                        FileInfo f = new FileInfo(path);
                        if (f.Exists)
                            f.Delete();
                    }
                    catch (Exception) { }
                }
                db.Knowledges.Remove(u);
                db.SaveChanges();
                Log("删除知识");
                ViewBag.SuccessMessage = "删除知识成功！";
                return RedirectToAction("Category", new { id = pid });
            }
            else
            {
                ModelState.AddModelError("", "找不到指定知识条目");
                return RedirectToAction("Categories");
            }

        }

        public ActionResult EditArticle(int id)
        {
            var model = from row in db.Knowledges
                        where row.Id == id
                        select new KnowledgeViewModel
                        {
                            Id = row.Id,
                            Question = row.Topic,
                            Answer = row.Content,
                            CategoryId = row.CategoryId.Value,
                            Keywords = row.Keywords,
                            Hits = row.Hits.Value,
                            CreatedAt = row.CreatedAt,
                            CreatedBy = row.User.RealName,
                            Attachment = row.Attachment,
                        };
            ViewBag.Breadcrumbs = setBreadcrumbs(model.SingleOrDefault().CategoryId);
            return View(model.SingleOrDefault());
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditArticle(int id, KnowledgeViewModel model)
        {
            if (ModelState.IsValid)
            {
                var c = db.Knowledges.SingleOrDefault(m => m.Id == model.Id);

                //Check and save attachment,
                HttpRequestBase request = this.Request;
                if (request.Files.Count == 1 && !string.IsNullOrWhiteSpace(request.Files[0].FileName))
                {
                    //Check and delete old attachment first
                    if (!string.IsNullOrEmpty(c.Attachment))
                    {
                        try
                        {
                            string path = System.Web.HttpContext.Current.Server.MapPath("~" + c.Attachment);
                            FileInfo f = new FileInfo(path);
                            if (f.Exists)
                                f.Delete();
                        }
                        catch (Exception) { }
                    }
                    //Save new attachment
                    string originalName = (new FileInfo(request.Files[0].FileName)).Name;
                    string fileName = DateTime.Now.ToString("yyyyMMddHHmmss") + "" + originalName.Substring(originalName.LastIndexOf("."));
                    string dir = System.Web.HttpContext.Current.Server.MapPath("~/" + Constants.UploadFolder + DateTime.Now.ToString("yyyyMM"));
                    if (!Directory.Exists(dir))
                    {
                        Directory.CreateDirectory(dir);
                    }
                    request.Files[0].SaveAs(Path.Combine(dir, fileName));
                    c.Attachment = Constants.UploadFolder + DateTime.Now.ToString("yyyyMM") + "/" + fileName;
                }
                c.Topic = model.Question.Trim();
                c.Content = model.Answer.Trim();
                c.Keywords = model.Keywords.Trim();
                db.SaveChanges();

                ViewBag.SuccessMessage = "知识修改成功！";
                Log("修改知识");
                //Check and add hot words.
                var keys = model.Keywords.Trim().Split(new char[1] { ' ' });
                foreach (var k in keys)
                {
                    if (!String.IsNullOrWhiteSpace(k))
                    {
                        int t = db.HotWords.Count(m => m.KeyWord == k);
                        if (t <= 0)
                        {
                            db.HotWords.Add(new HotWord
                            {
                                KeyWord = k,
                                CreatedAt = DateTime.Now,
                                Hits = 0,
                                CreatedBy = CurrentUser.Id,
                            });
                        }
                    }
                    db.SaveChanges();
                }
            }
            var newModel = from row in db.Knowledges
                           where row.Id == id
                           select new KnowledgeViewModel
                           {
                               Id = row.Id,
                               Question = row.Topic,
                               Answer = row.Content,
                               CategoryId = row.CategoryId.Value,
                               Keywords = row.Keywords,
                               Hits = row.Hits.Value,
                               CreatedAt = row.CreatedAt,
                               CreatedBy = row.User.RealName,
                               Attachment = row.Attachment,
                           };
            ViewBag.Breadcrumbs = setBreadcrumbs(newModel.SingleOrDefault().CategoryId);
            return View(newModel.SingleOrDefault());
        }

        public ActionResult HotWords()
        {
            var model = from row in db.HotWords
                        select new KeywordViewModel
                        {
                            Keyword = row.KeyWord,
                            Count = db.Knowledges.Count(m => m.Keywords.Contains(row.KeyWord))
                        };
            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [SmartCMSAuth(Roles = Constants.Roles.ROLE_ADMIN + "," + Constants.Roles.ROLE_CHIEF_EDITOR)]
        public ActionResult DeleteHotWord(string id)
        {
            var r = db.HotWords.SingleOrDefault(m => id.Equals(m.KeyWord));
            Log("删除关键词：" + r.KeyWord);
            db.HotWords.Remove(r);            
            db.SaveChanges();            
            return RedirectToAction("HotWords");
        }

        public ActionResult Search(string id)
        {
            var model = (from r in db.Knowledges
                         where r.Keywords.Contains(id)
                         orderby r.Hits descending
                         select new KnowledgeViewModel
                         {
                             Id = r.Id,
                             Question = r.Topic,
                             CategoryId = r.CategoryId.Value,
                             CategoryName = r.Category.Name,
                             Hits = r.Hits.Value,
                             CreatedAt = r.CreatedAt,
                             CreatedBy = r.User.RealName,
                             Keywords = r.Keywords,
                             Attachment = r.Attachment,
                         });
            return View(model);
        }

        #endregion



        #region 问题管理

        public ActionResult QuestionCategories()
        {
            var model = from row in db.Categories
                        where row.ParentCategoryId == 0
                        orderby row.Id
                        select new CategoryViewModel
                        {
                            Id = row.Id,
                            ParentId = row.ParentCategoryId,
                            Name = row.Name,
                            Comment = row.Comment,
                            PendingQuestionCount = db.Questions.Count(m => m.CategoryId == row.Id && m.Answers.Count(k => k.Accepted) == 0),
                        };

            List<CategoryViewModel> result = new List<CategoryViewModel>();
            for (int i = 0; i < model.Count(); i++)
            {
                CategoryViewModel s = model.ToArray()[i];
                s.SubCategories = setSubCategoires(s);
                result.Add(s);
            }

            return View(result);
        }

        public ActionResult Questions(int? id)
        {
            var topCategory = from row in db.Categories
                        where row.ParentCategoryId == 0
                        orderby row.Id
                        select new CategoryViewModel
                        {
                            Id = row.Id,
                            ParentId = row.ParentCategoryId,
                            Name = row.Name,
                            Comment = row.Comment,
                            PendingQuestionCount = db.Questions.Count(m => m.CategoryId == row.Id && m.Answers.Count(k => k.Accepted) == 0),
                        };

            List<CategoryViewModel> result = new List<CategoryViewModel>();
            for (int i = 0; i < topCategory.Count(); i++)
            {
                CategoryViewModel s = topCategory.ToArray()[i];
                s.SubCategories = setSubCategoires(s);
                result.Add(s);
            }
            ViewBag.Categories = result;

            var model = from row in db.Questions
                        where row.CategoryId == id.Value
                        orderby row.Hits descending
                        select new QuestionViewModel
                        {
                            Id = row.Id,
                            Question = row.Content,
                            CategoryId = row.CategoryId.Value,
                            CategoryName = row.Category.Name,
                            Hits = row.Hits,
                            AnswerCount = row.Answers.Count(),
                            LastAskedAt = row.LastAskedAt,
                        };
            ViewBag.Breadcrumbs = setBreadcrumbs(id.Value);
            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [SmartCMSAuth(Roles = Constants.Roles.ROLE_ADMIN + "," + Constants.Roles.ROLE_CHIEF_EDITOR)]
        public ActionResult DeleteQuestion(int id)
        {
            var u = db.Questions.SingleOrDefault(m => m.Id == id);
            int cid = Constants.Other_Category_Id;
            if (u != null)
            {
                cid = u.CategoryId.Value;
                db.Questions.Remove(u);
                db.SaveChanges();
                Log("删除问题条目");
                ViewBag.SuccessMessage = "问题删除成功！";
            }
            else
            {
                ModelState.AddModelError("", "找不到指定问题条目");
            }
            return RedirectToAction("Questions", new { id = cid});
        }

        public ActionResult Question(int id)
        {
            var q = db.Questions.SingleOrDefault(m => m.Id == id);
            var model = new QuestionViewModel
            {
                Id = q.Id,
                CategoryId = q.CategoryId.Value,
                LastAskedAt = q.LastAskedAt,
                Hits = q.Hits,
                AnswerCount = q.Answers.Count(),
                Question = q.Content,
                CategoryName = q.Category.Name,
                AskedBy = (from u in db.Users
                                      where u.Id == q.CreatedBy
                                      select new UserViewModel
                                      {
                                          ID = u.Id,
                                          Score = u.Score,
                                          RealName = u.RealName,
                                      }).FirstOrDefault(),
                Answers = from a in db.Answers
                          where a.QuestionId == id
                          select new AnswerViewModel
                          {
                              Id = a.Id,
                              Adopted = a.Accepted,
                              AnswerAt = a.AnswerAt,
                              AnswerBy = (from u in db.Users where u.Id == a.AnswerBy
                                          select new UserViewModel
                                          {
                                              ID = u.Id,
                                              Score = u.Score,
                                              RealName = u.RealName,
                                          }).FirstOrDefault(),
                              QuestionId = id,
                              Likes = a.Likes,
                              Unlikes = a.Unlikes,
                              Content = a.Content,
                          },
                BestAnswer = (from a in db.Answers where a.QuestionId==id && a.Accepted
                              select new AnswerViewModel {
                                  Id = a.Id,
                                  Adopted = a.Accepted,
                                  AnswerAt = a.AnswerAt,
                                  AnswerBy = (from u in db.Users
                                              where u.Id == a.AnswerBy
                                              select new UserViewModel
                                              {
                                                  ID = u.Id,
                                                  Score = u.Score,
                                                  RealName = u.RealName,
                                              }).FirstOrDefault(),
                                  QuestionId = id,
                                  Likes = a.Likes,
                                  Unlikes = a.Unlikes,
                                  Content = a.Content,
                              }).SingleOrDefault(),
            };

            var user = CurrentUser;
            ViewBag.CurrentUser = new UserViewModel
            {
                ID = user.Id,
                RealName = user.RealName,
                Score = user.Score,
                LastLoginTime = user.LastLoginTime,
                UserName = user.UserName,
            };

            ViewBag.OtherQuestions = (from r in db.Questions
                         where r.Id != id && r.CategoryId == model.CategoryId
                         orderby r.LastAskedAt                         
                         select new QuestionViewModel
                         {
                             Id = r.Id,
                             Question = r.Content,
                             Hits = r.Hits,
                             LastAskedAt = r.LastAskedAt
                         }).Take(10);

            ViewBag.NoAnswersQuestions = (from r in db.Questions
                                      where r.Id != id && r.Answers.Count == 0
                                      orderby r.LastAskedAt
                                      select new QuestionViewModel
                                      {
                                          Id = r.Id,
                                          Question = r.Content,
                                          Hits = r.Hits,
                                          LastAskedAt = r.LastAskedAt
                                      }).Take(10);

            ViewBag.Breadcrumbs = setBreadcrumbs(q.CategoryId.Value);
            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Answer(int id, QuestionViewModel model)
        {
            if(!string.IsNullOrWhiteSpace(model.Answer))
            {                
                db.Answers.Add(new Answer
                {
                    QuestionId = id,
                    Content = model.Answer.Trim(),
                    Accepted = false,
                    AnswerAt = DateTime.Now,
                    AnswerBy = CurrentUser.Id,  
                });
                CurrentUser.Score += Constants.UserScore.AnswerScore;
                db.SaveChanges();
                Log("回答问题");
                TempData["SuccessMessage"] = "感谢您的回答。";
            }
            else
            {
                TempData["ErrorMessage"] = "感谢您的回答。";
            }
            
            return RedirectToAction("Question", new { id = id });
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteAnswer(int id)
        {
            Answer answer = db.Answers.SingleOrDefault(m => m.Id == id);
            int qid = answer.QuestionId.Value;
            if(answer != null)
            {
                if(CurrentUser.UserRole.Role==Constants.Roles.ROLE_ADMIN ||
                    CurrentUser.UserRole.Role==Constants.Roles.ROLE_CHIEF_EDITOR ||
                    CurrentUser.Id == answer.AnswerBy)
                {
                    db.Answers.Remove(answer);
                    db.SaveChanges();
                    TempData["SuccessMessage"] = "回答删除成功";
                    Log("删除回答");
                }
                else
                {
                    TempData["ErrorMessage"] = "错误，您没有删除该回答的权限";
                }
            }
            return RedirectToAction("Question", new { id = qid});
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        [SmartCMSAuth(Roles = Constants.Roles.ROLE_ADMIN + "," + Constants.Roles.ROLE_CHIEF_EDITOR)]
        public ActionResult AdoptAnswer(int id)
        {
            Answer answer = db.Answers.SingleOrDefault(m => m.Id == id);
            int qid = answer.QuestionId.Value;
            if (answer != null)
            {
                if (CurrentUser.UserRole.Role == Constants.Roles.ROLE_ADMIN ||
                    CurrentUser.UserRole.Role == Constants.Roles.ROLE_CHIEF_EDITOR )
                {
                    var others = db.Answers.Where(m => m.QuestionId == qid && m.Accepted);
                    foreach(var a in others)
                    {
                        a.Accepted = false;
                    }
                    answer.Accepted = true;
                    var u = answer.User;
                    u.Score += Constants.UserScore.AdoptedScore;
                    db.SaveChanges();
                    Log("采纳最佳回答");
                    TempData["SuccessMessage"] = "回答采纳成功，点击#这里#把该问题收入知识库";                    
                }
                else
                {
                    TempData["ErrorMessage"] = "错误，您没有采纳该回答的权限";
                }
            }
            return RedirectToAction("Question", new { id = qid });
        }        

        [HttpGet]
        public JsonResult LikeAnswer(int id)
        {
            Answer a = db.Answers.SingleOrDefault(m=>m.Id == id);            
            int k = 0;
            if(a != null)
            {
                a.Likes++;
                a.User.Score += Constants.UserScore.LikeScore;
                db.SaveChanges();
                k = a.Likes;
            }
            return Json(k, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public JsonResult UnlikeAnswer(int id)
        {
            Answer a = db.Answers.SingleOrDefault(m => m.Id == id);
            int k = 0;
            if (a != null)
            {                
                a.Unlikes++;
                if(a.User.Score>0)
                    a.User.Score -= Constants.UserScore.UnlikeScore;
                db.SaveChanges();
                k = a.Unlikes;                
            }
            return Json(k, JsonRequestBehavior.AllowGet);
        }

        #endregion



        #region 私有函数

        //Private Functions
        private List<string> setBreadcrumbs(int id)
        {
            //Breadcrumbs
            var c = db.Categories.SingleOrDefault(m => m.Id == id);
            var breadcrumbs = new List<string>();
            if (c == null)
                return breadcrumbs;
            breadcrumbs = addParentLinks(breadcrumbs, c);
            breadcrumbs.Add(c.Id + "#" + c.Name);
            return breadcrumbs;
        }

        private List<string> addParentLinks(List<string> links, Category category)
        {
            if (category.ParentCategoryId == 0)
                return links;

            var pc = db.Categories.SingleOrDefault(m => m.Id == category.ParentCategoryId);
            if (pc != null)
            {
                links.Add(pc.Id + "#" + pc.Name);
                links = addParentLinks(links, pc);
            }
            return links;
        }

        private IEnumerable<CategoryViewModel> setSubCategoires(CategoryViewModel c)
        {
            var subCategories = from row in db.Categories
                                where row.ParentCategoryId == c.Id
                                orderby row.Id
                                select new CategoryViewModel
                                {
                                    Id = row.Id,
                                    ParentId = row.ParentCategoryId,
                                    Name = row.Name,
                                    Comment = row.Comment,
                                    PendingQuestionCount = db.Questions.Count(m => m.CategoryId == row.Id && m.Answers.Count(k=>k.Accepted)==0),
                                };

            List<CategoryViewModel> r = new List<CategoryViewModel>();
            if (subCategories != null)
            {                
                foreach(var s in subCategories)
                {                    
                    s.SubCategories = setSubCategoires(s);
                    r.Add(s);
                }                
            }
            return r;
        }



        #endregion


    }
}
