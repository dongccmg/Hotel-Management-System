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
                        <table class="layui-hide" id="SingleRoom" lay-filter="SingleRoom"></table>
                    </div>
                    <div class="layui-tab-item">
                        <table class="layui-hide" id="DoubleRoom" lay-filter="DoubleRoom"></table>
                    </div>
                    <div class="layui-tab-item">
                        <table class="layui-hide" id="TripleRoom" lay-filter="TripleRoom"></table>
                    </div>
                    <div class="layui-tab-item">
                        <table class="layui-hide" id="SuiteRoom" lay-filter="SuitRoom"></table>
                    </div>
                </div>
                </div>
            </div></div>
        </div>

        <div class="layui-form-item" pane>
            <label class="layui-form-label">房间号</label>
            <div class="layui-input-block">
                <input id="roomliving" name="roomliving" class="layui-input" type="text" readonly="readonly" placeholder="还未选择房间" autocomplete="off" lay-verify="required">
            </div>
        </div>

        <div class="layui-form-item" pane>
            <label class="layui-form-label">需交押金</label>
            <div class="layui-input-inline">
                <input id="deposit" name="deposit" class="layui-input" type="text" readonly="readonly" placeholder="还未选择房间" autocomplete="off" lay-verify="required">
            </div>
            <input type="radio" id="jiao" name="jiao" value="jiao" title="已交" lay-filter="jiao" lay-verify="otherReq">
        </div>

        <div class="layui-form-item" pane>
            <div class="layui-collapse">

                <div class="layui-colla-item">
                    <h2 class="layui-colla-title">必填身份</h2>
                    <div class="layui-colla-content layui-show">
                        <div class="layui-form-item" pane>
                            <label class="layui-form-label">身份证</label>
                            <div class="layui-input-block">
                                <input id="identity" name="identity" class="layui-input" type="text" placeholder="输入身份证" autocomplete="off" lay-verify="identity">
                            </div>
                        </div>
                        <div class="layui-form-item" pane>
                            <label class="layui-form-label">姓名</label>
                            <div class="layui-input-block">
                                <input id="name" name="name" class="layui-input" type="text" placeholder="输入姓名" autocomplete="off" lay-verify="required">
                            </div>
                        </div>
                    </div>
                </div>

                <div class="layui-colla-item">
                    <h2 class="layui-colla-title">身份2</h2>
                    <div class="layui-colla-content">
                        <div class="layui-form-item" pane>
                            <label class="layui-form-label">身份证</label>
                            <div class="layui-input-block">
                                <input id="identity2" name="identity2" class="layui-input" type="text" placeholder="选填" autocomplete="off" lay-verify="optidentity">
                            </div>
                        </div>
                        <div class="layui-form-item" pane>
                            <label class="layui-form-label">姓名</label>
                            <div class="layui-input-block">
                                <input id="name2" name="name2" class="layui-input" type="text" placeholder="选填" autocomplete="off">
                            </div>
                        </div>
                    </div>
                </div>

                <div class="layui-colla-item">
                    <h2 class="layui-colla-title">身份3</h2>
                    <div class="layui-colla-content">
                        <div class="layui-form-item" pane>
                            <label class="layui-form-label">身份证</label>
                            <div class="layui-input-block">
                                <input id="identity3" name="identity3" class="layui-input" type="text" placeholder="选填" autocomplete="off" lay-verify="optidentity">
                            </div>
                        </div>
                        <div class="layui-form-item" pane>
                            <label class="layui-form-label">姓名</label>
                            <div class="layui-input-block">
                                <input id="name3" name="name3" class="layui-input" type="text" placeholder="选填" autocomplete="off">
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>

        <div class="layui-form-item" pane>
            <label class="layui-form-label">散客/团体</label>
            <div class="layui-input-inline">
                <input id="sanke" name="gorl" type="radio" value="1" title="散客" lay-filter="sanke" checked>
                <input id="tuanti" name="gorl" type="radio" value="0" title="团体" lay-filter="tuanti">
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
                            <button id="checkinbtn" class="layui-btn" lay-submit="" type="submit" lay-filter="checkinbtn">入住</button>
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
    layui.use(['form','table', 'element'], function(){
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
                //还原房间号押金文本和"已交"radio
                $("#jiao").attr("checked", false);
                form.render('radio');
                $("#roomliving").val("");
                $("#deposit").val("");
            }
        });

        form.verify({
            otherReq: function(value,item){
                var $ = layui.$;
                var verifyName=$(item).attr('name')
                    , verifyType=$(item).attr('type')
                    ,formElem=$(item).parents('.layui-form')
                    ,verifyElem=formElem.find('input[name='+verifyName+']')
                    ,isTrue= verifyElem.is(':checked')
                    ,focusElem = verifyElem.next().find('i.layui-icon');
                if(!isTrue || !value){
                    focusElem.css(verifyType=='radio'?{"color":"#FF5722"}:{"border-color":"#FF5722"});
                    focusElem.first().attr("tabIndex","1").css("outline","0").blur(function() {
                        focusElem.css(verifyType=='radio'?{"color":""}:{"border-color":""});
                    }).focus();
                    return '该项必选';
                }
            },
            optidentity: function (value, item) { //value：表单的值、item：表单的DOM对象
                if (!(/(^\d{15}$)|(^\d{17}(x|X|\d)$)/.test(value)) && value) {
                    var attr = $(item).attr("lay-verify-msg-identity");
                    if (typeof attr !== typeof undefined && attr !== false && attr !== '') {
                        return attr;
                    }
                    attr = $(item).attr("lay-verify-msg");
                    if (typeof attr !== typeof undefined && attr !== false && attr !== '') {
                        return attr;
                    }
                    return '请输入正确的身份证号';
                }
            }
        });

        form.on('submit(checkinbtn)',function () {
            $.ajax({
                type: "post",
                url: "../../keshe_war_exploded/CheckInServlet",
                data: {
                    roomliving: $('#roomliving').val(),
                    identity: $('#identity').val(),
                    name: $('#name').val(),
                    identity2: $('#identity2').val(),
                    name2: $('#name2').val(),
                    identity3: $('#identity3').val(),
                    name3: $('#name3').val(),
                    sanke: $('#sanke').val()
                },
                success: function (result) {
                    if(result.flag==1){
                        var index = layer.alert("入住成功！", {
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
                    else if (result.flag==0) {
                        layer.msg('入住失败!<br>该客户已入住,退房或换房', {
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

        form.on('radio(sanke)',function (){
            $("#sanke").val(1);
            $("#tuanti").val(0);
        });

        form.on('radio(tuanti)',function (){
            $("#sanke").val(0);
            $("#tuanti").val(1);
        });

    });
</script>


<script type="text/html" id="tb">
    <button class="layui-btn layui-btn-primary layui-btn-xs layui-btn-radius" type="button" lay-event="detail">
        <i class="layui-icon">&#xe615;</i>
    </button>
</script>

<script>
layui.use(['form', 'table'], function () {
    var $ = layui.jquery,
        table = layui.table;

    table.render({
        elem: '#SingleRoom',
        url: '../../keshe_war_exploded/AvailableSingleRoomServlet',
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
            {title: '预约信息', minWidth: 80, toolbar: '#tb', fixed: "right", align: "center"}
        ]],
        page: false
    });

    table.on('radio(SingleRoom)', function(obj){
        $("#roomliving").val(obj.data.roomNumber);
        $("#deposit").val(obj.data.depositprice);
    });

    table.on('tool(SingleRoom)', function(obj) {
        $.ajax({
            type: "post",
            url: "../../keshe_war_exploded/ResInfServlet",
            data: { par : obj.data.roomNumber },
            success: function (result) {
                if(result.id == "" && result.name == ""){
                    layer.msg(obj.data.roomNumber+'号房<br>未被预约', {
                        time: 20000,
                        offset: 'rt'
                    });
                }
                else{
                    layer.msg(obj.data.roomNumber+'号房预约人信息<br>身份证:'+result.id+'<br>姓名:'+result.name, {
                        time: 20000,
                        offset: 'rt'
                    });
                }
            },
            error : function()
            {
                alert("数据传输失败!");
            }
        });
    });

});
</script>

<script>
    layui.use(['form', 'table'], function () {
        var $ = layui.jquery,
            table = layui.table;

        table.render({
            elem: '#DoubleRoom',
            url: '../../keshe_war_exploded/AvailableDoubleRoomServlet',
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
                {title: '预约信息', minWidth: 80, toolbar: '#tb', fixed: "right", align: "center"}
            ]],
            page: false
        });

        table.on('radio(DoubleRoom)', function(obj){
            $("#roomliving").val(obj.data.roomNumber);
            $("#deposit").val(obj.data.depositprice);
        });

        table.on('tool(DoubleRoom)', function(obj){
            $.ajax({
                type: "post",
                url: "../../keshe_war_exploded/ResInfServlet",
                data: { par : obj.data.roomNumber },
                success: function (result) {
                    if(result.id == "" && result.name == ""){
                        layer.msg(obj.data.roomNumber+'号房<br>未被预约', {
                            time: 20000,
                            offset: 'rt'
                        });
                    }
                    else{
                        layer.msg(obj.data.roomNumber+'号房预约人信息<br>身份证:'+result.id+'<br>姓名:'+result.name, {
                            time: 20000,
                            offset: 'rt'
                        });
                    }
                },
                error : function()
                {
                    alert("数据传输失败!");
                }
            });
        });

    });
</script>

<script>
    layui.use(['form', 'table'], function () {
        var $ = layui.jquery,
            table = layui.table;

        table.render({
            elem: '#TripleRoom',
            url: '../../keshe_war_exploded/AvailableTripleRoomServlet',
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
                {title: '预约信息', minWidth: 80, toolbar: '#tb', fixed: "right", align: "center"}
            ]],
            page: false
        });

        table.on('radio(TripleRoom)', function(obj){
            $("#roomliving").val(obj.data.roomNumber);
            $("#deposit").val(obj.data.depositprice);
        });

        table.on('tool(TripleRoom)', function(obj){
            $.ajax({
                type: "post",
                url: "../../keshe_war_exploded/ResInfServlet",
                data: { par : obj.data.roomNumber },
                success: function (result) {
                    if(result.id == "" && result.name == ""){
                        layer.msg(obj.data.roomNumber+'号房<br>未被预约', {
                            time: 20000,
                            offset: 'rt'
                        });
                    }
                    else{
                        layer.msg(obj.data.roomNumber+'号房预约人信息<br>身份证:'+result.id+'<br>姓名:'+result.name, {
                            time: 20000,
                            offset: 'rt'
                        });
                    }
                },
                error : function()
                {
                    alert("数据传输失败!");
                }
            });
        });

    });
</script>

<script>
    layui.use(['form', 'table'], function () {
        var $ = layui.jquery,
            table = layui.table;

        table.render({
            elem: '#SuiteRoom',
            url: '../../keshe_war_exploded/AvailableSuiteRoomServlet',
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
                {title: '预约信息', minWidth: 80, toolbar: '#tb', fixed: "right", align: "center"}
            ]],
            page: false
        });

        table.on('radio(SuitRoom)', function(obj){
            $("#roomliving").val(obj.data.roomNumber);
            $("#deposit").val(obj.data.depositprice);
        });

        table.on('tool(SuitRoom)', function(obj){
            $.ajax({
                type: "post",
                url: "../../keshe_war_exploded/ResInfServlet",
                data: { par : obj.data.roomNumber },
                success: function (result) {
                    if(result.id == "" && result.name == ""){
                        layer.msg(obj.data.roomNumber+'号房<br>未被预约', {
                            time: 20000,
                            offset: 'rt'
                        });
                    }
                    else{
                        layer.msg(obj.data.roomNumber+'号房预约人信息<br>身份证:'+result.id+'<br>姓名:'+result.name, {
                            time: 20000,
                            offset: 'rt'
                        });
                    }
                },
                error : function()
                {
                    alert("数据传输失败!");
                }
            });
        });

    });
</script>


<script>
    layui.use(['form'], function () {
        var $ = layui.jquery,
            form = layui.form;

        form.on('radio(jiao)', function(){
            if($("#roomliving").val()==""){
                layer.open({
                    title: '提示',
                    content: '支付押金前,请先选择房间！',
                });
                $("#jiao").attr("checked", false);
                form.render('radio');
            }
        });
    });
</script>

</body>
</html>