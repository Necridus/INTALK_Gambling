<%--
  Created by IntelliJ IDEA.
  User: Kata
  Date: 2021.11.28.
  Time: 23:19
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
    <title>Eredmény</title>
</head>
<body>
<h1>Kedves <%= session.getAttribute("validUser")%>!</h1>
<form action="CheckLogin.jsp" method="post">
    <input type="submit" value="Kijelentkezés" name="logout">
</form>
<h2>A fogadásod eredménye a következő:</h2>

<sql:query var="ListMatches" dataSource="${DataSource}">
    SELECT * FROM APP."Matches"
</sql:query>

<%
    int pontok = 0;
    int penz = Integer.parseInt(request.getParameter("bet"));
    int nyeremeny = 0;
%>

<c:choose>
    <c:when test="${!empty param.placeBet}">
        <table>
            <tr>
                <td>Meccs dátuma</td>
                <td>Első csapat neve</td>
                <td>Második csapat neve</td>
                <td>Első csapat eredménye</td>
                <td>Második csapat eredménye</td>
                <td>Tipped</td>
                <td>Eredményed</td>
                <td>Pontjaid</td>
                <td>Nyeremény</td>
            </tr>
            <c:forEach var="listMatches" items="${ListMatches.rows}">
                <tr>
                    <td>${listMatches.Date}</td>
                    <td>${listMatches.FirstTeamName}</td>
                    <td>${listMatches.SecondTeamName}</td>
                    <td>
                        <c:if test="${listMatches.FirstTeamWon}">
                            Nyert
                        </c:if>
                        <c:if test="${listMatches.SecondTeamWon}">
                            Vesztett
                        </c:if>
                    </td>
                    <td>
                        <c:if test="${listMatches.FirstTeamWon}">
                            Vesztett
                        </c:if>
                        <c:if test="${listMatches.SecondTeamWon}">
                            Nyert
                        </c:if>
                    </td>
                    <td>
                        <c:if test="${param.result == 1}">
                            ${listMatches.FirstTeamName} nyer
                        </c:if>
                        <c:if test="${param.result == 2}">
                            ${listMatches.SecondTeamName} nyer
                        </c:if>
                    </td>
                    <td>
                        <c:if test="${listMatches.FirstTeamWon && param.result == 1}">
                            Nyertél
                            <%
                                pontok++;
                                nyeremeny = nyeremeny + penz;
                            %>
                        </c:if>
                        <c:if test="${listMatches.FirstTeamWon && param.result == 2}">
                            Vesztettél
                            <%
                                pontok--;
                                nyeremeny = nyeremeny - penz;
                            %>
                        </c:if>
                        <c:if test="${listMatches.SecondTeamWon && param.result == 2}">
                            Nyertél
                            <%
                                pontok++;
                                nyeremeny = nyeremeny + penz;
                            %>
                        </c:if>
                        <c:if test="${listMatches.SecondTeamWon && param.result == 1}">
                            Vesztettél
                            <%
                                pontok--;
                                nyeremeny = nyeremeny - penz;
                            %>
                        </c:if>
                    </td>
                    <td><%=pontok%></td>
                    <td><%=nyeremeny%></td>
                </tr>
            </c:forEach>
        </table>

        <h2>
            Összesen szerzett pontok száma: <%=pontok%> <br>
            Nyereményed összesen: <%=nyeremeny%>
        </h2>
    </c:when>
</c:choose>
</body>
</html>
