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
    <link rel="stylesheet" href="../../lib/layui-v2.5.5/css/layui.css" media="all">
    <link rel="stylesheet" href="../../css/public.css" media="all">
    <style>
        body {
            background-color: #ffffff;
        }
    </style>
</head>
<body>
<form id="test"  onsubmit="return false">
    <div class="layui-form layuimini-form">
        <div class="layui-form-item">
            <label class="layui-form-label">房间号</label>
            <div class="layui-input-block">
                <input type="text" name="room" id="room"  value="" class="layui-input" readonly="readonly">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">住户信息</label>
            <div class="layui-input-block">
                <input type="text" name="ids" id="ids" value="" class="layui-input"  readonly="readonly">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">团体或是散客</label>
            <div class="layui-input-block">
                <input type="text" name="gorl" id="gorl" value="" class="layui-input"  readonly="readonly">
                <tip>团体可享受10%折扣</tip>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">贵宾信息</label>
            <div class="layui-input-block">
                <input type="text" name="vip" id="vip" value="" class="layui-input"  readonly="readonly">
                <tip>贵宾可享受10%折扣</tip>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">房间原价</label>
            <div class="layui-input-block">
                <input type="text" name="price" id="price" value="" class="layui-input" readonly="readonly">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">入住日期</label>
            <div class="layui-input-block">
                <input type="text" class="layui-input" id="checkintime" readonly="readonly">
                <br>
                <span class="layui-word-aux" id="days"></span>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">房间单日折后价</label>
            <div class="layui-input-block">
                <input type="text" name="discount" id="discount" value="" class="layui-input" readonly="readonly"  placeholder="请输入金额">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label required">应付金额</label>
            <div class="layui-input-block">
                <input type="text" name="should" id="should" value="" class="layui-input" lay-verify="required|Ndouble"  placeholder="请输入金额">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label required" >实付金额</label>
            <div class="layui-input-block">
                <input type="text" id="actual" name="actual" lay-verify="required|Ndouble"  placeholder="请输入金额" value="" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">请给住房体验打分</label>
            <!div class="layui-input-block">
            <div id="rate"></div>
            <!/div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label required">请选择付款人</label>
            <div class="layui-input-inline" style="width:250px">
                <select name="paymen" lay-verify="required"  id="paymen"  lay-filter="showPaymen">
                    <!option value="1">请选择日期</option>
                    <!option value="2" id="ForeverUse">永久使用</option>
                    <!option value="3" id="TemporaryUse">临时使使</option>
                    <option value=""></option>
                </select>
            </div>
        </div>


        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn layui-btn-danger" lay-submit lay-filter="saveBtn">确认退房</button>
            </div>
        </div>
    </div>
    </div>
</form>
<script src="../../lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script>
var ori;
var daysComputed = function(time) {
    var oldTimeFormat = new Date(time.replace(/-/g, '/'));
    var nowDate = new Date();
    if(nowDate.getTime() - oldTimeFormat.getTime() > 0) {
        var times = nowDate.getTime() - oldTimeFormat.getTime();
        var days = parseInt(times / (60*60*24*1000));
        return days;
    } else {
        throw('传入时间不能大于当前日期');
    }
}
window.onload = function(){
    var $ = layui.jquery;
    //console.log(parent.room);
    $('#room').val(parent.room);
    $.ajax({
        type: "post",                            //传数据的方式
        url: "../../InfoServlet", //servlet地址
        data: $('#test').serialize(),           //传的数据

        success: function (result) {               //传数据成功之后的操作   result是servlet传过来的数据  这个函数对result进行处理，让它显示在 输入框中
            //alert(result) ;        //找到输入框 并且将result的值 传进去
            var JSobj = JSON.parse(result);  //字符串转对象
            //console.log(JSobj.ids[0]);
            for (var index in JSobj.ids) {
                console.log(JSobj.ids[index]);
            }
            $('#ids').val(JSobj.ids.length + "个住户: " + JSobj.ids);
            var discount = JSobj.price;
            $('#price').val(JSobj.price);
            if (JSobj.gorl == true) {
                $('#gorl').val("团体");
                discount *= 0.9;
            } else {
                $('#gorl').val("散客");
            }
            if (JSobj.vip == true) {
                $('#vip').val("有贵宾");
                discount *= 0.9;
            } else {
                $('#vip').val("无贵宾");
            }
            $('#discount').val(discount);
            var should=discount;
            layui.use('form', function () {
                var form = layui.form;//高版本建议把括号去掉，有的低版本，需要加()
                for (var index in JSobj.ids) {
                    $("#paymen").append("<option value=" + index + ">" + JSobj.ids[index] + "</option>");
                }
                form.render('select');
            });
            $('#checkintime').val(JSobj.checkintime);
            var str = daysComputed(JSobj.checkintime)+"天之前入住";
            $('#days').html(str);
            if(parseInt(str)==0)
            {
                $('#should').val(should);
            }
            else {
                $('#should').val(should * parseInt(str));
            }
        }
    });

    layui.use(['rate'], function() {
        var rate = layui.rate;
        //显示文字
        rate.render({
            elem: '#rate'
            , value: 3 //初始值
            , text: true //开启文本
        });
    })


}


