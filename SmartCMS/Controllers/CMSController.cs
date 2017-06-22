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
                             };
            return View(model);
        }

        public ActionResult AddCategory(int? pid)
        {
            var model = new CategoryViewModel
            {
                ParentId = pid.HasValue? pid.Value : 0,
            };
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
            return View(model);
        }

    }
}
