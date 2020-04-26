<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>首页二</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="../lib/layui-v2.5.5/css/layui.css" media="all">
    <link rel="stylesheet" href="../lib/font-awesome-4.7.0/css/font-awesome.min.css" media="all">
    <link rel="stylesheet" href="../css/public.css" media="all">
    <style>
        .layui-card {border:1px solid #f2f2f2;border-radius:5px;}
        .icon {margin-right:10px;color:#1aa094;}
        .icon-cray {color:#ffb800!important;}
        .icon-blue {color:#1e9fff!important;}
        .icon-tip {color:#ff5722!important;}
        .layuimini-qiuck-module {text-align:center;margin-top: 10px}
        .layuimini-qiuck-module a i {display:inline-block;width:100%;height:60px;line-height:60px;text-align:center;border-radius:2px;font-size:30px;background-color:#F8F8F8;color:#333;transition:all .3s;-webkit-transition:all .3s;}
        .layuimini-qiuck-module a cite {position:relative;top:2px;display:block;color:#666;text-overflow:ellipsis;overflow:hidden;white-space:nowrap;font-size:14px;}
        .welcome-module {width:100%;height:210px;}
        .panel {background-color:#fff;border:1px solid transparent;border-radius:3px;-webkit-box-shadow:0 1px 1px rgba(0,0,0,.05);box-shadow:0 1px 1px rgba(0,0,0,.05)}
        .panel-body {padding:10px}
        .panel-title {margin-top:0;margin-bottom:0;font-size:12px;color:inherit}
        .label {display:inline;padding:.2em .6em .3em;font-size:75%;font-weight:700;line-height:1;color:#fff;text-align:center;white-space:nowrap;vertical-align:baseline;border-radius:.25em;margin-top: .3em;}
        .layui-red {color:red}
        .main_btn > p {height:40px;}
        .layui-bg-number {background-color:#F8F8F8;}
        .layuimini-notice:hover {background:#f6f6f6;}
        .layuimini-notice {padding:7px 16px;clear:both;font-size:12px !important;cursor:pointer;position:relative;transition:background 0.2s ease-in-out;}
        .layuimini-notice-title,.layuimini-notice-label {
            padding-right: 70px !important;text-overflow:ellipsis!important;overflow:hidden!important;white-space:nowrap!important;}
        .layuimini-notice-title {line-height:28px;font-size:14px;}
        .layuimini-notice-extra {position:absolute;top:50%;margin-top:-8px;right:16px;display:inline-block;height:16px;color:#999;}
    </style>
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">
        <div class="layui-card-body">
            <div class="welcome-module">
                <div class="layui-row layui-col-space10 layuimini-qiuck">
                    <div class="layui-col-xs3 layuimini-qiuck-module">
                        <a href="javascript:;" layuimini-content-href="page/checkin.jsp" data-title="入住" data-icon="fa fa-window-maximize">
                            <i class="fa fa-window-maximize"></i>
                            <cite>入住</cite>
                        </a>
                    </div>
                    <div class="layui-col-xs3 layuimini-qiuck-module">
                        <a href="javascript:;" layuimini-content-href="page/reserve.jsp" data-title="预约" data-icon="fa fa-gears">
                            <i class="fa fa-gears"></i>
                            <cite>预约</cite>
                        </a>
                    </div>
                    <div class="layui-col-xs3 layuimini-qiuck-module">
                        <a href="javascript:;" layuimini-content-href="page/guest.jsp" data-title="贵宾注册" data-icon="fa fa-file-text">
                            <i class="fa fa-file-text"></i>
                            <cite>贵宾注册</cite>
                        </a>
                    </div>
                    <div class="layui-col-xs3 layuimini-qiuck-module">
                        <a href="javascript:;" layuimini-content-href="page/checkout.jsp" data-title="退房换房" data-icon="fa fa-dot-circle-o">
                            <i class="fa fa-dot-circle-o"></i>
                            <cite>退房换房</cite>
                        </a>
                    </div>
                    <div class="layui-col-xs3 layuimini-qiuck-module">
                        <a href="javascript:;" layuimini-content-href="page/returnmoney.jsp" data-title="挂单补款结账" data-icon="fa fa-hourglass-end">
                            <i class="fa fa-calendar"></i>
                            <cite>挂单补款结账</cite>
                        </a>
                    </div>
                    <div class="layui-col-xs3 layuimini-qiuck-module">
                        <a href="javascript:;" layuimini-content-href="page/form.jsp" data-title="统计报表" data-icon="fa fa-calendar">
                            <i class="fa fa-hourglass-end"></i>
                            <cite>统计报表</cite>
                        </a>
                    </div>
                    <div class="layui-col-xs3 layuimini-qiuck-module">
                        <a href="javascript:;" layuimini-content-href="page/welcome.jsp" data-title="微笑服务" data-icon="fa fa-snowflake-o">
                            <i class="fa fa-snowflake-o"></i>
                            <cite>微笑服务</cite>
                        </a>
                    </div>
                    <div class="layui-col-xs3 layuimini-qiuck-module">
                        <a href="javascript:;" layuimini-content-href="http://localhost:4399/keshe_war_exploded/" data-title="退出登录" data-icon="fa fa-shield">
                            <i class="fa fa-shield"></i>
                            <cite>退出登录</cite>
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-row layui-col-space15">
            <div class="layui-col-xs12 layui-col-md9">
            <div class="layui-card-header"><i class="fa fa-line-chart icon"></i>预期营业额</div>
                <div id="echarts-records" style="width: 100%;min-height:500px"></div>
            </div>
            <div class="layui-col-xs12 layui-col-md3">
                <div id="echarts-pies" style="background-color:#ffffff;min-height:350px;padding: 10px"></div>
            </div>
        </div>
    </div>
</div>
<script src="../lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script src="../js/lay-config.js?v=1.0.4" charset="utf-8"></script>
<script>
    layui.use(['layer', 'miniTab','echarts'], function () {
        var $ = layui.jquery,
            layer = layui.layer,
            miniTab = layui.miniTab,
            echarts = layui.echarts;

        miniTab.listen();

        /**
         * 报表功能
         */
        var echartsRecords = echarts.init(document.getElementById('echarts-records'), 'walden');
        var optionRecords = {
            tooltip: {
                trigger: 'axis'
            },
            legend: {
                data:['豪华套房入住','单人房入住','三人房入住','双人房入住','总入住人数']
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
                    name:'豪华套房入住',
                    type:'line',
                    data:[120, 132, 101, 134, 90, 230, 210]
                },
                {
                    name:'单人房入住',
                    type:'line',
                    data:[220, 182, 191, 234, 290, 330, 310]
                },
                {
                    name:'三人房入住',
                    type:'line',
                    data:[150, 232, 201, 154, 190, 330, 410]
                },
                {
                    name:'双人房入住',
                    type:'line',
                    data:[320, 332, 301, 334, 390, 330, 320]
                },
                {
                    name:'总入住人数',
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

        /**
         * 玫瑰图表
         */
        var echartsPies = echarts.init(document.getElementById('echarts-pies'), 'walden');
        var optionPies = {
            title: {
                text: '每日期望入住',
                left: 'center'
            },
            tooltip: {
                trigger: 'item',
                formatter: '{a} <br/>{b} : {c} ({d}%)'
            },
            legend: {
                orient: 'vertical',
                left: 'left',
                data: ['单人房入住', '双人房入住', '三人房入住', '豪华房入住']
            },
            series: [
                {
                    name: '入住人数',
                    type: 'pie',
                    radius: '55%',
                    center: ['50%', '60%'],
                    roseType: 'radius',
                    data: [
                        {value: 251, name: '单人房入住'},
                        {value: 333, name: '双人房入住'},
                        {value: 238, name: '三人房入住'},
                        {value: 145, name: '豪华房入住'}
                    ],
                    emphasis: {
                        itemStyle: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    }
                }
            ]
        };
        echartsPies.setOption(optionPies);

    });
</script>
</body>
</html>
