<%--
  Created by IntelliJ IDEA.
  User: kimme
  Date: 2021. 11. 29.
  Time: 9:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

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
<% if()


<sql:query var="ListMatches" dataSource="${DataSource}">
    SELECT * FROM APP."Matches"
</sql:query>

<c:if test="${param.deleteId ne null}">
    <sql:update dataSource="${DataSource}" var="InsertIntoMatches">
        DELETE FROM APP."Matches" WHERE ID = ${param.deleteId}
    </sql:update>
</c:if>

<html>
<head>
    <title>Mérkőzések</title>
</head>

<body>
    <h1>Üdvözöllek <%= session.getAttribute("validUser")%>!</h1>
    <form action="Login.jsp" method="post">
        <input type="submit" value="Kijelentkezés" name="logout">
    </form>
    <br>
    <h2>Mérkőzések hozzáadása vagy törlése</h2>
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

                <td>
                    <label><input type="radio" name="win" value="1">Hazai csapat</label><br>
                    <label><input type="radio" name="win" value="2">Vendég csapat</label><br>
                    <label><input type="radio" name="win" value="3">Döntetlen</label>
                </td>
            </tr>
            <tr>
                <td>Mérkőzés dátuma</td>
                <td><input type="date" name="match_date"></td>
            </tr>
            <tr>
                <td><input type="submit" name="upload" value="Hozzáadás"></td>
            </tr>
        </table>
    </form>

        <c:if test="${!empty param.matchesErrorMsg}">
            <hr>
            <p>
                    ${param.matchesErrorMsg}
            </p>
        </c:if>

        <h2>Mérkőzések listája: </h2>

    <form action="CreateMatches.jsp" method="post">
        <table>
            <tr style="font-weight: bold;">
                <td>Meccs dátuma</td>
                <td>Hazai csapat</td>
                <td>Vendég csapat</td>
                <td>Mérkőzés törlése</td>
            </tr>
            <c:forEach var="listMatches" items="${ListMatches.rows}">
                <tr>
                    <td>${listMatches.Date}</td>
                    <td>${listMatches.FirstTeamName}</td>
                    <td>${listMatches.SecondTeamName}</td>
                    <td><button name="deleteId" id="deleteId" value="${listMatches.ID}" type="submit">Törlés</button></td>
                </tr>
            </c:forEach>
        </table>
    </form>
</body>

</html>
