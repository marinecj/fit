<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>통합LG유플러스 전자결서비스 결제테스트</title>
	<script language="javascript" src="http://xpay.uplus.co.kr/xpay/js/xpay_crossplatform.js" type="text/javascript"></script>
	<script type="text/javascript">

		/*
		 * 수정불가.
		 */
		var LGD_window_type = '${PAYREQ_MAP.LGD_WINDOW_TYPE}';

		/*
		 * 수정불가
		 */
		function launchCrossPlatform(){
			lgdwin = openXpay(document.getElementById('LGD_PAYINFO'), '${PAYREQ_MAP.CST_PLATFORM }', LGD_window_type, null, "", "");
		}
		/*
		 * FORM 명만  수정 가능
		 */
		function getFormObject() {
			return document.getElementById("LGD_PAYINFO");
		}

		/*
		 * 인증결과 처리
		 */
		function payment_return() {
			var fDoc;

			fDoc = lgdwin.contentWindow || lgdwin.contentDocument;


			if (fDoc.document.getElementById('LGD_RESPCODE').value == "0000") {

				document.getElementById("LGD_PAYKEY").value = fDoc.document.getElementById('LGD_PAYKEY').value;
				document.getElementById("LGD_PAYINFO").target = "_self";
				document.getElementById("LGD_PAYINFO").action = "/shop/payres";
				document.getElementById("LGD_PAYINFO").submit();
			} else {
				alert("LGD_RESPCODE (결과코드) : " + fDoc.document.getElementById('LGD_RESPCODE').value + "\n" + "LGD_RESPMSG (결과메시지): " + fDoc.document.getElementById('LGD_RESPMSG').value);
				closeIframe();
			}
		}

	</script>
</head>
<body>
<form method="post" name="LGD_PAYINFO" id="LGD_PAYINFO" action="/shop/payres">
	<table>
		<tr>
			<td>구매자 이름 </td>
			<td>${PAYREQ_MAP.LGD_BUYER }</td>
		</tr>
		<tr>
			<td>상품정보 </td>
			<td>${PAYREQ_MAP.LGD_PRODUCTINFO }</td>
		</tr>
		<tr>
			<td>결제금액 </td>
			<td>${PAYREQ_MAP.LGD_AMOUNT }</td>
		</tr>
		<tr>
			<td>구매자 이메일 </td>
			<td>${PAYREQ_MAP.LGD_BUYEREMAIL }</td>
		</tr>
		<tr>
			<td>주문번호 </td>
			<td>${PAYREQ_MAP.LGD_OID }</td>
		</tr>
		<tr>
			<td colspan="2">* 추가 상세 결제요청 파라미터는 메뉴얼을 참조하시기 바랍니다.</td>
		</tr>
		<tr>
			<td colspan="2"></td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="button" value="인증요청" onclick="launchCrossPlatform();"/>
			</td>
		</tr>
	</table>
	<c:forEach items="${PAYREQ_MAP}" var="payReqMap" varStatus="status">
		<input type='hidden' name='${payReqMap.key}' id='${payReqMap.key}' value='${payReqMap.value}'>
	</c:forEach>
</form>

</body>

</html>
