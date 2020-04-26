<%@ page language="java" pageEncoding="gb2312"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>数据库课设-基于Layui的宾馆管理系统前端</title>
    <meta name="keywords" content="layuimini,layui,layui模板,layui后台,后台模板,admin,admin模板,layui mini">
    <meta name="description" content="layuimini基于layui的轻量级前端后台管理框架，最简洁、易用的后台框架模板，面向所有层次的前后端程序,只需提供一个接口就直接初始化整个框架，无需复杂操作。">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Access-Control-Allow-Origin" content="*">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="icon" href="images/favicon.ico">
    <link rel="stylesheet" href="./lib/layui-v2.5.5/css/layui.css" media="all">
    <link rel="stylesheet" href="./css/layuimini.css?v=2.0.3" media="all">
    <link rel="stylesheet" href="./lib/font-awesome-4.7.0/css/font-awesome.min.css" media="all">
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style id="layuimini-bg-color">
    </style>
</head>
<body class="layui-layout-body layuimini-all">
<div class="layui-layout layui-layout-admin">

    <div class="layui-header header">
        <div class="layui-logo layuimini-logo"></div>

        <div class="layuimini-header-content">
            <a>
                <div class="layuimini-tool"><i title="展开" class="fa fa-outdent" data-side-fold="1"></i></div>
            </a>

            <!--电脑端头部菜单-->
            <ul class="layui-nav layui-layout-left layuimini-header-menu mobile layui-hide-xs layuimini-menu-header-pc">
            </ul>

            <!--手机端头部菜单-->
            <ul class="layui-nav layui-layout-left layuimini-header-menu mobile layui-hide-sm">
                <li class="layui-nav-item">
                    <a href="javascript:;"><i class="fa fa-list-ul"></i> 选择模块</a>
                    <dl class="layui-nav-child layuimini-menu-header-mobile">
                    </dl>
                </li>
            </ul>

            <ul class="layui-nav layui-layout-right">

                <li class="layui-nav-item" lay-unselect>
                    <a href="javascript:;" data-refresh="刷新"><i class="fa fa-refresh"></i></a>
                </li>
                <li class="layui-nav-item" lay-unselect>
                    <a href="javascript:;" data-clear="清理" class="layuimini-clear"><i class="fa fa-trash-o"></i></a>
                </li>
                <li class="layui-nav-item mobile layui-hide-xs" lay-unselect>
                    <a href="javascript:;" data-check-screen="full"><i class="fa fa-arrows-alt"></i></a>
                </li>
                <li class="layui-nav-item layuimini-setting">
                    <a href="javascript:;" id="login"><%=request.getParameter("id")%></a>
                    <dl class="layui-nav-child">
                        <dd>
                            <a href="javascript:;" layuimini-content-href="page/staffinfo.jsp" data-title="基本资料" data-icon="fa fa-gears">基本资料<span class="layui-badge-dot"></span></a>
                        </dd>
                        <dd>
                            <hr>
                        </dd>
                        <dd>
                            <a href="http://localhost:4399/keshe_war_exploded/;" class="login-out" onclick="flushstorage()">退出登录</a>
                        </dd>
                    </dl>
                </li>
                <li class="layui-nav-item layuimini-select-bgcolor mobile layui-hide-xs" lay-unselect>
                    <a href="javascript:;" data-bgcolor="配色方案"><i class="fa fa-ellipsis-v"></i></a>
                </li>
            </ul>
        </div>
    </div>

    <!--无限极左侧菜单-->
    <div class="layui-side layui-bg-black layuimini-menu-left">
    </div>

    <!--初始化加载层-->
    <div class="layuimini-loader">
        <div class="layuimini-loader-inner"></div>
    </div>

    <!--手机端遮罩层-->
    <div class="layuimini-make"></div>

    <!-- 移动导航 -->
    <div class="layuimini-site-mobile"><i class="layui-icon">?</i></div>

    <div class="layui-body">

        <div class="layuimini-tab layui-tab-rollTool layui-tab" lay-filter="layuiminiTab" lay-allowclose="true">
            <ul class="layui-tab-title">
                <li class="layui-this" id="layuiminiHomeTabId" lay-id=""></li>
            </ul>
            <div class="layui-tab-control">
                <li class="layuimini-tab-roll-left layui-icon layui-icon-left"></li>
                <li class="layuimini-tab-roll-right layui-icon layui-icon-right"></li>
                <li class="layui-tab-tool layui-icon layui-icon-down">
                    <ul class="layui-nav close-box">
                        <li class="layui-nav-item">
                            <a href="javascript:;"><span class="layui-nav-more"></span></a>
                            <dl class="layui-nav-child">
                                <dd><a href="javascript:;" layuimini-tab-close="current">关 闭 当 前</a></dd>
                                <dd><a href="javascript:;" layuimini-tab-close="other">关 闭 其 他</a></dd>
                                <dd><a href="javascript:;" layuimini-tab-close="all">关 闭 全 部</a></dd>
                            </dl>
                        </li>
                    </ul>
                </li>
            </div>
            <div class="layui-tab-content">
                <div id="layuiminiHomeTabIframe" class="layui-tab-item layui-show"></div>
            </div>
        </div>

        <div class="layui-card-header"><i class="fa fa-credit-card icon icon-blue"></i>快捷入口</div>
        <div class="layui-card-body">
            <div class="welcome-module">
                <div class="layui-row layui-col-space10 layuimini-qiuck">
                    <div class="layui-col-xs3 layuimini-qiuck-module">
                        <a href="javascript:;" layuimini-content-href="page/menu.html" data-title="菜单管理" data-icon="fa fa-window-maximize">
                            <i class="fa fa-window-maximize"></i>
                            <cite>菜单管理</cite>
                        </a>
                    </div>
                    <div class="layui-col-xs3 layuimini-qiuck-module">
                        <a href="javascript:;" layuimini-content-href="page/setting.html" data-title="系统设置" data-icon="fa fa-gears">
                            <i class="fa fa-gears"></i>
                            <cite>系统设置</cite>
                        </a>
                    </div>
                    <div class="layui-col-xs3 layuimini-qiuck-module">
                        <a href="javascript:;" layuimini-content-href="page/table.html" data-title="表格示例" data-icon="fa fa-file-text">
                            <i class="fa fa-file-text"></i>
                            <cite>表格示例</cite>
                        </a>
                    </div>
                    <div class="layui-col-xs3 layuimini-qiuck-module">
                        <a href="javascript:;" layuimini-content-href="page/icon.html" data-title="图标列表" data-icon="fa fa-dot-circle-o">
                            <i class="fa fa-dot-circle-o"></i>
                            <cite>图标列表</cite>
                        </a>
                    </div>
                    <div class="layui-col-xs3 layuimini-qiuck-module">
                        <a href="javascript:;" layuimini-content-href="page/form.html" data-title="表单示例" data-icon="fa fa-calendar">
                            <i class="fa fa-calendar"></i>
                            <cite>表单示例</cite>
                        </a>
                    </div>
                    <div class="layui-col-xs3 layuimini-qiuck-module">
                        <a href="javascript:;" layuimini-content-href="page/404.html" data-title="404页面" data-icon="fa fa-hourglass-end">
                            <i class="fa fa-hourglass-end"></i>
                            <cite>404页面</cite>
                        </a>
                    </div>
                    <div class="layui-col-xs3 layuimini-qiuck-module">
                        <a href="javascript:;" layuimini-content-href="page/button.html" data-title="按钮示例" data-icon="fa fa-snowflake-o">
                            <i class="fa fa-snowflake-o"></i>
                            <cite>按钮示例</cite>
                        </a>
                    </div>
                    <div class="layui-col-xs3 layuimini-qiuck-module">
                        <a href="javascript:;" layuimini-content-href="page/layer.html" data-title="弹出层" data-icon="fa fa-shield">
                            <i class="fa fa-shield"></i>
                            <cite>弹出层</cite>
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-header"><i class="fa fa-line-chart icon"></i>报表统计</div>
                <div class="layui-card-body">
                    <div id="echarts-records" style="width: 100%;min-height:500px"></div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script src="js/lay-config.js?v=2.0.0" charset="utf-8"></script>
