<%@ page language="java" contentType="text/html; charset=EUC-KR" %>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<script type="text/javascript">

		function setLGDResult() {
			parent.payment_return();
			try {
			} catch (e) {
				alert(e.message);
			}
		}

	</script>
</head>
<body onload="setLGDResult()">
<p><h1>RETURN_URL (인증결과)</h1></p>
<div>
	<p>LGD_RESPCODE (결과코드) : <c:out value="${PAYREQ_MAP.LGD_RESPCODE}"/></p>
	<p>LGD_RESPMSG (결과메시지): <c:out value="${PAYREQ_MAP.LGD_RESPMSG}"/></p>
	<form method="post" name="LGD_RETURNINFO" id="LGD_RETURNINFO">
		<c:forEach items="${PAYREQ_MAP}" var="payReqMap" varStatus="status">
			<input type='hidden' name='${payReqMap.key}' id='${payReqMap.key}' value='${payReqMap.value}'>
		</c:forEach>
	</form>
</div>
</body>
</html>