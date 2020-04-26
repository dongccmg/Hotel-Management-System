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
            <legend>搜索过去房客</legend>
            <div style="margin: 10px 10px 10px 10px">

                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">身份证号</label>
                        <div class="layui-input-inline">
                            <input type="text" name="searchroom" id="demoReload" autocomplete="off" class="layui-input" placeholder="请输入身份证">
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
            <div class=" layui-word-aux">永久信息表</div>
            <button class="layui-btn layui-btn-sm data-add-btn" lay-event="allpast"> 所有过去房客  </button>
            <button class="layui-btn layui-btn-sm layui-btn-danger data-delete-btn" lay-event="allown"> 所有欠款房客 </button>
        </div>
        </script>


        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>
        <form id="test"  onsubmit="return false">
            <div class="layui-form layuimini-form">
                <div class="layui-form-item">
                    <label class="layui-form-label required">身份证</label>
                    <div class="layui-input-inline">
                        <input id="id" name="id" class="layui-input" type="text" readonly="readonly" placeholder="还未选择房客" autocomplete="off" lay-verify="required">
                    </div>
                    <label class="layui-form-label required">当前欠款</label>
                    <div class="layui-input-inline">
                        <input id="own" name="own" class="layui-input" type="text" readonly="readonly" placeholder="还未填入金额" autocomplete="off" lay-verify="required|Ndouble">
                    </div>

                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label required">支付金额</label>
                    <div class="layui-input-inline">
                        <input id="back" name="back" class="layui-input" type="text"  placeholder="还未填入金额"  autocomplete="off" lay-verify="required|Ndouble" style="width:190px;">
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button class="layui-btn layui-btn-normal" lay-submit lay-filter="saveBtn">确认还款</button>
                    </div>
                </div>
            </div>
        </form>

    </div>

</div>

<script src="../lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script>
window.onload = function(){
    var $ = layui.jquery;

}
layui.use(['form', 'table','jquery'], function () {
    var $ = layui.jquery,
        form = layui.form,
        table = layui.table;

    table.render({
        async:false,
        elem: '#currentTableId',
        url: '../../keshe_war_exploded/PermanentTable',
        where:{id:"有"},
        toolbar: '#toolbarDemo',
        cellMinWidth: 80,
        defaultToolbar: ['filter', 'exports', 'print', {
            title: '提示',
            layEvent: 'LAYTABLE_TIPS',
            icon: 'layui-icon-tips'
        }],
        cols: [[
            {type: "radio"},
            {field: 'customerName',title: '姓名', sort:true},
            {field: 'identityNumber',  title: '身份证', sort: true},
            {field: 'ownMoney',  title: '欠款', sort:true},
            {field: 'vipStatus',  title: '是否为贵宾'},
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
        $("#id").val(obj.data.identityNumber);
        $("#own").val(obj.data.ownMoney);
        $("#back").val("");

    });


    // 监听搜索操作
    $(document).on('click','#btn',function() {
        //console.log(data);
        var demoReload = $('#demoReload');
        console.log(demoReload.val());
        //执行搜索重载
        table.reload('currentTableId', {
            //url:'../../keshe_war_exploded/PermanentTable',
            where:{id:demoReload.val()},
            page:{curr:1}
        }, 'data');
        $('#id').val("");
        $('#own').val("");
        $('#back').val("");

    });




    /**
     * toolbar监听事件
     */
    table.on('toolbar(currentTableFilter)', function (obj) {
        if (obj.event === 'allpast') {  // 监听所有过去
            table.reload('currentTableId', {
                data:'../../keshe_war_exploded/PermanentTable',
                where:{id:"无"},
                page:{curr:1}
            }, 'data');
            $('#id').val("");
            $('#own').val("");
            $('#back').val("");
            $('#demoReload').val("");
        }
        else if (obj.event === 'allown')  {  // 监听所有欠款
            table.reload('currentTableId', {
                data:'../../keshe_war_exploded/PermanentTable',
                where:{id:"有"},
                page:{curr:1}  //重新从第一页开始搜索数据
            },'data');
            $('#id').val("");
            $('#own').val("");
            $('#back').val("");
            $('#demoReload').val("");
        }

    });
});

layui.use(['form','layer','jquery'], function () {
    var form = layui.form,
        layer = layui.layer,
        $ = layui.$;

    form.verify({
        Ndouble:[
            /^[1-9]\d*$/
            ,'只能输入正整数哦'
        ]
    });
    //监听提交
    form.on('submit(saveBtn)', function (data) {
        var id = $('#id').val();
        var own = $('#own').val();
        var back=$('#back').val();
        console.log(own);
        console.log(back);

        if(parseInt(own)==0){layer.msg("该住户不欠款！");}
        else if(parseInt(own)<parseInt(back)){layer.msg("不需要还这么多！");}
        else {
            //console.log(oldroom);
            //console.log(newroom);
            $.ajax({
                async: false,
                type: "post",                            //传数据的方式
                url: "../../keshe_war_exploded/ReturnMoney", //servlet地址
                data: {id:id, own:own, back:back},        //传的数据
                success: function (data) {
                    //传数据成功之后的操作   result是servlet传过来的数据  这个函数对result进行处理，让它显示在 输入框中
                    //alert("success!");
                }
            });

            var index = layer.alert("还款成功！", {
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
    });
});



</script>
<script>

</script>

</body>
</html>