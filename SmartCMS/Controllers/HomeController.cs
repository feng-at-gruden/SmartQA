using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using SmartCMS.Filters;
using SmartCMS.Models;
using SmartCMS.Helper;

namespace SmartCMS.Controllers
{
    public class HomeController : BaseController
    {

        [SmartCMSAuth]
        public ActionResult Index()
        {
            var rootCategories = from r in db.Categories
                        where r.ParentCategoryId == 0
                        select new CategoryViewModel
                        {
                            Id = r.Id,
                            Name = r.Name,                            
                        };
            var model = new List<CategoryViewModel>();
            foreach(var m in rootCategories)
            {
                m.SubCategories = from sr in db.Categories
                                  where sr.ParentCategoryId == m.Id
                                  select new CategoryViewModel
                                  {
                                      Id = sr.Id,
                                      Name = sr.Name,
                                  };
                model.Add(m);
            }
            return View(model);
        }

        [HttpGet]
        public JsonResult GetCategories(int? id)
        {
            var model = from r in db.Categories
                        where r.ParentCategoryId == id
                        select new CategoryViewModel
                        {
                            Id = r.Id,
                            Name = r.Name,
                        };

            return Json(model, JsonRequestBehavior.AllowGet);
        }


        [HttpGet]
        public JsonResult GetCategoryHotTopic(int? id, int? max)
        {
            int k = max.HasValue ? max.Value : 10;
            
            var ids = getSubCategoryIds(id.Value);
            ids.Add(id.Value);            
            var model = (from r in db.Knowledges
                         where ids.Contains(r.CategoryId.Value)
                        orderby r.Hits descending                        
                        select new KnowledgeViewModel
                        {
                            Id = r.Id,
                            Question = r.Topic,
                        }).Take(k);

            return Json(model, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public JsonResult Search(int? id, string question)
        {            
            var model = (from r in db.Knowledges
                         where r.Keywords.Contains(question)
                         orderby r.Hits descending
                         select new KnowledgeViewModel
                         {
                             Id = r.Id,
                             Question = r.Topic,
                             CategoryId = r.CategoryId.Value
                         });
            if(model.Count()<10)
            {
                var m2 = (from r in db.Knowledges
                          where r.Topic.Contains(question)
                          orderby r.Hits descending
                          select new KnowledgeViewModel
                          {
                              Id = r.Id,
                              Question = r.Topic,
                              CategoryId = r.CategoryId.Value
                          });
                model = model.Concat(m2);
            }
            model = model.Distinct();

            if (id > 0)
            {
                var ids = getSubCategoryIds(id.Value);
                ids.Add(id.Value);
                model = from k in model  
                              where ids.Contains(k.CategoryId)
                              select new KnowledgeViewModel
                              {
                                  Id = k.Id,
                                  Question = k.Question,
                                  CategoryId = k.CategoryId
                              }; 
            }
            return Json(model.Take(10), JsonRequestBehavior.AllowGet);
        }

        private List<int> getSubCategoryIds(int id)
        {
            List<int> result = new List<int>();
            var c = db.Categories.SingleOrDefault(m => m.Id == id);
            if(c !=null)
            {
                var sc = db.Categories.Where(m => m.ParentCategoryId == id);
                if(sc !=null )
                {
                    foreach(var k in sc)
                    {
                        result.Add(k.Id);
                        var ssc = getSubCategoryIds(k.Id);
                        if (ssc.Count() > 0)
                            result.AddRange(ssc);
                    }
                }
            }
            return result;
        }

        [HttpGet]
        public JsonResult Submit(int? id, string question)
        {
            //record not entered questions
            question = question.Trim();
            if (!String.IsNullOrWhiteSpace(question))
            {
                int t = db.Questions.Count(m => m.Content == question);
                if (t <= 0)
                {
                    int cid = id.HasValue && id.Value > 0 ? id.Value : Constants.Other_Category_Id;
                    db.Questions.Add(new Question
                    {
                        Content = question,
                        LastAskedAt = DateTime.Now,
                        Hits = 1,
                        CreatedBy = CurrentUser.Id,
                        CategoryId = cid,
                    });
                    db.SaveChanges();
                }
                else
                {
                    var un = db.Questions.SingleOrDefault(m => m.Content == question);
                    un.Hits++;
                    un.LastAskedAt = DateTime.Now;
                    db.SaveChanges();
                }
            }
            return Json(new { MSG = "OK" }, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public JsonResult View(int id)
        {
            var r = db.Knowledges.SingleOrDefault(m => m.Id == id);
            if(r!=null)
            {
                r.Hits++;
                db.SaveChanges();
                var model = new KnowledgeViewModel
                {
                    Id = r.Id,
                    Question = r.Topic,
                    Answer = r.Content,
                    Keywords = r.Keywords,
                    CategoryId = r.CategoryId.Value,
                    Attachment = r.Attachment,
                };
                return Json(model, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json("找不到问答条目", JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        public JsonResult Hints(int id, string q)
        {
            q = q.Trim();
            var model = (from r in db.Knowledges
                         where r.Topic.Contains(q)
                         orderby r.Hits descending
                         select new KnowledgeViewModel
                         {
                             Id = r.Id,
                             Question = r.Topic,
                             CategoryId = r.CategoryId.Value
                         });

            if (id > 0)
            {
                var ids = getSubCategoryIds(id);
                ids.Add(id);
                model = from k in model
                        where ids.Contains(k.CategoryId)
                        select new KnowledgeViewModel
                        {
                            Id = k.Id,
                            Question = k.Question,
                            CategoryId = k.CategoryId
                        };
            }
            return Json(model.Take(15), JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public JsonResult Chat(string q)
        {
            var k = ChatHelper.GetAnswer(q);
            return Json(k, JsonRequestBehavior.AllowGet);
        }

    }
}
