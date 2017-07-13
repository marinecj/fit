<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>

<link rel="stylesheet" href="/resources/asset/css/bootstrap.min.css">
<link rel="stylesheet" href="/resources/asset/css/bootstrap-theme.min.css">

<style type="text/css">
#areaColumnInfo {overflow-y:auto}
</style>

</head>
<body role="document">

<div class="content" style="width:100%">
	<h2 class="tit">엑셀 임포트</h2>
	<h4>엑셀 데이터를 DB로 입력합니다.</h4>

	<form method="post" action="/excelimport/fileUpload" enctype="multipart/form-data">
	
		<div class="gray_box">
			<dl class="search">
			<dt>엑셀 파일 선택</dt>
			<dd><input type="file" name="file" /></dd>
			</dl>
			<dl class="search" id="compositeArea" style="display:none">
				<dt>xls sheet name</dt>
				<dd>
					<input type="text" id="txtSheetName">
				</dd>
			</dl>
		</div>
		<div class="action" style="text-align:center;margin-top:20px;">
			<button type="button" id="btnSubmit" class="btn btn-lg btn-warning">디비에 저장하기</button>
		</div>
	</form>
	
	<div id="d_loading_layer" style="position:absolute; left:0; top:0; width:100%; height:100%; background-color:black; opacity:0.3; z-index:1; text-align:center; display:none;">
		<img src="/resources/asset/images/common/loading.gif" style="margin-top:100px;" />
	</div>
</div>

<c:if test="${result != null}">
	<div class="gray_box">
		<dl class="search">
			<dt>임포트 결과 : ${result}</dt>
			<dd>${excelValue}</dd>
		</dl>
	</div>
</c:if>

<script type="text/javascript" src="/resources/asset/js/plugin/jquery-2.1.3.js"></script>
<script type="text/javascript" src="/resources/asset/js/plugin/bootstrap.min.js"></script>

<script type="text/javascript">
var xlsImportView = new (function() {
	var that = this;
	var welTxtSheetName, welCompositeArea, welBtnAddConfig;
	var welConfigText;
	var welBtnSubmit;
	
	var initElement = function() {
		welTxtSheetName = $("#txtSheetName");
		welConfigText = $("#config");
		welBtnAddConfig = $("#btnAddConfig");
		welBtnSubmit = $("#btnSubmit");
	}
	
	var initEvent = function() {
		welBtnAddConfig.bind("click", addConfig);
		welBtnSubmit.bind("click", submitForm);
	}
	
	this.init = function() {
		initElement();
		initEvent();
	}

	function submitForm() {
		$("#d_loading_layer").show();
		$("form")[0].submit();
	}

	function addConfig() {
		var text = welConfigText.val();
		if ($.trim(text).length > 0) {
			text += "@@";
		}
		text += welTxtSheetName.val() + "#\n" + welSelSchema.val() + "#\n" + welSelTable.val() + "#\n";
		welConfigText.val(text);
	}
})();

$(document).ready(function() {
	xlsImportView.init();
});
</script>

</body>
</html>