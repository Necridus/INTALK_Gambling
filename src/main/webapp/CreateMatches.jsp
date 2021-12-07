<%--
  Created by IntelliJ IDEA.
  User: kimme
  Date: 2021. 11. 29.
  Time: 9:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
%>

<sql:setDataSource
        var="DataSource"
        driver="org.apache.derby.jdbc.ClientDriver"
        url="jdbc:derby://localhost:1527/Gambling_DataBase_Remote"
        scope="application"
        user="Gambling"
        password="123"
/>

<html>
<head>
    <title>Mérkőzések</title>
</head>


<body>
    <h1>Üdvözöllek <%= session.getAttribute("validUser")%>!</h1>
    <form action="CheckLogin.jsp" method="post">
        <input type="submit" value="Kijelentkezés" name="logout">
    </form>
    <br>
    <h2>Meccsek hozzáadása vagy törlése</h2>
    <p><b><i>(Lehetőséged van focimeccsek hozzáadására vagy törlésére az ellenfelek, a győztes csapat és a meccs dátumának megadásával!)</i></b></p><br>

    <form action="CheckCreateMatches.jsp" method="POST">
        <table>
            <tr>
                <td>Hazai csapat</td>
                <td><input type="textbox" name="home" size="20"></td>
            </tr>
            <tr>
                <td>Vendég csapat</td>
                <td><input type="textbox" name="guest" size="20"></td>
            </tr>
            <tr>
                <td>Ki lesz a győztes csapat?</td>
                <td><label><input type="radio" name="win_home" value="false">Hazai csapat</label><br>
                    <label><input type="radio" name="win_guest" value="false">Vendég csapat</label></td>
            </tr>
            <tr>
                <td>Mérkőzés dátuma</td>
                <td><input type="date" name="match_date"></td>
            </tr>
            <tr>
                <td><input type="submit" name="upload" value="Feltöltés"></td>
            </tr>

        </table>
    </form>
</body>

</html>
