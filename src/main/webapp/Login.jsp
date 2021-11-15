<%--
  Created by IntelliJ IDEA.
  User: kimme
  Date: 2021. 11. 14.
  Time: 20:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
%>

<html>
<head>
    <title>Bejelentkezés</title>
</head>
<body>
    <h2>
        Bejelentkezés
    </h2>

    <form action="CheckLogin.jsp" method="post">
        <table>
            <tbody>
            <tr>
                <td>
                    Felhasználónév:
                </td>
                <td>
                    <input type="text" size="20" name="username">
                </td>
            </tr>
            <tr>
                <td>
                    Jelszó:
                </td>
                <td>
                    <input type="password" size="20" name="password">
                </td>
            </tr>
            </tbody>
        </table>
        <input type="submit" value="Bejelentkezés" name="login" style="cursor: pointer">
    </form>

Nincs még fiókja? <a href="Register.jsp">Regisztráljon itt</a>!

<c:if test="${!empty param.loginErrorMsg}">
    <hr>
    <p style="color: red; font-weight: bold">
            ${param.loginErrorMsg}
    </p>
</c:if>

</body>
</html>
