<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<!DOCTYPE html>
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

        <fieldset class="table-search-fieldset">
            <legend>搜索有人房间</legend>
            <div style="margin: 10px 10px 10px 10px">
                <!form class="layui-form layui-form-pane" >
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">房间号</label>
                            <div class="layui-input-inline">
                                <input type="text" name="searchroom" id="demoReload" autocomplete="off" class="layui-input" placeholder="请输入房间号">
                                <br>
                                <button id="btn" class="layui-btn layui-btn-primary" lay-submit  lay-filter="data-search-btn"><i class="layui-icon"></i> 搜 索</button>
                            </div>
                        </div>
                    </div>
                    <div>
                        <div class="layui-inline">

                        </div>
                    </div>
                <!/form>
            </div>
        </fieldset>

        <script type="text/html" id="toolbarDemo">
        <div class="layui-input-inline">
            <div class=" layui-word-aux">有人房间表</div>
            <button class="layui-btn layui-btn-sm data-add-btn" lay-event="refresh"> 所有有人房间 </button>
        </div>

        </script>
        <script type="text/html" id="toolbarDemo1">
        <div class="layui-input-inline">
            <div class=" layui-word-aux">当前住户信息表</div>
        </div>
        </script>

        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

        <script type="text/html" id="currentTableBar">
        <a class="layui-btn layui-btn-xs data-count-edit" lay-event="edit">换房</a>
        <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete">退房</a>
        </script>
        <table class="layui-hide" id="nowTableId" lay-filter="nowTableFilter"></table>
    </div>
</div>
<script src="../lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script>
layui.use(['form', 'table','jquery'], function () {
    var $ = layui.jquery,
        form = layui.form,
        table = layui.table;

    table.render({
        async:false,
        elem: '#currentTableId',
        url: '../../keshe_war_exploded/RoomTableServlet',
        where:{roomstatus:"有人"},
        toolbar: '#toolbarDemo',
        defaultToolbar: ['filter', 'exports', 'print', {
            title: '提示',
            layEvent: 'LAYTABLE_TIPS',
            icon: 'layui-icon-tips'
        }],
        cols: [[
            //{type: "checkbox", width: 50, fixed: "left"},
            {field: 'roomNumber', width: 160, title: '房间号', sort:true},
            {field: 'roomPrice', width: 160, title: '房间价格', sort: true},
            {field: 'roomType', width: 160, title: '房间类型'},
            {field: 'status', width: 160, title: '状态'},
            {field: 'telephone', width: 160, title: '房间电话'},
            {title: '操作', minWidth: 50, templet: '#currentTableBar', fixed: "right", align: "center"}

        ]],
        id:'currentTableId',
        method:'post',
        limits: [3,6,9],
        limit: 3,
        page: true,
        parseData:function(res){ //res 即为原始返回的数据
            if( this.page.curr) {
                var result=res.data.slice(this.limit*(this.page.curr-1),this.limit*this.page.curr);
            }  else {
                var result=res.data.slice(0,this.limit);
            }
            return {
                "code": res.code,
                "msg":"",
                "count": res.count,
                "data": result
            }
        }
    });


    table.render({
        async:false,
        elem: '#nowTableId',
        url: '../../keshe_war_exploded/NowTable',
        cellMinWidth: 80,
        toolbar: '#toolbarDemo1',
        defaultToolbar: ['filter', 'exports', 'print', {
            title: '提示',
            layEvent: 'LAYTABLE_TIPS',
            icon: 'layui-icon-tips'
        }],
        cols: [[
            //{type: "checkbox", width: 50, fixed: "left"},
            {field: 'identityNumber', title: '身份证号', sort:true},
            {field: 'roomLiving', title: '房间号', sort: true},

        ]],
        id:'nowTableId',
        method:'post',
        limits: [3,6,9],
        limit: 3,
        page: true,
        parseData:function(res){ //res 即为原始返回的数据
            if( this.page.curr) {
                var result=res.data.slice(this.limit*(this.page.curr-1),this.limit*this.page.curr);
            }  else {
                var result=res.data.slice(0,this.limit);
            }
            return {
                "code": res.code,
                "msg":"",
                "count": res.count,
                "data": result
            }
        }
    });

    // 监听搜索操作
    $(document).on('click','#btn',function() {
        //console.log(data);
        var demoReload = $('#demoReload');
        console.log(demoReload.val());
        //执行搜索重载
        table.reload('currentTableId', {
            page:{curr:1},
            url:'../../keshe_war_exploded/RoomSearchServlet',
            where:{searchroom:demoReload.val(),roomstatus:"有人"}
        }, 'data');
        });




    /**
     * toolbar监听事件
     */
    table.on('toolbar(currentTableFilter)', function (obj) {
        if (obj.event === 'refresh') {  // 监听添加操作
            table.reload('currentTableId', {
                page:{curr:1},
                url:'../../keshe_war_exploded/RoomTableServlet',
                where:{roomstatus:"有人"}

            }, 'data');
        }
         else if (obj.event === 'delete')  {  // 监听退房操作
            var index = layer.open({
                title: '退房信息',
                type: 2,
                shade: 0.2,
                maxmin:true,
                shadeClose: true,
                area: ['80%', '150%'],
                content: '/page/checkoutstep.jsp',
            });
            $(window).on("resize", function () {
                layer.full(index);
            });
        }
    });

    //监听表格复选框选择
    table.on('checkbox(currentTableFilter)', function (obj) {
        console.log(obj)
    });

    table.on('tool(currentTableFilter)', function (obj) {
        var data = obj.data;
        window.room=obj.data.roomNumber;
        if (obj.event === 'edit') {

            var index = layer.open({
                title: '换房信息',
                type: 2,
                shade: 0.2,
                maxmin:true,
                //offset: ['0px', '0px'],
                area: ['100%', '100%'],
                content: './table/changeroom.jsp',
            });
            $(window).on("resize", function () {
                layer.full(index);
            });
            return false;
        } else if (obj.event === 'delete') {  // 监听退房操作
            //var checkStatus = table.checkStatus(obj.config.id);
            //var data = checkStatus.data;
            //layer.alert(JSON.stringify(obj.data));
            window.room=obj.data.roomNumber;
            console.log(window.room);
            var index = layer.open({

                title: '退房信息',
                type: 2,
                shade: 0.2,
                maxmin:true,
                shadeClose: true,
                //offset: ['0px', '0px'],
                area: ['100%', '100%'],
                content: './table/checkoutinfo.jsp',
            });

            $(window).on("resize", function () {
                layer.full(index);
            });
           //layer.close(index);
        }
    });

});
</script>
<script>

</script>

</body>
</html>