<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
  <title>银行服务端管理系统</title>
  <link rel="stylesheet" href="/css/layui.css">
 
</head>
<style id="layui-bg-color">
.layui-bg-gray{background-color: #eee!important; color: #666!important;}
body .layui-tab .layui-tab-content{height: 1000px;}
</style>
<body class="layui-layout-body" >
<div class="layui-layout layui-layout-admin">
  <div class="layui-header">
    <div class="layui-logo">银行服务端管理系统</div>
    
    <ul class="layui-nav layui-layout-right">
      <li class="layui-nav-item">
        <a href="javascript:;">
         张三
        </a>
        <dl class="layui-nav-child">
          <dd><a href="">基本资料</a></dd>
          <dd><a href="">安全设置</a></dd>
        </dl>
      </li>
      <li class="layui-nav-item"><a href="">注销</a></li>
					<li class="layui-nav-item layui-hide-xs" lay-unselect>
            <a href="javascript:;" data-bgcolor="配色方案">
              <i class="layui-icon layui-icon-theme" ></i>
            </a>
          </li>
    </ul>
  </div>
  
<div class="layui-side layui-bg-black">
    <div class="layui-side-scroll">
      <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
      <ul class="layui-nav layui-nav-tree"  lay-filter="test">
        <li class="layui-nav-item layui-this"><a href="javascript:;" data-id="1" data-title="客户信息" data-url="bank/kehuxx.jsp" class="site-demo-active" data-type="tabAdd">客户信息</a></li>
					<li class="layui-nav-item"><a href="javascript:;" data-id="2" data-title="转账记录" data-url="bank/zzjl.jsp" class="site-demo-active" data-type="tabAdd">转账记录</a>
					</li>
					<li class="layui-nav-item"><a href="javascript:;" data-id="3" data-title="外行转账处理" data-url="bank/whjl.jsp" class="site-demo-active" data-type="tabAdd">外行转账处理</a>
					</li>
					<li class="layui-nav-item"><a href="javascript:;">结算账单</a>
						<dl class="layui-nav-child">
							<dd><a href="javascript:;" data-id="4" data-title="自动结算的账单" data-url="bank/kehuxx.jsp" class="site-demo-active" data-type="tabAdd">自动结算的账单</a></dd>
							<dd><a href="javascript:;" data-id="5" data-title="人工结算的账单" data-url="bank/kehuxx.jsp" class="site-demo-active" data-type="tabAdd">人工结算的账单</a></dd>
							<dd><a href="javascript:;" data-id="6" data-title="出现异常的账单" data-url="bank/kehuxx.jsp" class="site-demo-active" data-type="tabAdd">出现异常的账单</a></dd>
						</dl>
					</li>
            </ul>
        </div>
  </div>
  
    <!--tab标签-->
    <div class="layui-tab" lay-filter="demo" lay-allowclose="true" style="margin-left: 200px;">
        <ul class="layui-tab-title"></ul>
        <div class="layui-tab-content"></div>
    </div>
  
  <div class="layui-footer">
    <!-- 底部固定区域 -->
    MooZi开发
  </div>
</div>

<script src="/js/layui.js"></script>
 <script src="/js/color.js"></script>
<script>


//JavaScript代码区域
layui.use('element', function(){
  var element = layui.element;
  
});
//实现右侧窗口的显示
  layui.use(['element', 'layer', 'jquery'], function () {
        var element = layui.element;
        // var layer = layui.layer;
        var $ = layui.$;
        // 配置tab实践在下面无法获取到菜单元素
        $('.site-demo-active').on('click', function () {
            var dataid = $(this);
            //这时会判断右侧.layui-tab-title属性下的有lay-id属性的li的数目，即已经打开的tab项数目
            if ($(".layui-tab-title li[lay-id]").length <= 0) {
                //如果比零小，则直接打开新的tab项
                active.tabAdd(dataid.attr("data-url"), dataid.attr("data-id"), dataid.attr("data-title"));
            } else {
                //否则判断该tab项是否以及存在
                var isData = false; //初始化一个标志，为false说明未打开该tab项 为true则说明已有
                $.each($(".layui-tab-title li[lay-id]"), function () {
                    //如果点击左侧菜单栏所传入的id 在右侧tab项中的lay-id属性可以找到，则说明该tab项已经打开
                    if ($(this).attr("lay-id") == dataid.attr("data-id")) {
                        isData = true;
                    }
                })
                if (isData == false) {
                    //标志为false 新增一个tab项
                    active.tabAdd(dataid.attr("data-url"), dataid.attr("data-id"), dataid.attr("data-title"));
                }
            }
            //最后不管是否新增tab，最后都转到要打开的选项页面上
            active.tabChange(dataid.attr("data-id"));
        });

        var active = {
            //在这里给active绑定几项事件，后面可通过active调用这些事件
            tabAdd: function (url, id, name) {
                //新增一个Tab项 传入三个参数，分别对应其标题，tab页面的地址，还有一个规定的id，是标签中data-id的属性值
                //关于tabAdd的方法所传入的参数可看layui的开发文档中基础方法部分
                element.tabAdd('demo', {
                    title: name,
                    content: '<iframe data-frameid="' + id + '" scrolling="auto" frameborder="0" src="' + url + '" style="width:100%;height:99%;"></iframe>',
                    id: id //规定好的id
                })
                FrameWH();  //计算ifram层的大小
            },
            tabChange: function (id) {
                //切换到指定Tab项
                element.tabChange('demo', id); //根据传入的id传入到指定的tab项
            },
            tabDelete: function (id) {
                element.tabDelete("demo", id);//删除
            }
        };
        function FrameWH() {
            var h = $(window).height();
            $("iframe").css("height",h+"px");
        }
  
    });
</script>

</body>
</html>