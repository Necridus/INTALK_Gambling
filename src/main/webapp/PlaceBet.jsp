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

<sql:query var="ListMatches" dataSource="${DataSource}">
    SELECT * FROM APP."Matches"
</sql:query>

<c:if test="${param.firstTeamWins ne null}">
    <sql:query var="CountMatches" dataSource="${DataSource}">
        SELECT COUNT(*) as NumberOfMatches
        FROM APP."Bets"
        WHERE APP."Bets"."Match_ID" = ${param.firstTeamWins}
    </sql:query>

    <c:forEach var="countMatches" items="${CountMatches.rows}">
        <c:set var="numberOfMatches" value="${countMatches.NumberOfMatches}"/>
    </c:forEach>

    <c:choose>
        <c:when test="${numberOfMatches > 0}">
            <h2 style="color: red;">Ezt a meccset már hozzáadtad a szelvényedhez!</h2>
        </c:when>
        <c:otherwise>
            <sql:update dataSource="${DataSource}" var="InsertIntoBets">
                INSERT INTO APP."Bets" ("Match_ID", "User_ID", "WinnerTeam", "BetValue")
                VALUES (${param.firstTeamWins}, 1, 1, ${param.betValue})
            </sql:update>
        </c:otherwise>
    </c:choose>
</c:if>

<c:if test="${param.secondTeamWins ne null}">
    <sql:query var="CountMatches" dataSource="${DataSource}">
        SELECT COUNT(*) as NumberOfMatches
        FROM APP."Bets"
        WHERE APP."Bets"."Match_ID" = ${param.secondTeamWins}
    </sql:query>

    <c:forEach var="countMatches" items="${CountMatches.rows}">
        <c:set var="numberOfMatches" value="${countMatches.NumberOfMatches}"/>
    </c:forEach>

    <c:choose>
        <c:when test="${numberOfMatches > 0}">
            <h2 style="color: red;">Ezt a meccset már hozzáadtad a szelvényedhez!</h2>
        </c:when>
        <c:otherwise>
            <sql:update dataSource="${DataSource}" var="InsertIntoBets">
                INSERT INTO APP."Bets" ("Match_ID", "User_ID", "WinnerTeam", "BetValue")
                VALUES (${param.secondTeamWins}, 1, 2, ${param.betValue})
            </sql:update>
        </c:otherwise>
    </c:choose>
</c:if>

<c:if test="${param.draw ne null}">
    <sql:query var="CountMatches" dataSource="${DataSource}">
        SELECT COUNT(*) as NumberOfMatches
        FROM APP."Bets"
        WHERE APP."Bets"."Match_ID" = ${param.draw}
    </sql:query>

    <c:forEach var="countMatches" items="${CountMatches.rows}">
        <c:set var="numberOfMatches" value="${countMatches.NumberOfMatches}"/>
    </c:forEach>

    <c:choose>
        <c:when test="${numberOfMatches > 0}">
            <h2 style="color: red;">Ezt a meccset már hozzáadtad a szelvényedhez!</h2>
        </c:when>
        <c:otherwise>
            <sql:update dataSource="${DataSource}" var="InsertIntoBets">
                INSERT INTO APP."Bets" ("Match_ID", "User_ID", "WinnerTeam", "BetValue")
                VALUES (${param.draw}, 1, 0, ${param.betValue})
            </sql:update>
        </c:otherwise>
    </c:choose>
</c:if>

<c:if test="${param.deleteId ne null}">
    <sql:update dataSource="${DataSource}" var="InsertIntoBets">
        DELETE FROM APP."Bets" WHERE ID = ${param.deleteId}
    </sql:update>
</c:if>

<h2>Állítsd össze a szelvényed!</h2>

<form action="PlaceBet.jsp" method="post">
    <p>Felrakni kívánt összeg: <input type="number" value="500" name="betValue"> Ft</p>

    <p>Elérhető meccsek listája: </p>
    <table>
        <tr style="font-weight: bold;">
            <td>Meccs dátuma</td>
            <td>Hazai csapat neve</td>
            <td>Vendég csapat neve</td>
            <td>Melyik csapat nyer?</td>
        </tr>
        <c:forEach var="listMatches" items="${ListMatches.rows}">
            <tr>
                <td>${listMatches.Date}</td>
                <td>${listMatches.FirstTeamName}</td>
                <td>${listMatches.SecondTeamName}</td>
                <td>
                    <button name="firstTeamWins" id="firstTeamWins" value="${listMatches.ID}" type="submit">${listMatches.FirstTeamName}</button>
                    <button name="secondTeamWins" id="secondTeamWins" value="${listMatches.ID}" type="submit">${listMatches.SecondTeamName}</button>
                    <button name="draw" id="draw" value="${listMatches.ID}" type="submit">Döntetlen</button>
                </td>
            </tr>
        </c:forEach>
    </table>
</form>

<c:if test="${(param.firstTeamWins ne null || param.secondTeamWins ne null || param.draw ne null) || param.deleteId ne null}">
    <sql:query var="ListBets" dataSource="${DataSource}">
        SELECT APP."Bets"."ID", APP."Bets"."Match_ID", APP."Bets"."BetValue", APP."Bets"."WinnerTeam", APP."Matches"."Date", APP."Matches"."FirstTeamName", APP."Matches"."SecondTeamName"
        FROM APP."Bets"
        JOIN APP."Matches"
        ON APP."Bets"."Match_ID" = APP."Matches"."ID"
    </sql:query>

    <h2>Szelvényed:</h2>
    <form action="PlaceBet.jsp" method="post">
        <table>
            <tr style="font-weight: bold;">
                <td>Meccs dátuma</td>
                <td>Hazai csapat neve</td>
                <td>Vendég csapat neve</td>
                <td>Melyik csapat fog nyerni?</td>
                <td>Felrakott összeg</td>
            </tr>
            <c:forEach var="listBets" items="${ListBets.rows}">
                <tr>
                    <td>${listBets.Date}</td>
                    <td>${listBets.FirstTeamName}</td>
                    <td>${listBets.SecondTeamName}</td>
                    <td>
                        <c:if test="${listBets.WinnerTeam == 1}">
                            ${listBets.FirstTeamName} nyer
                        </c:if>
                        <c:if test="${listBets.WinnerTeam == 2}">
                            ${listBets.SecondTeamName} nyer
                        </c:if>
                        <c:if test="${listBets.WinnerTeam == 0}">
                            Döntetlen
                        </c:if>
                    </td>
                    <td>${listBets.BetValue}</td>
                    <td>
                        <button name="deleteId" id="deleteId" value="${listBets.ID}" type="submit">Sor törlése</button>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </form>
    <form action="Result.jsp" method="post">
        <input type="submit" value="Fogadás!" name="placeBet">
    </form>
</c:if>
</body>
</html>
