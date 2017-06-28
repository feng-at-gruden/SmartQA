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
    //TODO, call ajax
    displayAnswer("你说什么? 我不懂啊！");
}

function displayAnswer(answer)
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


function selectCategory(name, id)
{
    selectedCategoryId = id;
    $('#current-category').html("当前问题分类: " + name);
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

var answerTemplate = '<div class="chat-answer"><span class="answer-name">智能客服 ##TIME##</span><div class="answer-content">##CONTENT##</div></div>';
var questionTemplate = '<div class="chat-question"><span class="question-name">我 ##TIME##</span><div class="question-content">##CONTENT##</div></div>';
var clearTemplate = '<div class="clear"></div>';