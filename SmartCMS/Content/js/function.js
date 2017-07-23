function ask() {
    var q = $('#myQuestion').val();
    if (q == '')
        return;
    var t = new Date().Format("hh:mm:ss");  
    var c = questionTemplate.replace('##CONTENT##', q);
    c = c.replace('##TIME##', t);
    var html = $("#chat-content-container").html() + c;
    $("#chat-content-container").html(html);

    var k = $("#chat-content-container")[0].scrollHeight;
    $("#chat-content-container").scrollTop(k);
    $('#myQuestion').val('')
    //Call ajax
    Search(q);
}

function displayResponse(answer)
{
    var t = new Date().Format("hh:mm:ss");
    var c = answerTemplate.replace('##CONTENT##', answer);
    c = c.replace('##TIME##', t);
    var html = $("#chat-content-container").html() + c + clearTemplate;
    $("#chat-content-container").html(html);

    var k = $("#chat-content-container")[0].scrollHeight;
    $("#chat-content-container").scrollTop(k);
}

function getCategories(id) {
    loading(true);
    $.getJSON("/Home/GetCategories?id=" + id, function (result) {
        loading(false);
        $("#TabCategory").html("");
        $.each(result, function (i, field) {
            $("#TabCategory").append("<a href='javascript:getCategories(" + field.Id + ")'>" + field.Name + "</a>");
        });
    });
}

function getHotTopic(id, name) {
    loading(true);
    $.getJSON("/Home/GetCategoryHotTopic?id=" + id, function (result) {
        loading(false);
        if (result.length > 0) {
            var html = name + "常见问题: <ol class='result'>";
            $.each(result, function (i, field) {
                html += "<li><a href='javascript:Interpret(" + field.Id + ",\"" + field.Question + "\", false)'>" + field.Question + "</a></li>";
            });
            html += "</ol>";
            displayResponse(html);
        }
    });
}

//热点问题
function pullHotQuestions(id, name) {
    loading(true);
    $.getJSON("/Home/GetCategoryHotQuestion?id=" + id + "&max=20", function (result) {
        loading(false);
        var html;
        if (result.length > 0) {
            html = name + "常见问题: <ol class='result'>";
            $.each(result, function (i, field) {
                html += "<li><a href='javascript:Interpret(" + field.Id + ",\"" + field.Question + "\", true)' >" + field.Question + "</a></li>";
            });
            html += "</ol>";
        }
        else {
            html = name + "暂无收录问答。";
        }
        html += "<br /><a href='javascript:hotTopicBack();'>返回</a>"
        $("#TabHotTopic").html(html);
    });
}

function Search(keyword)
{
    loading(true);
    $.getJSON("/Home/Search?id=" + selectedCategoryId + "&question=" + keyword, function (result) {
        loading(false);
        if (result.length > 0) {
            var html = name + "系统中有以下答案匹配您的问题: <ol class='result'>";
            $.each(result, function (i, field) {
                html += "<li><a href='javascript:Interpret(" + field.Id + ",\"" + field.Question + "\", false)' target='_blank'>" + field.Question + "</a></li>";
            });
            html += "</ol> <p style='margin-top:10px;'>不知道有没有帮到你呢？<a href='javascript:Resolved();'><img src='/content/images/veryGood1.png'>已解决</a> <a href='javascript:Unresolved(" + selectedCategoryId + ", \"" + keyword + "\");'><img src='/content/images/veryGood2.png'>未解决(收录)</a> </p>";
            displayResponse(html);
        } else {
            //Call chat robot
            loading(false);
            $.getJSON("/Home/Chat?q=" + keyword, function (result) {
                loading(false);
                if (result) {
                    var html = result;
                    displayResponse(html);
                } else {
                    displayResponse("好尴尬，这个问题我还不知道要怎么样回答你哦 >_<||| &nbsp;&nbsp;&nbsp;&nbsp;点击<a href='javascript:Unresolved(" + selectedCategoryId + ",\"" + keyword + "\");'><b>这里</b></a>把待解决的问题收录到知识库吧。");
                }
            });
            //displayResponse("好尴尬，这个问题我还不知道要怎么样回答你哦 >_<||| &nbsp;&nbsp;&nbsp;&nbsp;点击<a href='javascript:Unresolved(" + selectedCategoryId + ",\"" + keyword + "\");'><b>这里</b></a>把待解决的问题收录到知识库吧。");
        }
    });
}

function loading(show)
{
    if (show) {
        $('#chat-content-container').removeClass('loaded');
        $('#chat-content-container').addClass('loading');
    } else {
        $('#chat-content-container').removeClass('loading');
        $('#chat-content-container').addClass('loaded');
    }
}

function Resolved()
{
    displayResponse("能够帮助到您，我真的好开心! O(∩_∩)O  &nbsp;&nbsp;&nbsp;&nbsp;如果您还有其他问题请继续提问。");
    selectCategory("全部分类", 0);
}

function Unresolved(id, q)
{
    loading(true);
    $.getJSON("/Home/Submit/" + id + "?question=" + q, function (result) {
        loading(false);
        if (result) {
            var html = "问题已收录入知识库，谢谢您的支持，我会继续努力的！ (@^_^@)"
            displayResponse(html);
        } 
    });
}

