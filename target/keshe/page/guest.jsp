<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>layui</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="../lib/layui-v2.5.5/css/layui.css" media="all">
    <link rel="stylesheet" href="../css/public.css" media="all">
    <script src="http://code.jquery.com/jquery-latest.js"></script>
</head>

<body>
<div>
    <form class="layui-form" action="">


        <div class="layui-form-item" pane>
            <fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
                <legend>贵宾注册</legend>
            </fieldset>
            <fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;"></fieldset>
        </div>

        <div class="layui-form-item" pane>
            <li class="layui-timeline-item">
                <i class="layui-icon layui-timeline-axis">&#xe770;</i>
                <div class="layui-timeline-content layui-text">
                    <h3 class="layui-timeline-title">身份证</h3>
                    <input id="gueid" name="gueid" class="layui-input" type="text" placeholder="输入身份证" autocomplete="off" lay-verify="identity">
                </div>
            </li>

            <li class="layui-timeline-item">
                <i class="layui-icon layui-timeline-axis">&#xe6af;</i>
                <div class="layui-timeline-content layui-text">
                    <h3 class="layui-timeline-title">姓名</h3>
                    <input id="guename" name="guename" class="layui-input" type="text" placeholder="输入姓名" autocomplete="off" lay-verify="required">
                </div>
            </li>

            <li class="layui-timeline-item">
                <i class="layui-icon layui-timeline-axis">&#xe735;</i>
                <div class="layui-timeline-content layui-text">
                    <h3 class="layui-timeline-title">贵宾号</h3>
                    <input id="guenum" name="guenum" class="layui-input" type="text" readonly="readonly" placeholder="注册后生成" autocomplete="off">
                </div>
            </li>
        </div>

        <div class="layui-form-item" pane>
            <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;"></fieldset>
        </div>

        <div class="layui-form-item">
            <div class="layui-row layui-col-space10">
                <div class="layui-row">
                    <div class="layui-col-md1"><div class="grid-demo grid-demo-bg1">&nbsp;</div></div>
                    <div class="layui-col-md1"><div class="grid-demo">&nbsp;</div></div>
                    <div class="layui-col-md1"><div class="grid-demo grid-demo-bg1">&nbsp;</div></div>
                    <div class="layui-col-md1"><div class="grid-demo">&nbsp;</div></div>
                    <div class="layui-col-md1"><div class="grid-demo grid-demo-bg1">&nbsp;</div></div>
                    <div class="layui-col-md1">
                        <div class="grid-demo">
                            <button class="layui-btn" type="submit" lay-filter="guebtn" lay-submit="">注册</button>
                        </div>
                    </div>
                    <div class="layui-col-md1">
                        <div class="grid-demo grid-demo-bg1">
                            <button class="layui-btn layui-btn-primary" type="reset">重置</button>
                        </div>
                    </div>
                    <div class="layui-col-md1"><div class="grid-demo">&nbsp;</div></div>
                    <div class="layui-col-md1"><div class="grid-demo grid-demo-bg1">&nbsp;</div></div>
                    <div class="layui-col-md1"><div class="grid-demo">&nbsp;</div></div>
                    <div class="layui-col-md1"><div class="grid-demo grid-demo-bg1">&nbsp;</div></div>
                    <div class="layui-col-md1"><div class="grid-demo">&nbsp;</div></div>
                </div>
            </div>
        </div>

    </form>

</div>


<script src="../lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script>
layui.use(['form'], function () {
    var $ = layui.jquery,
        form = layui.form;

    form.on('submit(guebtn)',function () {
        $.ajax({
            type: "post",
            url: "../../keshe_war_exploded/GuestServlet",
            data: {
                id: $('#gueid').val(),
                name: $('#guename').val()
            },
            success: function (result) {
                if (result.vipnum != null && result.vipnum != "该用户已是贵宾,不需重复注册!") {
                    $('#guenum').val(result.vipnum);
                    layer.msg('注册成功!<br>该顾客贵宾号为' + result.vipnum, {
                        time: 10000
                    });
                } else if (result.vipnum == "该用户已是贵宾,不需重复注册!") {
                    layer.msg('注册失败!<br>' + result.vipnum, {
                        time: 10000
                    });
                } else if (result.vipnum == null) {
                    layer.msg('注册失败!<br>数据库错误', {
                        time: 10000
                    });
                }
            },
            error: function () {
                alert("数据传输失败!");
            }
        });
        return false;
    });
});
</script>

</body>
</html>