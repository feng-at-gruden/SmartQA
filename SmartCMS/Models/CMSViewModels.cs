using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity;
using System.Globalization;
using System.Web.Security;

namespace SmartCMS.Models
{


    public class CategoryViewModel
    {

        public int Id { get; set; }
        public int ParentId { get; set; }

        [Display(Name = "分类名")]
        public string Name { get; set; }

        [Display(Name = "备注")]
        public string Comment { get; set; }

        [Display(Name = "子类别")]
        public IEnumerable<CategoryViewModel> SubCategories { get; set; }

        public IEnumerable<ArticleViewModel> Articles { get; set; }

        public String CreatedBy { get; set; }

        public DateTime? CreatedAt { get; set; }
    }


    public class ArticleViewModel
    {
        public int Id { get; set; }
        public int CategoryId { get; set; }
        public String CategoryName { get; set; }
        public int PendingId { get; set; }

        [Required(ErrorMessage = "请输入问题")]
        [Display(Name = "问题")]
        public string Question { get; set; }

        [Required(ErrorMessage = "请输入解答")]
        [Display(Name = "解答")]
        public string Answer { get; set; }

        [Required(ErrorMessage = "请输入问题关键字")]
        [Display(Name = "关键字")]
        public string Keywords { get; set; }

        [Display(Name = "热度")]
        public int Hits { get; set; }

        public String CreatedBy { get; set; }

        public DateTime? CreatedAt { get; set; }
    }





}