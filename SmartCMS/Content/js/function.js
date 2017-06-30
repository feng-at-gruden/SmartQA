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
                html += "<li><a href='javascript:Interpret(" + field.Id + ",\"" + field.Question + "\")' target='_blank'>" + field.Question + "</a></li>";
            });
            html += "</ol>";
            displayResponse(html);
        }
    });
}

function Search(keyword)
{
    $.getJSON("/Home/Search?id=" + selectedCategoryId + "&keyword=" + keyword, function (result) {
        if (result.length > 0) {
            var html = name + "系统中有以下答案匹配您的问题: <ol class='result'>";
            $.each(result, function (i, field) {
                html += "<li><a href='javascript:Interpret(" + field.Id + ",\"" + field.Question + "\")' target='_blank'>" + field.Question + "</a></li>";
            });
            html += "</ol> <p style='margin-top:10px;'>不知道有没有帮到你呢？O(∩_∩)O</p>";
            displayResponse(html);
        } else {
            displayResponse("这个问题还没有被录入系统，我不知道要怎么回答你哦 (=@__@=) ");
        }
    });
}

function ViewAnswer(id) {
    $.getJSON("/Home/View/" + id, function (result) {
        if (result) {
            var html = result.Answer.replace(/\r/g, "<br>");
            html += "<p style='margin-top:10px;'> 以上答案是否解决了您的问题？ (@^_^@)</p>";
            displayResponse(html);
        } else {
            displayResponse("这个问题的答案找不到呢 (=@__@=) ");
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