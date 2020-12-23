<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.employee.model.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
    <link rel="stylesheet" href="../../vendors/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet type" href="./css/index_backstage.css">
</head>
<body>
	<div class="container-fluid">
        <div class="row header">
            <div class="col-2 align-self-center img-div">
                <img src="./images/white_LOGO.png">
            </div>
            <div class="col">
                <div class="row align-items-center">
                    <div class="col">HELLO!阿堃</div>
                </div>

                <div class="row align-items-center">
                    <div class="col">
                        <ul class="nav nav-tabs" id="myTab" role="tablist">
                            <li class="nav-item" role="presentation">   <!--員工系統 = emp_sys-->
                              <a class="nav-link active" id="emp_sys-tab" data-toggle="tab" href="#emp_sys" role="tab" aria-controls="emp_sys" aria-selected="true">
                              	員工系統
                              </a>
                            </li>
                            <li class="nav-item" role="presentation">   <!--帳號管理 = acc_mgt-->
                              <a class="nav-link" id="acc_mgt-tab" data-toggle="tab" href="#acc_mgt" role="tab" aria-controls="acc_mgt" aria-selected="false">
                              	帳號管理
                              </a>
                            </li>
                            <li class="nav-item" role="presentation">   <!--客服系統 = cs_sys -->
                              <a class="nav-link" id="cs_sys-tab" data-toggle="tab" href="#cs_sys" role="tab" aria-controls="cs_sys" aria-selected="false">
                              	客服系統
                              </a>
                            </li>
                            <li class="nav-item" role="presentation">   <!--出租管理 = rent_mgt -->
                              <a class="nav-link" id="rent_mgt-tab" data-toggle="tab" href="#rent_mgt" role="tab" aria-controls="rent_mgt" aria-selected="false">
                                                                出租管理
                              </a>
                            </li>
                            <li class="nav-item" role="presentation">   <!--交易管理 = tran_sys -->
                              <a class="nav-link" id="tran_sys-tab" data-toggle="tab" href="#tran_sys" role="tab" aria-controls="tran_sys" aria-selected="false">
                                                               交易系統
                              </a>
                            </li>
                            <li>
                                <button type="button" class="btn btn-danger">登出</button>
                            </li>
                          </ul>                         
                    </div>             
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col">
                <div class="tab-content" id="myTabContent">
                    <div class="tab-pane fade show active" id="emp_sys" role="tabpanel" aria-labelledby="emp_sys-tab">
                    	<%@include file="select_page.jsp"%>
                    </div>
                    <div class="tab-pane fade" id="acc_mgt" role="tabpanel" aria-labelledby="acc_mgt-tab">
                    	<%@include file="addEmployee.jsp"%>
                    </div>
                    <div class="tab-pane fade" id="cs_sys" role="tabpanel" aria-labelledby="cs_sys-tab">這裡放你要的頁面</div>
                    <div class="tab-pane fade" id="rent_mgt" role="tabpanel" aria-labelledby="rent_mgt-tab">這裡放你要的頁面</div>
                    <div class="tab-pane fade" id="tran_sys" role="tabpanel" aria-labelledby="tran_sys-tab">這裡放你要的頁面</div>
                </div>
            </div>
        </div>
    </div>


    <script src="../../vendors/jquery/jquery-3.5.1.min.js"></script>
    <script src="../../vendors/popper/popper.min.js"></script>
    <script src="../../vendors/bootstrap/js/bootstrap.min.js"></script>
    <script src="./js/index_backstage.js"></script>
</body>
</html>