<script>
    window.onload=function () {
        console.log(window.localStorage.getItem("id"));
        if(window.localStorage.getItem("id")==null)
            window.location.href="404.jsp";
    }

    function flushstorage()
    {
        window.localStorage.clear();
    }

layui.use(['jquery', 'layer', 'miniAdmin','miniTongji','echarts'], function () {
    var $ = layui.jquery,
        layer = layui.layer,
        miniAdmin = layui.miniAdmin,
        miniTongji = layui.miniTongji,
        echarts = layui.echarts;

    var options = {
        iniUrl: "api/init.json",    // 初始化接口
        clearUrl: "api/clear.json", // 缓存清理接口
        urlHashLocation: true,      // 是否打开hash定位
        bgColorDefault: 0,          // 主题默认配置
        multiModule: true,          // 是否开启多模块
        menuChildOpen: false,       // 是否默认展开菜单
        loadingTime: 0,             // 初始化加载时间
        pageAnim: true,             // iframe窗口动画
        maxTabNum: 20,              // 最大的tab打开数量
    };
    miniAdmin.render(options);

    // 百度统计代码，只统计指定域名
    miniTongji.render({
        specific: true,
        domains: [
            '99php.cn',
            'layuimini.99php.cn',
            'layuimini-onepage.99php.cn',
        ],
    });

    $('.login-out').on("click", function () {
        layer.msg('退出登录成功', function () {
            window.location = '';
        });
    });

    /**
     * 报表功能
     */
    var echartsRecords = echarts.init(document.getElementById('echarts-records'), 'walden');
    var optionRecords = {
        tooltip: {
            trigger: 'axis'
        },
        legend: {
            data:['邮件营销','联盟广告','视频广告','直接访问','搜索引擎']
        },
        grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            containLabel: true
        },
        toolbox: {
            feature: {
                saveAsImage: {}
            }
        },
        xAxis: {
            type: 'category',
            boundaryGap: false,
            data: ['周一','周二','周三','周四','周五','周六','周日']
        },
        yAxis: {
            type: 'value'
        },
        series: [
            {
                name:'邮件营销',
                type:'line',
                data:[120, 132, 101, 134, 90, 230, 210]
            },
            {
                name:'联盟广告',
                type:'line',
                data:[220, 182, 191, 234, 290, 330, 310]
            },
            {
                name:'视频广告',
                type:'line',
                data:[150, 232, 201, 154, 190, 330, 410]
            },
            {
                name:'直接访问',
                type:'line',
                data:[320, 332, 301, 334, 390, 330, 320]
            },
            {
                name:'搜索引擎',
                type:'line',
                data:[820, 932, 901, 934, 1290, 1330, 1320]
            }
        ]
    };
    echartsRecords.setOption(optionRecords);

    // echarts 窗口缩放自适应
    window.onresize = function(){
        echartsRecords.resize();
    }

});
</script>
</body>
</html>