function ViewAnswer(id, isQuestion) {
    loading(true);
    var url = "/Home/ViewKnowedge/" + id;
    if (isQuestion)
        url = "/Home/ViewQuestion/" + id
    $.getJSON(url, function (result) {
        loading(false);
        if (result) {
            var html = result.Answer.replace(/\r/g, "<br>");
            if (result.Attachment != "" && result.Attachment != null)
            {
                html += "<p style='margin:10px 0 0 0px;'> 点击<a href='" + result.Attachment + "' target='_blank'><b>这里</b></a>查看附件 </p>"
            }
            html += "<p style='margin-top:10px;'> 以上答案是否解决了您的问题？ <a href='javascript:Resolved();'><img src='/content/images/veryGood1.png'>已解决</a> <a href='javascript:Unresolved("+result.CategoryId+",\""+result.Question+"\");'><img src='/content/images/veryGood2.png'>未解决(收录)</a> </p>";
            displayResponse(html);
        } else {
            displayResponse("找不到这个问题的答案呢 (=@__@=) ");
        }
    });
}

function Interpret(id, q, isQuestion)
{
    var t = new Date().Format("hh:mm:ss");
    var c = questionTemplate.replace('##CONTENT##', q);
    c = c.replace('##TIME##', t);
    var html = $("#chat-content-container").html() + c;
    $("#chat-content-container").html(html);

    var k = $("#chat-content-container")[0].scrollHeight;
    $("#chat-content-container").scrollTop(k);
    $('#myQuestion').val('')
    //Call ajax
    ViewAnswer(id, isQuestion);
}

function selectCategory(name, id)
{
    if (selectedCategoryId == id)
        return;
    selectedCategoryId = id;
    $('#current-category').html("当前问题分类: " + name);
    resetAutoComplete();

    if (id > 0) {
        displayResponse("您已选择问题分类：" + name);
        //Display category hot topic
        getHotTopic(id, name);
    }
}

function resetAutoComplete()
{
    //Update autocomplete
    $('#myQuestion').autocomplete("option", "source",
        function (request, response) {
            loading(true);
            $.ajax({
                url: "/Home/Hints/" + selectedCategoryId,
                type: "post",
                dataType: "json",
                data: { q: request.term },
                success: function (data) {
                    loading(false);
                    response($.map(data, function (item) {
                        return {
                            label: item.Question,
                            value: item.Question,
                            Id: item.Id,
                            CategoryId: item.CategoryId
                        }
                    }));
                } //end  success
            }); //end ajax
        });
}

var hotTopicCategpriesHtml = "";
function showHotQuestions(name, id)
{
    if (selectedCategoryId != id)
        displayResponse("您已选择问题分类：" + name);

    hotTopicCategpriesHtml = $('#TabHotTopic').html();
    selectedCategoryId = id;
    resetAutoComplete();
    $('#current-category').html("当前问题分类: " + name);
    
    //Display category hot topic
    pullHotQuestions(id, name);
}

function hotTopicBack()
{
    $('#TabHotTopic').html(hotTopicCategpriesHtml);
}

Date.prototype.Format = function (fmt) { //author: meizz 
    var o = {
        "M+": this.getMonth() + 1, //月份 
        "d+": this.getDate(), //日 
        "h+": this.getHours(), //小时 
        "m+": this.getMinutes(), //分 
        "s+": this.getSeconds(), //秒 
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
        "S": this.getMilliseconds() //毫秒 
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
        if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}

function addFavorite() {
    var url = window.location;
    var title = document.title;
    var ua = navigator.userAgent.toLowerCase();
    if (ua.indexOf("360se") > -1) {
        alert("由于360浏览器功能限制，请按 Ctrl+D 手动收藏！");
    }
    else if (ua.indexOf("msie 8") > -1) {
        window.external.AddToFavoritesBar(url, title); //IE8
    }
    else if (document.all) {
        try {
            window.external.addFavorite(url, title);
        } catch (e) {
            alert('您的浏览器不支持,请按 Ctrl+D 手动收藏!');
        }
    }
    else if (window.sidebar) {
        window.sidebar.addPanel(title, url, "");
    }
    else {
        alert('您的浏览器不支持,请按 Ctrl+D 手动收藏!');
    }
}



//var answerTemplate = '<div class="chat-answer"><span class="answer-name">智能客服 ##TIME##</span><div class="answer-content">##CONTENT##</div></div>';
var answerTemplate = '<div class="chat-answer"><div class="answer-name">智库</div><div class="answer-content-after"></div><div class="answer-content">##CONTENT##</div></div>';
var questionTemplate = '<div class="chat-question"><span class="question-name">我</span><div class="question-content-after"></div><div class="question-content">##CONTENT##</div></div>';
var clearTemplate = '<div class="clear" style="height:10px;"></div>';

var selectedCategoryId;

$(document).ready(function () {

    $('#myQuestion').autocomplete({
        messages: {
            noResults: '',
            results: function () { }
        },
        minLength: 1,
        appendTo: "#chat-input-container",
        position: { my: "left bottom", at: "left top", collision: "none" },
        select: function (event, ui) {
            Interpret(ui.item.Id, ui.item.label, false);            
            return false;
        },         
    });

    $('#myQuestion').keydown(function (e) {
        if (e.keyCode == 13) {
            ask();
        }
    });

    selectCategory("全部分类", 0);
});