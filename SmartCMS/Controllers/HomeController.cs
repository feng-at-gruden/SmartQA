using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using SmartCMS.Filters;
using SmartCMS.Models;

namespace SmartCMS.Controllers
{
    public class HomeController : BaseController
    {

        [SmartCMSAuth]
        public ActionResult Index()
        {
            var rootCategories = from r in db.Categories
                        where r.ParentCategory == 0
                        select new CategoryViewModel
                        {
                            Id = r.Id,
                            Name = r.Name,                            
                        };
            var model = new List<CategoryViewModel>();
            foreach(var m in rootCategories)
            {
                m.SubCategories = from sr in db.Categories
                                  where sr.ParentCategory == m.Id
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
                        where r.ParentCategory == id
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
            var model = (from r in db.Articles
                        where r.Category == id
                        orderby r.Hits descending                        
                        select new ArticleViewModel
                        {
                            Id = r.Id,
                            Question = r.Question,
                        }).Take(k);

            return Json(model, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public JsonResult Search(int? id, string question)
        {            
            var model = (from r in db.Articles
                         where r.Keywords.Contains(question)
                         orderby r.Hits descending
                         select new ArticleViewModel
                         {
                             Id = r.Id,
                             Question = r.Question,
                             CategoryId = r.Category.Value
                         });
            if(model.Count()<10)
            {
                var m2 = (from r in db.Articles
                          where r.Question.Contains(question)
                          orderby r.Hits descending
                          select new ArticleViewModel
                          {
                              Id = r.Id,
                              Question = r.Question,
                              CategoryId = r.Category.Value
                          });
                model = model.Concat(m2);
            }
            model = model.Distinct();

            if (id > 0)
                model = model.Where(m => m.CategoryId == id);
            
            return Json(model.Take(10), JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public JsonResult Submit(int? id, string question)
        {
            //record not entered questions
            question = question.Trim();
            if (!String.IsNullOrWhiteSpace(question))
            {
                int t = db.PendingQuestions.Count(m => m.Question == question);
                if (t <= 0)
                {
                    int cid = id.HasValue && id.Value > 0 ? id.Value : Constants.Other_Category_Id;
                    db.PendingQuestions.Add(new PendingQuestion
                    {
                        Question = question,
                        LastAskedAt = DateTime.Now,
                        Hits = 1,
                        CreatedBy = CurrentUser.Id,
                        CategoryId = cid,
                    });
                    db.SaveChanges();
                }
                else
                {
                    var un = db.PendingQuestions.SingleOrDefault(m => m.Question == question);
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
            var r = db.Articles.SingleOrDefault(m => m.Id == id);
            if(r!=null)
            {
                r.Hits++;
                db.SaveChanges();
                var model = new ArticleViewModel
                {
                    Id = r.Id,
                    Question = r.Question,
                    Answer = r.Answer,
                    Keywords = r.Keywords,
                    CategoryId = r.Category.Value,
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
            var model = (from r in db.Articles
                         where r.Question.Contains(q)
                         orderby r.Hits descending
                         select new ArticleViewModel
                         {
                             Id = r.Id,
                             Question = r.Question,
                             CategoryId = r.Category.Value
                         });
            
            if (id > 0)
                model = model.Where(m => m.CategoryId == id);

            return Json(model.Take(15));
        }

    }
}
