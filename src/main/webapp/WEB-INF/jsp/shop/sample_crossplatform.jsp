<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>LG유플러스 전자결제 샘플 페이지 (XPay)</title>
	<script type="text/javascript">
		function LPad(digit, size, attatch) {
			var add = "";
			digit = digit.toString();

			if (digit.length < size) {
				var len = size - digit.length;
				for (i = 0; i < len; i++) {
					add += attatch;
				}
			}
			return add + digit;
		}

		function makeoid() {
			var now = new Date();
			var years = now.getFullYear();
			var months = LPad(now.getMonth() + 1, 2, "0");
			var dates = LPad(now.getDate(), 2, "0");
			var hours = LPad(now.getHours(), 2, "0");
			var minutes = LPad(now.getMinutes(), 2, "0");
			var seconds = LPad(now.getSeconds(), 2, "0");
			var timeValue = years + months + dates + hours + minutes + seconds;
			document.getElementById("LGD_OID").value = "test_" + timeValue;
			document.getElementById("LGD_TIMESTAMP").value = timeValue;
		}

		/*
		 * 인증요청 처리
		 */
		function doPay() {
			// OID, TIMESTAMP 생성
			makeoid();
			// 결제창 호출
			document.getElementById("LGD_PAYINFO").submit();
		}
	</script>
</head>
<body>
<form method="post" id="LGD_PAYINFO" action="/shop/payreq_crossplatform">
	<div>
		<table>
			<tr>
				<td>상점아이디(t를 제외한 아이디) </td>
				<td><input type="text" name="CST_MID" id="CST_MID" value="fithawaii"/></td>
			</tr>
			<tr>
				<td>서비스,테스트 </td>
				<td><input type="text" name="CST_PLATFORM" id="CST_PLATFORM" value="test"/></td>
			</tr>
			<tr>
				<td>구매자 이름 </td>
				<td><input type="text" name="LGD_BUYER" id="LGD_BUYER" value="홍길동"/></td>
			</tr>
			<tr>
				<td>상품정보 </td>
				<td><input type="text" name="LGD_PRODUCTINFO" id="LGD_PRODUCTINFO" value="HotelHawaii"/></td>
			</tr>
			<tr>
				<td>결제금액 </td>
				<td><input type="text" name="LGD_AMOUNT" id="LGD_AMOUNT" value="50000"/></td>
			</tr>
			<tr>
				<td>구매자 이메일 </td>
				<td><input type="text" name="LGD_BUYEREMAIL" id="LGD_BUYEREMAIL" value=""/></td>
			</tr>
			<tr>
				<td>주문번호 </td>
				<td><input type="text" name="LGD_OID" id="LGD_OID" value="test_1234567890020"/></td>
			</tr>
			<tr>
				<td>타임스탬프 </td>
				<td><input type="text" name="LGD_TIMESTAMP" id="LGD_TIMESTAMP" value="1234567890"/></td>
			</tr>
			<tr>
				<td>초기결제수단 </td>
				<td>
					<select name="LGD_CUSTOM_USABLEPAY" id="LGD_CUSTOM_USABLEPAY">
						<option value="SC0010">신용카드</option>
						<option value="SC0030">계좌이체</option>
						<option value="SC0040">무통장입금</option>
						<option value="SC0060">휴대폰</option>
						<option value="SC0070">유선전화결제</option>
						<option value="SC0090">OK캐쉬백</option>
						<option value="SC0111">문화상품권</option>
						<option value="SC0112">게임문화상품권</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>결제창 호출 방식 </td>
				<td>
					<select name="LGD_WINDOW_TYPE" id="LGD_WINDOW_TYPE">
						<option value="iframe">iframe</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>신용카드 카드사 인증 페이지 연동 방식 </td>
				<td>
					<select name="LGD_CUSTOM_SWITCHINGTYPE" id="LGD_CUSTOM_SWITCHINGTYPE">
						<option value="IFRAME">IFRAME</option>
					</select>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="button" value="결제하기" onclick="doPay();" /><br/>
				</td>
			</tr>
		</table>
	</div>
</form>
</body>
</html>
