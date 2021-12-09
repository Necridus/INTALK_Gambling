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
    <title>Fogadás</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="style.css">
    <link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon">
    <link rel="icon" href="images/favicon.ico" type="image/x-icon">
</head>
<body class="text-center fontFormat bodyBackground">
<div class="customWideContainer justify-content-center col-10 rounded-3">

<%
    if (session.getAttribute("validUser") == null) { %>
        <jsp:forward page="Login.jsp">
            <jsp:param name="loginErrorMsg" value="A játék előtt jelentkezz be!"/>
        </jsp:forward>
<% }
%>

<%
        if (session.getAttribute("isAdmin") == null || session.getAttribute("isAdmin").toString().equals("true")) { %>
            <jsp:forward page="Login.jsp">
                <jsp:param name="loginErrorMsg" value="Nem megfelelő jogosultsággal próbáltál belépni!"/>
            </jsp:forward>
        <% }
%>

<c:if test="${param.logout ne null}">
    <jsp:forward page="Login.jsp">
        <jsp:param name="logoutMsg" value="Sikeres kijelentkezés"/>
    </jsp:forward>
    <%session.invalidate();%>
</c:if>

<h1 class="fw-bold">Üdvözöllek <%= session.getAttribute("validUser")%>!</h1>
<form action="PlaceBet.jsp" method="post">
    <input type="submit" value="Kijelentkezés" name="logout" class="btn btn-secondary mt-2 mb-2 p-1">
</form>

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

<c:if test="${param.firstTeamWins ne null}">
    <sql:query var="CountMatches" dataSource="${DataSource}">
        SELECT COUNT(*) as NumberOfMatches
        FROM APP."Bets"
        JOIN APP."Users" ON APP."Bets"."User_ID" = APP."Users"."ID"
        WHERE APP."Users"."ID" = ${validUser} AND APP."Bets"."Match_ID" = ${param.firstTeamWins}
    </sql:query>

    <c:forEach var="countMatches" items="${CountMatches.rows}">
        <c:set var="numberOfMatches" value="${countMatches.NumberOfMatches}"/>
    </c:forEach>

    <c:choose>
        <c:when test="${numberOfMatches > 0}">
            <h2 class="fw-bold text-danger">Ezt a meccset már hozzáadtad a szelvényedhez!</h2>
        </c:when>
        <c:otherwise>
            <sql:update dataSource="${DataSource}" var="InsertIntoBets">
                INSERT INTO APP."Bets" ("Match_ID", "User_ID", "WinnerTeam", "BetValue")
                VALUES (${param.firstTeamWins}, ${validUser}, 1, ${param.betValue})
            </sql:update>
        </c:otherwise>
    </c:choose>
</c:if>

<c:if test="${param.secondTeamWins ne null}">
    <sql:query var="CountMatches" dataSource="${DataSource}">
        SELECT COUNT(*) as NumberOfMatches
        FROM APP."Bets"
        JOIN APP."Users" ON APP."Bets"."User_ID" = APP."Users"."ID"
        WHERE APP."Users"."ID" = ${validUser} AND APP."Bets"."Match_ID" = ${param.secondTeamWins}
    </sql:query>

    <c:forEach var="countMatches" items="${CountMatches.rows}">
        <c:set var="numberOfMatches" value="${countMatches.NumberOfMatches}"/>
    </c:forEach>

    <c:choose>
        <c:when test="${numberOfMatches > 0}">
            <h2 class="fw-bold text-danger">Ezt a meccset már hozzáadtad a szelvényedhez!</h2>
        </c:when>
        <c:otherwise>
            <sql:update dataSource="${DataSource}" var="InsertIntoBets">
                INSERT INTO APP."Bets" ("Match_ID", "User_ID", "WinnerTeam", "BetValue")
                VALUES (${param.secondTeamWins}, ${validUser}, 2, ${param.betValue})
            </sql:update>
        </c:otherwise>
    </c:choose>
</c:if>

