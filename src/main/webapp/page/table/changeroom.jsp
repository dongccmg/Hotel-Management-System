<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<!DOCTYPE html>
<head>
    <meta charset="utf-8">
    <title>layui</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="../../lib/layui-v2.5.5/css/layui.css" media="all">
    <link rel="stylesheet" href="../../css/public.css" media="all">
</head>
<body>
<!form class="layui-form "  onsubmit="return false">
<div class="layuimini-container">
    <div class="layuimini-main">

        <fieldset class="table-search-fieldset">
            <legend>搜索空闲房间</legend>
            <div style="margin: 10px 10px 10px 10px">

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

            </div>
        </fieldset>

        <script type="text/html" id="toolbarDemo">
        <div class="layui-input-inline">
            <div class=" layui-word-aux">空闲房间表</div>
            <button class="layui-btn layui-btn-sm data-add-btn" lay-event="refresh"> 所有空闲房间 </button>
        </div>
        </script>


        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

        <div class="layui-form-item" pane>
            <label class="layui-form-label">原先房间号</label>
            <div class="layui-input-inline">
                <input id="oldroom" name="oldroom" class="layui-input" type="text" readonly="readonly" placeholder="还未选择房间" autocomplete="off" lay-verify="required">
            </div>

            <label class="layui-form-label required">新换房间号</label>
            <div class="layui-input-inline">
                <input id="newroom" name="newroom" class="layui-input" type="text"  placeholder="还未选择新房间" readonly="readonly" autocomplete="off" lay-verify="required">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn layui-btn-normal" lay-submit lay-filter="saveBtn">确认换房</button>
            </div>
        </div>

    </div>

</div>
<!/form>
<script src="../../lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script>
window.onload = function(){
    var $ = layui.jquery;
    $('#oldroom').val(parent.room);
}
layui.use(['form', 'table','jquery'], function () {
    var $ = layui.jquery,
        form = layui.form,
        table = layui.table;

    table.render({
        async:false,
        elem: '#currentTableId',
        url: '../../../keshe_war_exploded/RoomTableServlet',
        where:{roomstatus:"空闲"},
        toolbar: '#toolbarDemo',
        cellMinWidth: 80,
        defaultToolbar: ['filter', 'exports', 'print', {
            title: '提示',
            layEvent: 'LAYTABLE_TIPS',
            icon: 'layui-icon-tips'
        }],
        cols: [[
            {type: "radio"},
            {field: 'roomNumber',title: '房间号', sort:true},
            {field: 'roomPrice',  title: '房间价格', sort: true},
            {field: 'roomType',  title: '房间类型'},
            {field: 'status',  title: '状态'},
            {field: 'telephone',  title: '房间电话'},

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
    table.on('radio(currentTableFilter)', function(obj){
        //alert(obj.data);
        $("#newroom").val(obj.data.roomNumber);
    });


    // 监听搜索操作
    $(document).on('click','#btn',function() {
        //console.log(data);
        var demoReload = $('#demoReload');
        console.log(demoReload.val());
        //执行搜索重载
        table.reload('currentTableId', {
            url:'../../../keshe_war_exploded/RoomSearchServlet',
            where:{searchroom:demoReload.val(),roomstatus:"空闲"}
        }, 'data');
    });




    /**
     * toolbar监听事件
     */
    table.on('toolbar(currentTableFilter)', function (obj) {
        if (obj.event === 'refresh') {  // 监听添加操作
            table.reload('currentTableId', {

                url:'../../../keshe_war_exploded/RoomTableServlet',
                where:{roomstatus:"空闲"},

            }, 'data');
            $('#newroom').val("");
        }

    });
});

layui.use(['form','layer','jquery'], function () {
    var form = layui.form,
        layer = layui.layer,
        $ = layui.$;

    //监听提交
    form.on('submit(saveBtn)', function (data) {
        var newroom = $('#newroom').val();
        var oldroom = $('#oldroom').val();
        if(newroom==''){layer.msg("新房间号不能为空");}
        else {
            console.log(oldroom);
            console.log(newroom);
            $.ajax({
                async: false,
                type: "post",                            //传数据的方式
                url: "../../../keshe_war_exploded/RoomChange", //servlet地址
                data: {oldroom: oldroom, newroom: newroom},        //传的数据
                success: function (data) {
                    //传数据成功之后的操作   result是servlet传过来的数据  这个函数对result进行处理，让它显示在 输入框中
                    //alert("success!");
                }
            });

            var index = layer.alert("换房成功！", {
                skin: 'layui-layer-molv', //样式类名
                closeBtn: 0,
                title: '提示',
                anim: 3
            }, function () {
                // 关闭弹出层
                layer.close(index);
                console.log("baka");
                //关闭当前窗口
                var iframeIndex = parent.layer.getFrameIndex(window.name);
                parent.layer.close(iframeIndex);
                parent.location.reload();
            });
        }
    });
});



</script>
<script>

</script>

</body>
</html>