<%@page import="java.util.Iterator"%>
<%@page import="com.member.model.MemberService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.List"%>
<%@page import="com.member.model.MemberVO"%>


<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/friendchat.css" type="text/css" />
<script
	src="<%=request.getContextPath()%>/vendors/jquery/jquery-3.5.1.min.js"></script>
<style type="text/css">
</style>
<title>最大私人聊天室</title>

</head>


<body onload="connect();" onunload="disconnect();">
	<h3 id="statusOutput" class="statusOutput"></h3>

	<div id="row">
		<!-- 		<div id="" class="column" name="friendName" -->
		<%-- 			value="${memberVO.m_email}"> --%>
		<%-- 			<h2>${memberVO.m_name}</h2> --%>

		<%
		    String loginId = session.getAttribute("loginId").toString();
			MemberService memberSvc = new MemberService();
			List<MemberVO> memberlist = (List<MemberVO>) memberSvc.getAll();
			for(int i=0;i<memberlist.size();i++){
				if(memberlist.get(i).getM_id().equals(loginId)){
					memberlist.remove(i);
				}
			}
			
			pageContext.setAttribute("memberlist", memberlist);
		%>
		
		
		

		<c:forEach var="memberlist" items="${memberlist}">
			<div id="" class="column" name="friendName"
				value="${memberlist.m_email}">
				<h2>${memberlist.m_name}</h2>
			</div>
		</c:forEach>

	</div>

	<div id="messagesArea" class="panel message-area"></div>
	<div class="panel input-area">
		<input id="message" class="text-field" type="text"
			placeholder="Message"
			onkeydown="if (event.keyCode == 13) sendMessage();" /> <input
			type="submit" id="sendMessage" class="button" value="Send"
			onclick="sendMessage();" />
	</div>
	<h1>
		登入帳號為:<font color=red> ${loginName} </font>
	</h1>
	<input type="hidden" class="hiddeninput" value="">


</body>


<script>
	var MyPoint = "/FriendWS/${account}";
	var host = window.location.host;
	var path = window.location.pathname;
	var webCtx = path.substring(0, path.indexOf('/', 1));
	var endPointURL = "ws://" + window.location.host + webCtx + MyPoint;
	console.log(endPointURL)
	var statusOutput = document.getElementById("statusOutput");
	var messagesArea = document.getElementById("messagesArea");
	var self = '${account}';
	var webSocket;

	function connect() {
		// create a websocket
		webSocket = new WebSocket(endPointURL);

		webSocket.onopen = function(event) {
			console.log("Connect Success!");
			document.getElementById('sendMessage').disabled = false;
			document.getElementById('connect').disabled = true;
			document.getElementById('disconnect').disabled = false;
		};

		webSocket.onmessage = function(event) {
			var jsonObj = JSON.parse(event.data);
			console.log(jsonObj);
			console.log("chat" === jsonObj.type
					&& $(".hiddeninput").val() == jsonObj.sender)
			if ("open" === jsonObj.type) {
				refreshFriendList(jsonObj);
			} else if ("history" === jsonObj.type) {
				messagesArea.innerHTML = '';
				var ul = document.createElement('ul');
				ul.id = "area";
				messagesArea.appendChild(ul);
				// 這行的jsonObj.message是從redis撈出跟好友的歷史訊息，再parse成JSON格式處理
				var messages = JSON.parse(jsonObj.message);
				for (var i = 0; i < messages.length; i++) {
					var historyData = JSON.parse(messages[i]);
					var showMsg = historyData.message;
					var li = document.createElement('li');
					// 根據發送者是自己還是對方來給予不同的class名, 以達到訊息左右區分
					historyData.sender === self ? li.className += 'me'
							: li.className += 'friend';
					li.innerHTML = showMsg;
					ul.appendChild(li);
				}
				messagesArea.scrollTop = messagesArea.scrollHeight;
			} else if ("chat" === jsonObj.type) {
				var li = document.createElement('li');

				// 				jsonObj.sender === self ? li.className += 'me'
				// 						: li.className += 'friend';
				if (jsonObj.sender === self) {
					li.className += 'me'
				}
				if ($(".hiddeninput").val() == jsonObj.sender) {
					li.className += 'friend'
				}
				li.innerHTML = jsonObj.message;
				console.log(li);

				document.getElementById("area").appendChild(li);
				messagesArea.scrollTop = messagesArea.scrollHeight;
			} else if ("close" === jsonObj.type) {
				refreshFriendList(jsonObj);
			}

		};

		webSocket.onclose = function(event) {
			console.log("Disconnected!");
		};
	}

	function sendMessage() {
		var inputMessage = document.getElementById("message");
		// 		var friend = statusOutput.textContent;
		var friend = $(".hiddeninput").val();
		var message = inputMessage.value.trim();

		if (message === "") {
			alert("Input a message");
			inputMessage.focus();
		} else if (friend === "") {
			alert("Choose a friend");
		} else {
			var jsonObj = {
				"type" : "chat",
				"sender" : self,
				"receiver" : friend,
				"message" : message
			};
			console.log(jsonObj);

			webSocket.send(JSON.stringify(jsonObj));
			inputMessage.value = "";
			inputMessage.focus();
		}
	}

	// 有好友上線或離線就更新列表
	function refreshFriendList(jsonObj) {
		var friends = jsonObj.users;
		var row = document.getElementById("row");
		// 		row.innerHTML = '';
		// 		for (var i = 0; i < friends.length; i++) {
		// 			if (friends[i] === self) { continue; }
		// 			row.innerHTML +='<div id=' + i + ' class="column" name="friendName" value=' + friends[i] + ' ><h2>' + friends[i] + '</h2></div>';
		// 		}
		addListener();
	}
	function refreshFriendList(jsonObj) {
		var friends = jsonObj.users;
		var row = document.getElementById("row");
		var div =
		// 		row.innerHTML = '';
		// 		for (var i = 0; i < friends.length; i++) {
		// 			if (friends[i] === self) { continue; }
		// 			row.innerHTML +='<div id=' + i + ' class="column" name="friendName" value=' + friends[i] + ' ><h2>' + friends[i] + '</h2></div>';
		// 		}
		addListener();
	}
	// 註冊列表點擊事件並抓取好友名字以取得歷史訊息
	function addListener() {
		var container = document.getElementById("row");
		// 		container.addEventListener("click", function(e) {
		// 			var friend = e.srcElement.textContent
		$('.column')
				.click(
						function(e) {
							var friend = e.currentTarget.attributes.value.textContent;
							$(".hiddeninput").val(friend);
							var friend_name = e.currentTarget.children[0].childNodes[0].textContent;
							console.log(e);
							console.log(friend_name);
							updateFriendName(friend_name);
							var jsonObj = {
								"type" : "history",
								"sender" : self,
								"receiver" : friend,
								"message" : ""
							};
							console.log(jsonObj)
							webSocket.send(JSON.stringify(jsonObj));
						});
	}

	function disconnect() {
		webSocket.close();
		document.getElementById('sendMessage').disabled = true;
		document.getElementById('connect').disabled = false;
		document.getElementById('disconnect').disabled = true;
	}

	function updateFriendName(name) {
		statusOutput.innerHTML = name;
	}
</script>
</html>