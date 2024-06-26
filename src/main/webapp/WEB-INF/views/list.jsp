<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/common.css" type="text/css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
	
</style>
</head>
<body>
	게시판 리스트
	<hr>
	<button onclick="del()">선택삭제</button>
	<table>
		<thead>
			<tr>
				<th><input type="checkbox" id="all"/></th>
				<th>글번호</th>
				<th>이미지</th>
				<th>제목</th>
				<th>작성자</th>
				<th>조회수</th>
				<th>날짜</th>
			</tr>
		</thead>
		<tbody id="list">
		</tbody>
			<%-- <c:forEach items="${list }" var="item">
				<tr>
					<td><input type="checkbox" name="del" value="${item.idx }"/></td>
					<td>${item.idx }</td>
					<td>
						<c:if test="${item.img_cnt > 0}"><img src="resources/img/image.png" class="icon"></c:if>
						<c:if test="${item.img_cnt == 0}"><img src="resources/img/no_image.png" class="icon"></c:if>
					</td>
					<td>${item.subject }</td>
					<td>${item.user_name }</td>
					<td>${item.bHit }</td>
					<td>${item.reg_date }</td>
				</tr>
			</c:forEach> --%>
	</table>
</body>
<script>
	$(document).ready(function(){// html 문서가 모두 읽히고나면 다음 내용을 실행 해라
		listCall();		
	});
	function del() {//체크 표시된 값을 delArr 에 담아보자
		var delArr=[];
		$('input[name="del"]').each(function(idx,item){
			if ($(item).is(':checked')) {
				delArr.push($(item).val());
			}
		})
		console.log('delArr : ', delArr);
		
		$.ajax({
			type:'post',
			url:'./del',
			data:{delList:delArr},
			dataType:'json',
			success:function(data){
				console.log(data);	
				if (data.cnt>0) {
					alert(data.cnt + '개의 글이 삭제되었습니다.')
					$('#list').empty();
					listCall();
				}
			},
			error:function(error){
				console.log(error);
			}
		})
	}
	
	function listCall(){
		$.ajax({
			type:'get'
			,url:'./list.ajax'
			,data:{}
			,dataType:'json'
			,success:function(data){
				drawList(data.list);
			}
			,error:function(error){
				console.log(error);
			}
		});
	}

	
	function drawList(list){
		var content = '';
		for (item of list) {
			/* console.log(item); */
			content += '<tr>';
			content += '<td><input type="checkbox" name="del" value="' + item.idx + '"onclick = "set()" /></td>';
			content += '<td>' + item.idx + '</td>';
			content += '<td>';
			
			var img = item.img_cnt > 0 ? 'image.png' : 'no_image.png';
			content += '<img src="resources/img/' + img + '" class="icon">';
			
			content += '</td>';
			content += '<td>' + item.subject + '</td>';
			content += '<td>' + item.user_name + '</td>';
			content += '<td>' + item.bHit + '</td>';
			
			// java.sql.Date 는 javascript 에서는 밀리세컨드로 변환 하여 표시 한다.
			// 방법 1. Back-end - DTO 의 반환 날짜 타입을 문자열로 변경
			//content += '<td>' + item.reg_date + '</td>';
			// 방법 2. Front-end - js 에서 직접 변환
			var date = new Date(item.reg_date);
			var dateStr = date.toLocaleDateString("ko-KR");//en_US
			content += '<td>' + dateStr + '</td>';
			content += '</tr>';
		}
		$('#list').html(content);
	};
	
	$('#all').on('click',function(){
		// attr : 정적속성 : 처음부터 그려저 있거나 jsp에서 그린 내용
		// prop : 동적속성 : 자바스크립트로 나중에 그려진 내용
		if ($('#all').prop('checked')) {
			$('input[name="del"]').prop('checked',true);			
		} else {
			$('input[name="del"]').prop('checked',false);
		}
	});	
	
	function set (){
		console.log('del');
		var total = $('input[name="del"]:checked').length;
		var checked = $('input[name="del"]').length;
		
		if (total != checked) {
			$('#all').prop('checked',false);
		} else {
			$('#all').prop('checked',true);
		}
	};
	
	
	
	
	
	
</script>
</html>