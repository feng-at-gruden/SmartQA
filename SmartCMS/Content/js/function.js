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
    $.getJSON("/Home/GetCategories?id=" + id, function (result) {
        $("#TabCategory").html("");
        $.each(result, function (i, field) {
            $("#TabCategory").append("<a href='javascript:getCategories(" + field.Id + ")'>" + field.Name + "</a>");
        });
    });
}

function getHotTopic(id, name) {
    $.getJSON("/Home/GetCategoryHotTopic?id=" + id, function (result) {        
        if (result.length > 0) {
            var html = name + "常见问题: <ol class='result'>";
            $.each(result, function (i, field) {
                html += "<li><a href='javascript:Interpret(" + field.Id + ",\"" + field.Question + "\")'>" + field.Question + "</a></li>";
            });
            html += "</ol>";
            displayResponse(html);
        }
    });
}

//热点问题
function getHotTopic2(id, name) {
    $.getJSON("/Home/GetCategoryHotTopic?id=" + id + "&max=20", function (result) {
        var html;
        if (result.length > 0) {
            html = name + "常见问题: <ol class='result'>";
            $.each(result, function (i, field) {
                html += "<li><a href='javascript:Interpret(" + field.Id + ",\"" + field.Question + "\")' >" + field.Question + "</a></li>";
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
    $.getJSON("/Home/Search?id=" + selectedCategoryId + "&question=" + keyword, function (result) {
        if (result.length > 0) {
            var html = name + "系统中有以下答案匹配您的问题: <ol class='result'>";
            $.each(result, function (i, field) {
                html += "<li><a href='javascript:Interpret(" + field.Id + ",\"" + field.Question + "\")' target='_blank'>" + field.Question + "</a></li>";
            });
            html += "</ol> <p style='margin-top:10px;'>不知道有没有帮到你呢？<a href='javascript:Resolved();'><img src='/content/images/veryGood1.png'>已解决</a> <a href='javascript:Unresolved(" + selectedCategoryId + ", \"" + keyword + "\");'><img src='/content/images/veryGood2.png'>未解决(收录)</a> </p>";
            displayResponse(html);
        } else {
            //Save questions not entered in db;            
            displayResponse("好尴尬，这个问题我还不知道要怎么样回答你哦 >_<||| &nbsp;&nbsp;&nbsp;&nbsp;点击<a href='javascript:Unresolved(" + selectedCategoryId + ",\"" + keyword + "\");'><b>这里</b></a>把待解决的问题收录到知识库吧。");
        }
    });
}

function Resolved()
{
    displayResponse("能够帮助到您，我真的好开心! O(∩_∩)O  &nbsp;&nbsp;&nbsp;&nbsp;如果您还有其他问题请继续提问。");
}

function Unresolved(id, q)
{
    $.getJSON("/Home/Submit/" + id + "?question=" + q, function (result) {
        if (result) {
            var html = "问题已收录入知识库，谢谢您的支持，我会继续努力的！ (@^_^@)"
            displayResponse(html);
        } 
    });
}

function ViewAnswer(id) {
    $.getJSON("/Home/View/" + id, function (result) {
        if (result) {
            var html = result.Answer.replace(/\r/g, "<br>");
            html += "<p style='margin-top:10px;'> 以上答案是否解决了您的问题？ <a href='javascript:Resolved();'><img src='/content/images/veryGood1.png'>已解决</a> <a href='javascript:Unresolved("+result.CategoryId+",\""+result.Question+"\");'><img src='/content/images/veryGood2.png'>未解决(收录)</a> (@^_^@)</p>";
            displayResponse(html);
        } else {
            displayResponse("找不到这个问题的答案呢 (=@__@=) ");
        }
    });
}

function Interpret(id, q)
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
    ViewAnswer(id);
}

function selectCategory(name, id)
{
    if (selectedCategoryId == id)
        return;
    selectedCategoryId = id;
    $('#current-category').html("当前问题分类: " + name);
    displayResponse("您已选择问题分类：" + name);
    //Display category hot topic
    getHotTopic(id, name);
}

var hotTopicCategpriesHtml = "";
function showHotTopic(name, id)
{
    if (selectedCategoryId != id)
        displayResponse("您已选择问题分类：" + name);

    hotTopicCategpriesHtml = $('#TabHotTopic').html();
    selectedCategoryId = id;
    $('#current-category').html("当前问题分类: " + name);
    
    //Display category hot topic
    getHotTopic2(id, name);
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

//var answerTemplate = '<div class="chat-answer"><span class="answer-name">智能客服 ##TIME##</span><div class="answer-content">##CONTENT##</div></div>';
var answerTemplate = '<div class="chat-answer"><div class="answer-name">智库</div><div class="answer-content-after"></div><div class="answer-content">##CONTENT##</div></div>';
var questionTemplate = '<div class="chat-question"><span class="question-name">我</span><div class="question-content-after"></div><div class="question-content">##CONTENT##</div></div>';
var clearTemplate = '<div class="clear" style="height:10px;"></div>';