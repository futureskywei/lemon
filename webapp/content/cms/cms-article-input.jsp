<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/taglibs.jsp" %>
<%pageContext.setAttribute("currentHeader", "cms");%>
<%pageContext.setAttribute("currentMenu", "cms");%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <%@include file="/common/meta.jsp" %>
    <title>编辑</title>
    <%@include file="/common/s3.jsp" %>
    <script type="text/javascript">
        $(function () {
            $("#cms-articleForm").validate({
                submitHandler: function (form) {
                    bootbox.animate(false);
                    var box = bootbox.dialog('<div class="progress progress-striped active" style="margin:0px;"><div class="bar" style="width: 100%;"></div></div>');
                    form.submit();
                },
                errorClass: 'validate-error'
            });
        })
    </script>
    <script type="text/javascript" charset="utf-8" src="../../s/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="../../s/ueditor/ueditor.all.min.js"></script>
    <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
    <!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
    <script type="text/javascript" charset="utf-8" src="../../s/ueditor/lang/zh-cn/zh-cn.js"></script>

</head>

<body>
<%@include file="/header/cms.jsp" %>

<div class="row-fluid">
    <%@include file="/menu/cms.jsp" %>

    <!-- start of main -->
    <section id="m-main" class="col-md-10" style="padding-top:65px;">

        <div class="panel panel-default">
            <div class="panel-heading">
                <i class="glyphicon glyphicon-list"></i>
                编辑
            </div>

            <div class="panel-body">


                <form id="cmsArticleForm" method="post" action="cms-article-save.do" class="form-horizontal"
                      enctype="multipart/form-data">
                    <c:if test="${model != null}">
                        <input id="cms-article_id" type="hidden" name="id" value="${model.id}">
                    </c:if>
                    <div class="form-group">
                        <label class="control-label col-md-1" for="cms-article_cmsArticlename">栏目</label>
                        <div class="col-sm-5">
                            <select id="perm_resc" name="cmsCatalogId" class="form-control">
                                <c:forEach items="${cmsCatalogs}" var="item">
                                    <option value="${item.id}" ${model.cmsCatalog.id==item.id ? 'selected' : ''}>${item.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-1" for="cms-article_cmsArticlename">标题</label>
                        <div class="col-sm-5">
                            <input id="cms-article_cmsArticlename" type="text" name="title" value="${model.title}"
                                   size="40" class="form-control required" minlength="2" maxlength="50">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-1" for="cmsArticle_summary">摘要</label>
                        <div class="col-sm-5">
                            <textarea id="cmsArticle_summary" name="summary" maxlength="200"
                                      class="form-control">${model.summary}</textarea>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-md-1" for="cms-article_cmsArticlename">内容</label>
                        <div class="col-sm-9">
                            <textarea id="cmsArticle_content" name="content" cols="20" rows="4"
                                      minlength="2" maxlength="50">${model.content}</textarea>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-md-1" for="cmsArticle_file">附件</label>
                        <div class="col-sm-5">
                            <input id="cmsArticle_file" type="file" name="file" value="" class="">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-5">
                            <button id="submitButton" class="btn btn-default a-submit"><spring:message
                                    code='core.input.save' text='保存'/></button>
                            <button type="button" onclick="history.back();" class="btn btn-link a-cancel">
                                <spring:message code='core.input.back' text='返回'/></button>
                        </div>
                    </div>
                </form>

            </div>
            </article>
        </div>
        <div>
            <h1>完整demo</h1>
            <script id="editor" type="text/plain" style="width:1024px;height:500px;"></script>
        </div>
    </section>

</div>
<!-- end of main -->
<script type="text/javascript">

    //实例化编辑器
    //建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
    var ue = UE.getEditor('editor');


    function isFocus(e){
        alert(UE.getEditor('editor').isFocus());
        UE.dom.domUtils.preventDefault(e)
    }
    function setblur(e){
        UE.getEditor('editor').blur();
        UE.dom.domUtils.preventDefault(e)
    }
    function insertHtml() {
        var value = prompt('插入html代码', '');
        UE.getEditor('editor').execCommand('insertHtml', value)
    }
    function createEditor() {
        enableBtn();
        UE.getEditor('editor');
    }
    function getAllHtml() {
        alert(UE.getEditor('editor').getAllHtml())
    }
    function getContent() {
        var arr = [];
        arr.push("使用editor.getContent()方法可以获得编辑器的内容");
        arr.push("内容为：");
        arr.push(UE.getEditor('editor').getContent());
        alert(arr.join("\n"));
    }
    function getPlainTxt() {
        var arr = [];
        arr.push("使用editor.getPlainTxt()方法可以获得编辑器的带格式的纯文本内容");
        arr.push("内容为：");
        arr.push(UE.getEditor('editor').getPlainTxt());
        alert(arr.join('\n'))
    }
    function setContent(isAppendTo) {
        var arr = [];
        arr.push("使用editor.setContent('欢迎使用ueditor')方法可以设置编辑器的内容");
        UE.getEditor('editor').setContent('欢迎使用ueditor', isAppendTo);
        alert(arr.join("\n"));
    }
    function setDisabled() {
        UE.getEditor('editor').setDisabled('fullscreen');
        disableBtn("enable");
    }

    function setEnabled() {
        UE.getEditor('editor').setEnabled();
        enableBtn();
    }

    function getText() {
        //当你点击按钮时编辑区域已经失去了焦点，如果直接用getText将不会得到内容，所以要在选回来，然后取得内容
        var range = UE.getEditor('editor').selection.getRange();
        range.select();
        var txt = UE.getEditor('editor').selection.getText();
        alert(txt)
    }

    function getContentTxt() {
        var arr = [];
        arr.push("使用editor.getContentTxt()方法可以获得编辑器的纯文本内容");
        arr.push("编辑器的纯文本内容为：");
        arr.push(UE.getEditor('editor').getContentTxt());
        alert(arr.join("\n"));
    }
    function hasContent() {
        var arr = [];
        arr.push("使用editor.hasContents()方法判断编辑器里是否有内容");
        arr.push("判断结果为：");
        arr.push(UE.getEditor('editor').hasContents());
        alert(arr.join("\n"));
    }
    function setFocus() {
        UE.getEditor('editor').focus();
    }
    function deleteEditor() {
        disableBtn();
        UE.getEditor('editor').destroy();
    }
    function disableBtn(str) {
        var div = document.getElementById('btns');
        var btns = UE.dom.domUtils.getElementsByTagName(div, "button");
        for (var i = 0, btn; btn = btns[i++];) {
            if (btn.id == str) {
                UE.dom.domUtils.removeAttributes(btn, ["disabled"]);
            } else {
                btn.setAttribute("disabled", "true");
            }
        }
    }
    function enableBtn() {
        var div = document.getElementById('btns');
        var btns = UE.dom.domUtils.getElementsByTagName(div, "button");
        for (var i = 0, btn; btn = btns[i++];) {
            UE.dom.domUtils.removeAttributes(btn, ["disabled"]);
        }
    }

    function getLocalData () {
        alert(UE.getEditor('editor').execCommand( "getlocaldata" ));
    }

    function clearLocalData () {
        UE.getEditor('editor').execCommand( "clearlocaldata" );
        alert("已清空草稿箱")
    }
</script>

</body>

</html>

