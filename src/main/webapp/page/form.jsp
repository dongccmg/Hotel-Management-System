<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
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
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">

        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 50px;">
            <legend>查看统计报表</legend>
        </fieldset>

        <form class="layui-form">
            <div class="layui-inline">
                <label class="layui-form-label">日期选择</label>
                <div class="layui-input-block">
                    <input type="text" name="date1" id="date1" autocomplete="off" class="layui-input" >
                </div>
                <div class="layui-input-block">
                    <p style="color: #00b5ad">-------至-------</p>
                    <input type="text" name="date2" id="date2" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div>
                <table class="layui-hide" id="test"></table>
            </div>
            <br>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn" id="btnn" lay-submit lay-filter="demo1">立即提交</button>
                </div>
            </div>
        </form>
    </div>
</div>

<script src="../lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script src="https://cdn.staticfile.org/jquery/1.10.2/jquery.min.js"></script>
<script>
layui.use(['form', 'laydate','table','layer'], function () {
    var form = layui.form
        , laydate = layui.laydate
        , laydate2 = layui.laydate
        , laytable =layui.table
        , $=layui.$
        , layer=layui.layer
        ;

    //日期
    laydate.render({
        elem: '#date1',
    });
    laydate2.render({
        elem: '#date2'
    });

    //监听指定开关

    /*function getUrlParam(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
        var r = window.location.search.substr(1).match(reg);  //匹配目标参数
        if (r != null) return unescape(r[2]); return null; //返回参数值
    }*/

    form.on('submit(demo1)', function (data) {
        //var loginid="<%=session.getAttribute("id")%>";
        var loginid=window.localStorage.getItem("id");
        //console.log(loginid);
        if(loginid=="staff")
        {
            layer.msg("No Permission!");
            return false;
        }
        var date1value=$('#date1').val();
        var date2value=$('#date2').val();
        $.ajax(
            {
                type:"post",
                url:"../../keshe_war_exploded/StatisticsServlet",
                data:{"date1":date1value,"date2":date2value},
                success:function(result)
                {
                    var jsobj=JSON.parse(result);
                    var tdata=jsobj.data;
                    //console.log(result);
                    laytable.render({
                        elem: '#test'
                        ,data:tdata
                        ,cellMinWidth: 80 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
                        ,cols: [[
                            {field:'date', width:120, title: '时间', sort: true/*,templet:function(d){return util.toDateString(d.commPosttime*1000, "yyyy-MM-dd");}*/}
                            ,{field:'guestnum', width:120, title: '入住客人数'}
                            ,{field:'reservedroom', width:120, title: '预留房间数', sort: true}
                            ,{field:'credit', width:120, title: '赊账金额'}
                            ,{field:'profit', title: '利润', width: '10%', minWidth: 100} //minWidth：局部定义当前单元格的最小宽度，layui 2.2.1 新增
                            ,{field:'addguest', title: '贵宾增加数', sort: true}
                        ]]
                    });
                }
            }
        );
        return false;
    });
});

</script>
</body>
</html>