layui.use(['form'], function () {
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
        var actual=$('#actual').val();
        var should=$('#should').val();
        var option=$("#paymen option:selected").text();
        console.log(option);
        //if(actual==null){layer.msg('输入不能为空');}
        //else if(!isNaN(actual)) {layer.msg('请输入数字');}
        console.log(actual);
        console.log(should);
        if(should-actual<0) {
            layer.alert('本宾馆不收小费', {
                skin: 'layui-layer-lan'
                ,closeBtn: 0
                ,anim: 4 //动画类型
            });
        }
        else if(should==actual){
            $.ajax({
                type: "post",                            //传数据的方式
                url: "../../CheckoutData", //servlet地址
                data: { room:parent.room, paymen:option ,ownmoney:should-actual,earn:actual },        //传的数据

                success: function(data){
                    //传数据成功之后的操作   result是servlet传过来的数据  这个函数对result进行处理，让它显示在 输入框中
                }
            });
            var index = layer.alert("正常退房成功！", {
                skin: 'layui-layer-molv', //样式类名
                closeBtn: 0,
                title: '提示'
            }, function () {
                // 关闭弹出层
                layer.close(index);
                //关闭当前窗口
                var iframeIndex = parent.layer.getFrameIndex(window.name);
                parent.layer.close(iframeIndex);
                parent.location.reload();

            });

        }
        else{
            //关闭当前窗口
            $.ajax({
                type: "post",                            //传数据的方式
                url: "../../CheckoutData", //servlet地址
                data: { room:parent.room, paymen:option ,ownmoney:should-actual, earn:actual},        //传的数据

                success: function(data){               //传数据成功之后的操作   result是servlet传过来的数据  这个函数对result进行处理，让它显示在 输入框中
                    alert(data) ;        //找到输入框 并且将result的值 传进去
                    $('#work').val(JSON.parse(data).password);
                    $('#remark').val(JSON.parse(data).asdf);
                }
            });
            var index = layer.alert("挂账退房成功！", {
                skin: 'layui-layer-molv', //样式类名
                closeBtn: 0,
                title: '提示'
            }, function () {
                // 关闭弹出层
                layer.close(index);
                //关闭当前窗口

                var iframeIndex = parent.layer.getFrameIndex(window.name);

                parent.layer.close(iframeIndex);
                parent.location.reload();
                parent.parent.location.reload();

            });
        }


        /*// 关闭弹出层
        layer.close(index);

        var iframeIndex = parent.layer.getFrameIndex(window.name);
        parent.layer.close(iframeIndex);
         */
    });


});

layui.use(['util', 'laydate', 'layer'], function(){
    var util = layui.util
        ,laydate = layui.laydate
        ,$ = layui.$
        ,layer = layui.layer;
    var setTimeAgo = function(y, M, d, H, m, s){
        var str = util.timeAgo(new Date(y, M||0, d||1, H||0, m||0, s||0),false);
        $('#test4').html(str);
        console.log(parseInt(str));
        if(parseInt(str)<=7){
            $('#should').val(ori*parseInt(str));
        }
        else{
            $('#should').val(ori);
        }
    };
    laydate.render({
        elem: '#test3'
        ,type: 'datetime'
        ,done: function(value, date){
            setTimeAgo(date.year, date.month - 1, date.date, date.hours, date.minutes, date.seconds);
        }
    });
})

</script>
</body>
</html>