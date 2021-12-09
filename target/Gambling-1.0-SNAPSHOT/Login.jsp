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
    <title>Bejelentkezés</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="style.css">
</head>
<body class="text-center fontFormat bodyBackground">
<div class="customContainer justify-content-center col-5 rounded-3">
    <h2 class="text-uppercase mb-4 fw-bold">
        Bejelentkezés
    </h2>
    <form action="CheckLogin.jsp" method="post">
        <div class="row justify-content-center">
        <table class="table table-borderless table-sm w-25 ms-5 fw-bold">
            <tbody>
            <tr>
                <td class="w-25 pt-3 text-end">
                    Felhasználónév:
                </td>
                <td>
                    <input type="text" size="20" name="username" class="rounded-2 p-2">
                </td>
            </tr>
            <tr>
                <td class="w-25 pt-3 text-end">
                    Jelszó:
                </td>
                <td>
                    <input type="password" size="20" name="password" class="rounded-2 p-2">
                </td>
            </tr>
            </tbody>
        </table>
        </div>
        <input type="submit" class="btn btn-primary mb-4" value="Bejelentkezés" name="login">
    </form>
        <p>Nincs még fiókja? <a href="Register.jsp">Regisztráljon itt</a>!</p>

<c:if test="${!empty param.loginErrorMsg}">
    <p class="text-danger fw-bold">
            ${param.loginErrorMsg}
    </p>
</c:if>
</div>
</body>
</html>
