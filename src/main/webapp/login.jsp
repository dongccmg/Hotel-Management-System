
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>后台管理-登陆</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Access-Control-Allow-Origin" content="*">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="lib/layui-v2.5.5/css/layui.css" media="all">
    <link rel="stylesheet" href="css/public.css" media="all">
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style>
        html, body {width: 100%;height: 100%;overflow: hidden}
        body {background: #009688;}
        body:after {content:'';background-repeat:no-repeat;background-size:cover;-webkit-filter:blur(3px);-moz-filter:blur(3px);-o-filter:blur(3px);-ms-filter:blur(3px);filter:blur(3px);position:absolute;top:0;left:0;right:0;bottom:0;z-index:-1;}
        .layui-container {width: 100%;height: 100%;overflow: hidden}
        .admin-login-background {width:360px;height:300px;position:absolute;left:50%;top:40%;margin-left:-180px;margin-top:-100px;}
        .logo-title {text-align:center;letter-spacing:2px;padding:14px 0;}
        .logo-title h1 {color:#009688;font-size:25px;font-weight:bold;}
        .login-form {background-color:#fff;border:1px solid #fff;border-radius:3px;padding:14px 20px;box-shadow:0 0 8px #eeeeee;}
        .login-form .layui-form-item {position:relative;}
        .login-form .layui-form-item label {position:absolute;left:1px;top:1px;width:38px;line-height:36px;text-align:center;color:#d2d2d2;}
        .login-form .layui-form-item input {padding-left:36px;}
        .captcha {width:60%;display:inline-block;}
        .captcha-img {display:inline-block;width:34%;float:right;}
        .captcha-img img {height:34px;border:1px solid #e6e6e6;height:36px;width:100%;}
    </style>
</head>
<body>
<div class="layui-container">
    <div class="admin-login-background">
        <div class="layui-form login-form">
            <form class="layui-form" action="index.jsp">
                <div class="layui-form-item logo-title">
                    <h1>宾馆管理系统后台登录</h1>
                </div>
                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <input type="radio" name="authority" value="staff" title="酒店员工" checked="" lay-filter="status"><br>
                        <input type="radio" name="authority" value="admin" title="大堂经理" lay-filter="status">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-icon layui-icon-username" for="username"></label>
                    <input type="text" name="username" lay-verify="required|account" placeholder="用户名或者邮箱" autocomplete="off" class="layui-input" value="">
                </div>
                <div class="layui-form-item">
                    <label class="layui-icon layui-icon-password" for="password"></label>
                    <input type="password" name="password" lay-verify="required|password" placeholder="密码" autocomplete="off" class="layui-input" value="">
                </div>

                <div class="layui-form-item">
                    <input type="checkbox" name="rememberMe" value="true" lay-skin="primary" title="记住密码">
                </div>
                <div class="layui-form-item">
                    <button class="layui-btn layui-btn-fluid"  lay-submit="" lay-filter="login">登 入</button>
                </div>
            </form>
        </div>
    </div>
</div>
<script src="lib/jquery-3.4.1/jquery-3.4.1.min.js" charset="utf-8"></script>
<script src="lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script src="lib/jq-module/jquery.particleground.min.js" charset="utf-8"></script>
<script>
var st;
layui.use(['form'], function () {
    var form = layui.form,
        layer = layui.layer;

    // 登录过期的时候，跳出ifram框架
    if (top.location != self.location) top.location = self.location;

    // 粒子线条背景
    $(document).ready(function(){
        $('.layui-container').particleground({
            dotColor:'#5cbdaa',
            lineColor:'#5cbdaa'
        });
    });
    form.on('radio(status)', function(data){
        console.log(data.value); //被点击的radio的value值
        st=data.value;
    });
    // 进行登录操作
    form.on('submit(login)', function (data) {
        data = data.field;
        console.log(data);
        if (data.authority=='admin' && data.username == 'admin' && data.password=='admin') {
            layer.msg('登录成功', function () {
                window.localStorage.setItem("id","admin");
                var id='admin';
                window.location.href = 'index.jsp?id='+id;
                return true;
            });
        }
        else if (data.authority=='staff' && data.username == 'staff' && data.password=='staff') {
            layer.msg('登录成功', function () {
                window.localStorage.setItem("id","staff");
                var id='staff';
                window.location.href = 'index.jsp?id='+id;
                return true;
            });
        }
        else  {
            layer.msg('用户名或密码错误');
            return false;
        }


        return false;
    });
});
</script>
</body>
</html>