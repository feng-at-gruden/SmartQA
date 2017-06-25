using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SmartCMS.Filters;
using SmartCMS.Models;

namespace SmartCMS.Controllers
{
    [SmartCMSAuth(Roles = Constants.Roles.ROLE_ADMIN + "," + Constants.Roles.ROLE_EDITOR)]
    public class CMSController : BaseController
    {
        
        public ActionResult Categories()
        {
            var model = from row in db.Categories
                        where row.ParentCategory == 0
                        orderby row.Name
                        select new CategoryViewModel
                        {
                            Id = row.Id,
                            ParentId = row.ParentCategory,
                            Name = row.Name,
                            Comment = row.Comment,                            
                        };            
            return View(model);
        }

        public ActionResult Category(int id)
        {
            var categories = from row in db.Categories
                        where row.Id == id                        
                        select new CategoryViewModel
                        {
                            Id = row.Id,
                            ParentId = row.ParentCategory,
                            Name = row.Name,
                            Comment = row.Comment,                            
                        };

            var model = categories.SingleOrDefault();
            model.SubCategories = from sr in db.Categories
                                    where sr.ParentCategory == model.Id
                                    orderby sr.Name
                                    select new CategoryViewModel
                                    {
                                        Id = sr.Id,
                                        ParentId = sr.ParentCategory,
                                        Name = sr.Name,
                                        Comment = sr.Comment,
                                    };
            model.Articles = from a in db.Articles
                             where a.Category == model.Id
                             orderby a.Question
                             select new ArticleViewModel
                             {
                                 Id = a.Id,
                                 CategoryId = a.Category.Value,
                                 Question = a.Question,
                                 Answer = a.Answer,
                                 Hits = a.Hits.Value,
                                 Keywords = a.Keywords,
                                 CreatedAt = a.CreatedAt,
                                 CreatedBy = a.Users.RealName
                             };
            return View(model);
        }

        public ActionResult AddCategory(int? id)
        {
            var model = new CategoryViewModel
            {
                ParentId = id.HasValue? id.Value : 0,
            };
            if (id > 0)
                ViewBag.Category = db.Categories.SingleOrDefault(m=>m.Id == id).Name;
            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AddCategory(CategoryViewModel model)
        {
            if (string.IsNullOrWhiteSpace(model.Name))
                ModelState.AddModelError("", "请输入分类名称");
            if (ModelState.IsValid)
            {
                model.Name = model.Name.Trim();
                var i = db.Categories.Count(m => m.Name.Equals(model.Name, StringComparison.OrdinalIgnoreCase) && m.ParentCategory == model.ParentId);
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
                        ParentCategory = model.ParentId,
                    });
                    db.SaveChanges();
                    ViewBag.SuccessMessage = "问题分类添加成功！";
                    Log("添加分类:" + model.Name);
                }
            }
            if (model.ParentId > 0)
                ViewBag.Category = db.Categories.SingleOrDefault(m => m.Id == model.ParentId).Name;
            return View(model);
        }

        public ActionResult EditCategory(int id)
        {
            var model = from row in db.Categories
                        where row.Id == id
                        select new CategoryViewModel
                        {
                            Id = row.Id,
                            Name = row.Name,
                            Comment = row.Comment,
                            ParentId = row.ParentCategory,
                            CreatedAt = row.CreatedAt,
                            CreatedBy = row.Users.RealName,
                        };
            ViewBag.Category = db.Categories.SingleOrDefault(m => m.Id == id).Name;
            return View(model.SingleOrDefault());
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
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
                            ParentId = row.ParentCategory,
                            CreatedAt = row.CreatedAt,
                            CreatedBy = row.Users.RealName,
                        };
            ViewBag.Category = db.Categories.SingleOrDefault(m => m.Id == id).Name;
            return View(newModel.SingleOrDefault());            
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteCategory(int id)
        {
            var u = db.Categories.SingleOrDefault(m => m.Id == id);
            if (u != null)
            {
                var c = db.Categories.Where(m => m.ParentCategory == id);
                if (c.Count() > 0 || u.Articles.Count() > 0)
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

        public ActionResult AddArticle(int id)
        {
            var model = new ArticleViewModel
            {
                CategoryId = id,
            };
            ViewBag.Category = db.Categories.SingleOrDefault(m => m.Id == id).Name;
            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AddArticle(ArticleViewModel model)
        {
            if (ModelState.IsValid)
            {
                model.Question = model.Question.Trim();
                var i = db.Articles.Count(m => m.Question.Equals(model.Question, StringComparison.OrdinalIgnoreCase) && m.Category == model.CategoryId);
                if (i > 0)
                {
                    ModelState.AddModelError("", "同类别下相同问答已经存在，请勿重复添加!");
                }
                else
                {
                    db.Articles.Add(new Article
                    {
                        Question = model.Question,
                        Answer = model.Answer,
                        Keywords = model.Keywords,
                        Hits = 0,
                        CreatedAt = DateTime.Now,
                        CreatedBy = CurrentUser.Id,
                        Category = model.CategoryId,
                    });
                    db.SaveChanges();
                    ViewBag.SuccessMessage = "问答添加成功！";
                    Log("添加问答");
                }
            }
            
            ViewBag.Category = db.Categories.SingleOrDefault(m => m.Id == model.CategoryId).Name;
            return View(model);            
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteArticle(int id)
        {
            int pid = 0;
            var u = db.Articles.SingleOrDefault(m => m.Id == id);           
            if (u != null)
            {
                pid = u.Category.Value;
                db.Articles.Remove(u);
                db.SaveChanges();
                Log("删除问答");
                ViewBag.SuccessMessage = "删除问答成功！";                
            }
            else
            {
                ModelState.AddModelError("", "找不到指定问答");
            }
            return RedirectToAction("Category", new { id = pid });
        }

        public ActionResult EditArticle(int id)
        {
            var model = from row in db.Articles
                        where row.Id == id
                        select new ArticleViewModel
                        {
                            Id = row.Id,
                            Question = row.Question,
                            Answer = row.Answer,
                            CategoryId = row.Category.Value,
                            Keywords = row.Keywords,
                            Hits = row.Hits.Value,
                            CreatedAt = row.CreatedAt,
                            CreatedBy = row.Users.RealName,
                        };            
            return View(model.SingleOrDefault());
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditArticle(int id, ArticleViewModel model)
        {            
            if (ModelState.IsValid)
            {
                var c = db.Articles.SingleOrDefault(m => m.Id == model.Id);
                c.Question = model.Question.Trim();
                c.Answer = model.Answer.Trim();
                c.Keywords = model.Keywords.Trim();
                db.SaveChanges();
                ViewBag.SuccessMessage = "问答修改成功！";
                Log("修改问答");
            }
            var newModel = from row in db.Articles
                           where row.Id == id
                           select new ArticleViewModel
                           {
                               Id = row.Id,
                               Question = row.Question,
                               Answer = row.Answer,
                               CategoryId = row.Category.Value,
                               Keywords = row.Keywords,
                               Hits = row.Hits.Value,
                               CreatedAt = row.CreatedAt,
                               CreatedBy = row.Users.RealName,
                           };
            return View(newModel.SingleOrDefault());
        }

    }
}