<c:if test="${param.draw ne null}">
    <sql:query var="CountMatches" dataSource="${DataSource}">
        SELECT COUNT(*) as NumberOfMatches
        FROM APP."Bets"
        JOIN APP."Users" ON APP."Bets"."User_ID" = APP."Users"."ID"
        WHERE APP."Users"."ID" = ${validUser} AND APP."Bets"."Match_ID" = ${param.draw}
    </sql:query>

    <c:forEach var="countMatches" items="${CountMatches.rows}">
        <c:set var="numberOfMatches" value="${countMatches.NumberOfMatches}"/>
    </c:forEach>

    <c:choose>
        <c:when test="${numberOfMatches > 0}">
            <h2 class="fw-bold text-danger">Ezt a meccset már hozzáadtad a szelvényedhez!</h2>
        </c:when>
        <c:otherwise>
            <sql:update dataSource="${DataSource}" var="InsertIntoBets">
                INSERT INTO APP."Bets" ("Match_ID", "User_ID", "WinnerTeam", "BetValue")
                VALUES (${param.draw}, ${validUser}, 0, ${param.betValue})
            </sql:update>
        </c:otherwise>
    </c:choose>
</c:if>

<c:if test="${param.deleteId ne null}">
    <sql:update dataSource="${DataSource}" var="DeleteFromBetsByID">
        DELETE FROM APP."Bets" WHERE ID = ${param.deleteId}
    </sql:update>
</c:if>

<c:if test="${param.newGame ne null}">
    <sql:update dataSource="${DataSource}" var="DeleteRowsFromBets">
        DELETE FROM APP."Bets" WHERE APP."Bets"."User_ID" = ${validUser}
    </sql:update>
</c:if>

    <h2 class="fw-bold">Állítsd össze a szelvényed!</h2>

<form action="PlaceBet.jsp" method="post">
    <p>Felrakni kívánt összeg: <input type="number" value="500" name="betValue" class="text-end"> Ft</p>

    <h3 class="fw-bold">Elérhető meccsek listája: </h3>
    <div class="row justify-content-center">
    <table class="table table-borderless table-striped w-75 mt-4 mb-4 text-center">
        <tr class="fw-bold">
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
                <td class="justify-content-center">
                    <button name="firstTeamWins" id="firstTeamWins" value="${listMatches.ID}" type="submit" class="btn btn-light w-25">${listMatches.FirstTeamName}</button>
                    <button name="draw" id="draw" value="${listMatches.ID}" type="submit" class="btn btn-dark w-25">Döntetlen</button>
                    <button name="secondTeamWins" id="secondTeamWins" value="${listMatches.ID}" type="submit" class="btn btn-light w-25">${listMatches.SecondTeamName}</button>
                </td>
            </tr>
        </c:forEach>
    </table>
    </div>
</form>

<c:if test="${(param.firstTeamWins ne null || param.secondTeamWins ne null || param.draw ne null) || param.deleteId ne null}">
    <sql:query var="ListBets" dataSource="${DataSource}">
        SELECT APP."Bets"."ID", APP."Bets"."Match_ID", APP."Bets"."BetValue", APP."Bets"."WinnerTeam", APP."Matches"."Date", APP."Matches"."FirstTeamName", APP."Matches"."SecondTeamName"
        FROM APP."Bets"
        JOIN APP."Matches" ON APP."Bets"."Match_ID" = APP."Matches"."ID"
        JOIN APP."Users" ON APP."Bets"."User_ID" = APP."Users"."ID"
        WHERE APP."Users"."ID" = ${validUser}
    </sql:query>
<hr>
    <h2 class="fw-bold">Szelvényed:</h2>
    <form action="PlaceBet.jsp" method="post">
        <div class="row justify-content-center">
        <table class="table table-borderless table-striped w-75 mt-4 mb-4 text-center">
            <tr class="fw-bold">
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
                        <button name="deleteId" id="deleteId" value="${listBets.ID}" type="submit" class="btn btn-danger">Törlés</button>
                    </td>
                </tr>
            </c:forEach>
        </table>
        </div>
    </form>
    <form action="Result.jsp" method="post">
        <input type="submit" value="Fogadás!" name="placeBet" class="btn btn-success text-uppercase fs-2 p-2">
    </form>
</c:if>
</div>
</body>
</html>
