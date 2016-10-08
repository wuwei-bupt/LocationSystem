<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  <%@ include file="/common/bootstrap.jsp"%>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/bootstrap/css/grain_home.css">
  <title>储粮害虫监测-首页</title>
</head>
<body>
  <div class="person-center">
    <div class="container">
                欢迎您，来自<a href="">北京市昌平区</a>的用户
      <a href="" class="c-personal right" style="margin-left:0px;">收藏本站</a>
      <a class="c-personal right">|</a>
      <a class="c-personal right" style="margin-right:0px">您的登陆IP是:8.8.8.8</a>
    </div>
  </div>
  <!-- navbar part -->
  <header>
    <nav class="navbar navbar-inverse" role="navagation">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#example-navbar-collapse">
            <span class="sr-only">Toggle Navagation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a href="./" class="navbar-brand">储粮害虫监测</a>
        </div><!--end of navbar-header-->
        <div class="collapse navbar-collapse" id="example-navbar-collapse">
          <ul class="nav navbar-nav navbar-left">
            <li><a href="./index.jsp">首页</a></li>
            <li><a href="">虫调</a></li>
            <li><a href="./depoter/common/main" target="_blank">粮库</a></li>
            <li><a href="">专家</a></li>
            <li><a href="">农户</a></li>
            <li><a href="">加工厂</a></li>
            <li><a href="">知识库</a></li>
            <li class="active"><a href="./app.jsp">APP</a></li>
            <li><a href="./news.jsp">通知公告</a></li>
          </ul>
          <form action="#" class="navbar-form navbar-right" role="search">
            <div class="input-group">
      			<input type="text" class="form-control" placeholder="Search...">
      			<span class="input-group-btn">
        			<button class="btn btn-default" type="button">
        				<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
        			</button>
      			</span>
    		</div>
          </form>
        </div>
      </div>
    </nav>
  </header>

 <div class="container">
    <div class="panel panel-default" style="border-color:#88C833;border-radius:30px;border-width:3px;">
      <div class="panel-body" style="padding:50px;">
        <div class="row">
          <div class="col-md-4">
            <img src="./resources/images/u30.jpg" style="width:80%">
          </div>
          <div class="col-md-4" style="border-right-style:solid;border-left-style:solid;border-color:#88C833;">
            <div class="row">
              <div class="col-md-8">
                <img src="./resources/images/u28.png", style="width:100%">
              </div>
              <div class="col-md-4">
                <h3>粮库版</h3>
              </div>

            </div>
            <div class="row">
              <div class="col-md-8">
                <img src="./resources/images/u28.png", style="width:100%">
              </div>
              <div class="col-md-4">
                <h3>专家版</h3>
              </div>
            </div>
            <div class="row">
              <div class="col-md-8">
                <img src="./resources/images/u28.png", style="width:100%">
              </div>
              <div class="col-md-4">
                <h3>农户版</h3>
              </div>
            </div>
            <div class="row">
              <div class="col-md-8">
                <img src="./resources/images/u28.png", style="width:100%">
              </div>
              <div class="col-md-4">
                <h3>工厂版</h3>
              </div>
            </div>
          </div>
          <div class="col-md-4">
            <div class="row">
              <div class="col-md-8">
                <img src="./resources/images/u26.png", style="width:100%">
              </div>
              <div class="col-md-4">
                <h3>粮库版</h3>
              </div>

            </div>
            <div class="row">
              <div class="col-md-8">
                <img src="./resources/images/u26.png", style="width:100%">
              </div>
              <div class="col-md-4">
                <h3>专家版</h3>
              </div>
            </div>
            <div class="row">
              <div class="col-md-8">
                <img src="./resources/images/u26.png", style="width:100%">
              </div>
              <div class="col-md-4">
                <h3>农户版</h3>
              </div>
            </div>
            <div class="row">
              <div class="col-md-8">
                <img src="./resources/images/u26.png", style="width:100%">
              </div>
              <div class="col-md-4">
                <h3>工厂版</h3>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- know about us -->
  <div class="jumbotron">
    <div class="container text-center">
      <h2>了解我们</h2>
      <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Reiciendis praesentium distinctio quam totam, molestiae voluptatem ut, placeat expedita sequi ad quisquam libero pariatur voluptatibus maiores sint harum. Neque, commodi, odit!</p>
      <div class="btn-group">
        <a href="#" class="btn btn-lg btn-success">联系我们</a>
        <a href="#" class="btn btn-lg btn-default">收藏网站</a>
      </div>
    </div>
  </div><!--end jumbotron-->

  <div class="container text-center"><p>&copy;Copyright 2016.</p></div>

</body>
</html>
