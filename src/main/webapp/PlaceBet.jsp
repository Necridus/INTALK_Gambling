<%--
  Created by IntelliJ IDEA.
  User: Kata
  Date: 2021.11.28.
  Time: 21:39
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
        user="Gambling"
        password="123"
        scope="application"
        url="jdbc:derby://localhost:1527/Gambling_DataBase_Remote"
/>
<html>
<head>
    <link rel="stylesheet" href="style.css">
    <title>Fogadás</title>
</head>
<body>
<h1>Üdvözöllek <%= session.getAttribute("validUser")%>!</h1>
<form action="CheckLogin.jsp" method="post">
    <input type="submit" value="Kijelentkezés" name="logout">
</form>
<h2>Tedd meg a fogadásod!</h2>

<sql:query var="ListMatches" dataSource="${DataSource}">
    SELECT * FROM APP."Matches"
</sql:query>


<form action="Result.jsp" method="post">
    <p>Ekkora összeget szeretnék feltenni: <input type="number" name="bet" value="0"></p>
    <table>
        <tr style="font-weight: bold;">
            <td>Meccs dátuma</td>
            <td>Hazai csapat neve</td>
            <td>Vendég csapat neve</td>
            <td>Nyer a hazai csapat?</td>
        </tr>
        <c:forEach var="listMatches" items="${ListMatches.rows}">
            <tr>
                <td>${listMatches.Date}</td>
                <td>${listMatches.FirstTeamName}</td>
                <td>${listMatches.SecondTeamName}</td>
                <td>
                    <input type="checkbox" name="selected[]" value="${listMatches.ID}"> ${listMatches.FirstTeamName} nyer
                </td>
            </tr>
        </c:forEach>
    </table>

    <input type="submit" value="Fogadás" name="placeBet">
</form>



</body>
</html>
