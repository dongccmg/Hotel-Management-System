<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <meta charset="utf-8">
    <title>基本资料</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="../lib/layui-v2.5.5/css/layui.css" media="all">
    <link rel="stylesheet" href="../css/public.css" media="all">
    <style>
        .layui-form-item .layui-input-company {width: auto;padding-right: 10px;line-height: 38px;}

        .pic_border_orange{
            /*橙色*/
            border-radius: 18px;
            border: 2px solid orange;
            box-shadow: 0 0 10px 3px orange;
        }

        .pic_border_cyan{
            /*青色*/
            border-radius: 18px;
            border: 2px darkcyan;
            box-shadow: 0 0 10px 3px cyan;
        }

    </style>
</head>
<body>
<div class="layuimini-container">
        <div class="layui-row" style="margin: 10px;">
            <img id="infoimg" class="pic_border_cyan" src="../images/staff.png" style="width: 250px;height: 250px;"/>
        </div>

        <div class="layui-row" style="margin: 10px;">
        <label class="layui-form-label">姓名</label>
        <div class="layui-input-block">
            <input id="nameinfo" name="nameinfo" class="layui-input" type="text" readonly="readonly" placeholder="" autocomplete="off" style="width: 200px;"/>
        </div>
        </div>

        <div class="layui-row" style="margin: 10px;">
            <label class="layui-form-label">电话号码</label>
            <div class="layui-input-block">
                <input id="telephone" name="telephone" class="layui-input" type="text" readonly="readonly" placeholder="" autocomplete="off" style="width: 200px;" />
            </div>
        </div>

        <div class="layui-row" style="margin: 10px;">
            <label class="layui-form-label">人生格言</label>
            <div class="layui-input-block">
                <input id="tomb" name="tomb" class="layui-input" type="text" readonly="readonly" placeholder="" autocomplete="off" style="width: 200px;" />
            </div>
        </div>


</div>
<script src="../lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script src="../js/lay-config.js?v=1.0.4" charset="utf-8"></script>
<script>
    var loginid=window.localStorage.getItem("id")
    var imageurl="../images/"+loginid+".png"
    document.getElementById("infoimg").src=imageurl;
    document.getElementById("nameinfo").value=loginid;
    if(loginid=="admin"){
        document.getElementById("infoimg").setAttribute("class","pic_border_orange");
        document.getElementById("telephone").value="666666";
        document.getElementById("tomb").value="我的梦想是成为流氓巨星";
    }
    else{
        document.getElementById("telephone").value="555555";
        document.getElementById("tomb").value="但是，我拒绝！";
    }
    layui.use(['form','miniTab','layer'], function () {
        var form = layui.form,
            layer = layui.layer,
            miniTab = layui.miniTab;

    });

    

</script>
</body>
</html>