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
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<%
    if (session.getAttribute("validUser") == null) { %>
<jsp:forward page="Login.jsp">
    <jsp:param name="loginErrorMsg" value="A játék előtt jelentkezz be!"/>
</jsp:forward>
<% }
%>

<c:if test="${param.logout ne null}">
    <jsp:forward page="Login.jsp">
        <jsp:param name="loginErrorMsg" value="Sikeres kijelentkezés"/>
    </jsp:forward>
    <%session.invalidate();%>
</c:if>

<h1>Kedves <%= session.getAttribute("validUser")%>!</h1>
<form action="Result.jsp" method="post">
    <input type="submit" value="Kijelentkezés" name="logout">
</form>
<h2>A fogadásod eredménye a következő:</h2>

<sql:query var="ListMatches" dataSource="${DataSource}">
    SELECT * FROM APP."Matches"
</sql:query>

<sql:query var="GetValidUser" dataSource="${DataSource}">
    SELECT APP."Users"."ID"
    FROM APP."Users"
    WHERE APP."Users"."Username" = '<%= session.getAttribute("validUser")%>'
</sql:query>

<c:forEach var="getValidUser" items="${GetValidUser.rows}">
    <c:set var="validUser" value="${getValidUser.ID}"/>
</c:forEach>

<sql:query var="ListBetsAndMatches" dataSource="${DataSource}">
    SELECT APP."Users"."ID", APP."Bets"."BetValue", APP."Bets"."WinnerTeam", APP."Matches"."Date", APP."Matches"."FirstTeamName", APP."Matches"."SecondTeamName", APP."Matches"."FirstTeamWon", APP."Matches"."SecondTeamWon", APP."Matches"."Draw"
    FROM APP."Bets"
    JOIN APP."Matches" ON APP."Bets"."Match_ID" = APP."Matches"."ID"
    JOIN APP."Users" ON APP."Bets"."User_ID" = APP."Users"."ID"
    WHERE APP."Users"."ID" = ${validUser}
</sql:query>

<c:set var="nyeremeny" value="0"/>

<c:choose>
    <c:when test="${!empty param.placeBet}">
        <table>
            <tr style="font-weight: bold">
                <td>Meccs dátuma</td>
                <td>Első csapat neve</td>
                <td>Második csapat neve</td>
                <td>Meccs eredménye</td>
                <td>Tipped</td>
                <td>Felrakott összeg</td>
                <td>Tippedért kapott összeg</td>
                <td>Egyenleged</td>
            </tr>
            <c:forEach var="listBetsAndMatches" items="${ListBetsAndMatches.rows}">
                <tr>
                    <td>${listBetsAndMatches.Date}</td>
                    <td>${listBetsAndMatches.FirstTeamName}</td>
                    <td>${listBetsAndMatches.SecondTeamName}</td>
                    <td>
                        <c:choose>
                            <c:when test="${listBetsAndMatches.FirstTeamWon == true}">
                                ${listBetsAndMatches.FirstTeamName} nyer
                            </c:when>
                            <c:when test="${listBetsAndMatches.SecondTeamWon == true}">
                                ${listBetsAndMatches.SecondTeamName} nyer
                            </c:when>
                            <c:when test="${listBetsAndMatches.Draw == true}">
                                Döntetlen
                            </c:when>
                        </c:choose>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${listBetsAndMatches.WinnerTeam == 1}">
                                ${listBetsAndMatches.FirstTeamName} nyert
                            </c:when>
                            <c:when test="${listBetsAndMatches.WinnerTeam == 2}">
                                ${listBetsAndMatches.SecondTeamName} nyert
                            </c:when>
                            <c:when test="${listBetsAndMatches.WinnerTeam == 0}">
                                Döntetlen
                            </c:when>
                        </c:choose>
                    </td>
                    <td>
                        ${listBetsAndMatches.BetValue} Ft
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${listBetsAndMatches.WinnerTeam == 1 && listBetsAndMatches.FirstTeamWon == true}">
                                ${listBetsAndMatches.BetValue*2} Ft
                            </c:when>
                            <c:when test="${listBetsAndMatches.WinnerTeam == 2 && listBetsAndMatches.SecondTeamWon == true}">
                                ${listBetsAndMatches.BetValue*2} Ft
                            </c:when>
                            <c:when test="${listBetsAndMatches.WinnerTeam == 0 && listBetsAndMatches.Draw == true}">
                                ${listBetsAndMatches.BetValue*2} Ft
                            </c:when>
                            <c:otherwise>
                                ${listBetsAndMatches.BetValue*0} Ft
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${listBetsAndMatches.WinnerTeam == 1 && listBetsAndMatches.FirstTeamWon == true}">
                                ${nyeremeny = nyeremeny + listBetsAndMatches.BetValue*2} Ft
                            </c:when>
                            <c:when test="${listBetsAndMatches.WinnerTeam == 2 && listBetsAndMatches.SecondTeamWon == true}">
                                ${nyeremeny = nyeremeny + listBetsAndMatches.BetValue*2} Ft
                            </c:when>
                            <c:when test="${listBetsAndMatches.WinnerTeam == 0 && listBetsAndMatches.Draw == true}">
                                ${nyeremeny = nyeremeny + listBetsAndMatches.BetValue*2} Ft
                            </c:when>
                            <c:otherwise>
                                ${nyeremeny} Ft
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
        </table>

        <h2>
            Végső egyenleged: ${nyeremeny} Ft
        </h2>

        <form action="PlaceBet.jsp" method="post">
            <input type="submit" name="newGame" value="Új játék!">
        </form>
    </c:when>
</c:choose>
</body>
</html>
