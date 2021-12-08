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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="style.css">
</head>
<body class="text-center fontFormat bodyBackground">
<div class="customContainer justify-content-center col-5 rounded-3">
    <h2 class="text-uppercase mb-4 fw-bold">
    Regisztráció
    </h2>
        <form action="CheckRegister.jsp" method="post">
            <div class="row justify-content-center">
            <table class="table table-borderless table-sm ms-5">
                <tbody>
                <tr>
                    <td class="w-25 fw-bold pt-3 text-end">
                        E-mail cím:
                    </td>
                    <td>
                        <input type="email" size="50" name="email" class="rounded-2 p-2">
                    </td>
                </tr>
                <tr>
                    <td class="w-25 fw-bold pt-3 text-end">
                        Felhasználónév:
                    </td>
                    <td>
                        <input type="text" size="50" name="username" class="rounded-2 p-2">
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="fst-italic">
                        A felhasználónév legyen legalább 5 karakter hosszú és tartalmazzon legalább egy kis- és nagybetűt!
                    </td>
                </tr>
                <tr>
                    <td class="w-25 fw-bold pt-3 text-end">
                        Jelszó:
                    </td>
                    <td>
                        <input type="password" size="50" name="password" class="rounded-2 p-2">
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="fst-italic">
                        A jelszó legyen legalább 5 karakter hosszú!
                    </td>
                </tr>
                <tr>
                    <td class="w-25 fw-bold pt-3 text-end">
                        Jelszó megerősítése:
                    </td>
                    <td>
                        <input type="password" size="50" name="confirmpassword" class="rounded-2 p-2">
                    </td>
                </tr>
                </tbody>
            </table>
            </div>
            <input type="submit" value="Regisztráció" value="Regisztráció" name="register" class="btn btn-primary">
        </form>

Van már fiókja? <a href="Login.jsp">Jelentkezzen be</a>!

<c:if test="${!empty param.registerErrorMsg}">
    <p style="color: red; font-weight: bold">
            ${param.registerErrorMsg}
    </p>
</c:if>
</div>
</body>
</html>
