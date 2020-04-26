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
    <form class="layui-form layui-form-pane" action="">
        <div class="layui-form-item">
            <div class="layuimini-container"><div class="layuimini-main">
                <div class="layui-tab" lay-filter="filtertab">
                <ul class="layui-tab-title">
                    <li>单人间</li>
                    <li>双人间</li>
                    <li>三人间</li>
                    <li>高级套房</li>
                </ul>
                <div class="layui-tab-content">
                    <div class="layui-tab-item">
                        <table class="layui-hide" id="resSingleRoom" lay-filter="resSingleRoom"></table>
                    </div>
                    <div class="layui-tab-item">
                        <table class="layui-hide" id="resDoubleRoom" lay-filter="resDoubleRoom"></table>
                    </div>
                    <div class="layui-tab-item">
                        <table class="layui-hide" id="resTripleRoom" lay-filter="resTripleRoom"></table>
                    </div>
                    <div class="layui-tab-item">
                        <table class="layui-hide" id="resSuiteRoom" lay-filter="resSuitRoom"></table>
                    </div>
                </div>
                </div>
            </div></div>
        </div>

        <div class="layui-form-item" pane>
            <label class="layui-form-label">房间号</label>
            <div class="layui-input-block">
                <input id="roomnum" name="roomnum" class="layui-input" type="text" readonly="readonly" placeholder="还未选择房间" autocomplete="off" lay-verify="required">
            </div>
        </div>

        <div class="layui-form-item" pane>
            <label class="layui-form-label">身份证</label>
            <div class="layui-input-block">
                <input id="resid" name="resid" class="layui-input" type="text" placeholder="输入身份证" autocomplete="off" lay-verify="identity">
            </div>
        </div>

        <div class="layui-form-item" pane>
            <label class="layui-form-label">姓名</label>
            <div class="layui-input-block">
                <input id="resname" name="resname" class="layui-input" type="text" placeholder="输入姓名" autocomplete="off" lay-verify="required">
            </div>
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
                            <button id="resbtn" class="layui-btn" lay-submit="" type="submit" lay-filter="resbtn">预定</button>
                        </div>
                    </div>
                    <div class="layui-col-md1">
                        <div class="grid-demo grid-demo-bg1">
                            <button id="clear" type="reset" class="layui-btn layui-btn-primary">重置</button>
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
    layui.use(['form', 'table','element'], function(){
        var $ = layui.jquery,
            form = layui.form,
            element = layui.element,
            table = layui.table;

        element.on('tab(filtertab)', function(data){
            if(data.index===0 || data.index===1 ||data.index===2 || data.index===3 ) {
                //取消选中table的radio
                $("input[type=radio]:checked").each(function() {
                    if( $(this).val()==="on" ) {
                        $(this).attr("checked", false);
                        form.render('radio');
                    }
                })
                //还原房间号
                $("#roomnum").val("");
            }
        });

        form.on('submit(resbtn)',function () {
            $.ajax({
                type: "post",
                url: "../../keshe_war_exploded/ReserveServlet",
                data: {
                    roomnum: $('#roomnum').val(),
                    resid: $('#resid').val(),
                    resname: $('#resname').val(),
                },
                success: function (result) {
                    if(result.flag==1){
                        var index = layer.alert("预定成功！", {
                            skin: 'layui-layer-molv', //样式类名
                            closeBtn: 0,
                            title: '提示',
                            anim: 5
                        }, function () {
                            // 关闭弹出层
                            layer.close(index);
                            //关闭当前窗口
                            var iframeIndex = parent.layer.getFrameIndex(window.name);
                            parent.layer.close(iframeIndex);
                            parent.location.reload();
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


<script>
layui.use(['form', 'table'], function () {
    var $ = layui.jquery,
        table = layui.table;

    table.render({
        elem: '#resSingleRoom',
        url: '../../keshe_war_exploded/ReserveSingleRoomServlet',
        toolbar: '#toolbarDemo',
        defaultToolbar: ['filter', {
            title: '提示',
            layEvent: 'LAYTABLE_TIPS',
            icon: 'layui-icon-tips'
        }],
        cols: [[
            {type: "radio", fixed:'left'},
            {field: 'roomNumber', width: 140, title: '房号', sort: true},
            {field: 'roomPrice', width: 140, title: '价格', sort: true},
            {field: 'roomType', width: 170, title: '房型', sort: true},
            {field: 'status', width: 170, title: '状态', sort: true},
            {field: 'depositprice', width: 170, title: '押金', sort: false},
            {title: '操作', minWidth: 100, templet: '#currentTableBar', fixed: "right", align: "center"}
        ]],
        page: false
    });

    table.on('radio(resSingleRoom)', function(obj){
        $("#roomnum").val(obj.data.roomNumber);
    });

});
</script>

<script>
    layui.use(['form', 'table'], function () {
        var $ = layui.jquery,
            table = layui.table;

        table.render({
            elem: '#resDoubleRoom',
            url: '../../keshe_war_exploded/ReserveDoubleRoomServlet',
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', {
                title: '提示',
                layEvent: 'LAYTABLE_TIPS',
                icon: 'layui-icon-tips'
            }],
            cols: [[
                {type: "radio", fixed:'left'},
                {field: 'roomNumber', width: 140, title: '房号', sort: true},
                {field: 'roomPrice', width: 140, title: '价格', sort: true},
                {field: 'roomType', width: 170, title: '房型', sort: true},
                {field: 'status', width: 170, title: '状态', sort: true},
                {field: 'depositprice', width: 170, title: '押金', sort: false},
                {title: '操作', minWidth: 100, templet: '#currentTableBar', fixed: "right", align: "center"}
            ]],
            page: false
        });

        table.on('radio(resDoubleRoom)', function(obj){
            $("#roomnum").val(obj.data.roomNumber);
        });

    });
</script>

<script>
    layui.use(['form', 'table'], function () {
        var $ = layui.jquery,
            table = layui.table;

        table.render({
            elem: '#resTripleRoom',
            url: '../../keshe_war_exploded/ReserveTripleRoomServlet',
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', {
                title: '提示',
                layEvent: 'LAYTABLE_TIPS',
                icon: 'layui-icon-tips'
            }],
            cols: [[
                {type: "radio", fixed:'left'},
                {field: 'roomNumber', width: 140, title: '房号', sort: true},
                {field: 'roomPrice', width: 140, title: '价格', sort: true},
                {field: 'roomType', width: 170, title: '房型', sort: true},
                {field: 'status', width: 170, title: '状态', sort: true},
                {field: 'depositprice', width: 170, title: '押金', sort: false},
                {title: '操作', minWidth: 100, templet: '#currentTableBar', fixed: "right", align: "center"}
            ]],
            page: false
        });

        table.on('radio(resTripleRoom)', function(obj){
            $("#roomnum").val(obj.data.roomNumber);
        });

    });
</script>

<script>
    layui.use(['form', 'table'], function () {
        var $ = layui.jquery,
            table = layui.table;

        table.render({
            elem: '#resSuiteRoom',
            url: '../../keshe_war_exploded/ReserveSuitRoomServlet',
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', {
                title: '提示',
                layEvent: 'LAYTABLE_TIPS',
                icon: 'layui-icon-tips'
            }],
            cols: [[
                {type: "radio", fixed:'left'},
                {field: 'roomNumber', width: 140, title: '房号', sort: true},
                {field: 'roomPrice', width: 140, title: '价格', sort: true},
                {field: 'roomType', width: 170, title: '房型', sort: true},
                {field: 'status', width: 170, title: '状态', sort: true},
                {field: 'depositprice', width: 170, title: '押金', sort: false},
                {title: '操作', minWidth: 100, templet: '#currentTableBar', fixed: "right", align: "center"}
            ]],
            page: false
        });

        table.on('radio(resSuitRoom)', function(obj){
            $("#roomnum").val(obj.data.roomNumber);
        });

    });
</script>

</body>
</html>