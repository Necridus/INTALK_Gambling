<%--
  Created by IntelliJ IDEA.
  User: kimme
  Date: 2021. 11. 14.
  Time: 20:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
%>

<html>
<head>
    <title>Regisztráció</title>
</head>
<body>
<h2>
    Regisztráció
</h2>
        <form action="CheckRegister.jsp" method="post">
            <table>
                <tbody>
                <tr>
                    <td>
                        Név:
                    </td>
                    <td>
                        <input type="text" size="20" name="name">
                    </td>
                </tr>
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
            <input type="submit" value="Regisztráció" name="register" style="cursor: pointer">
        </form>

Van már fiókja? <a href="Login.jsp">Jelentkezzen be</a>!

<c:if test="${!empty param.registerErrorMsg}">
    <hr>
    <p style="color: red; font-weight: bold">
            ${param.registerErrorMsg}
    </p>
</c:if>
</body>
</html>
