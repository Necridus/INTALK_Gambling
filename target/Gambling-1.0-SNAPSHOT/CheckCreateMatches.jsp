<%--
  Created by IntelliJ IDEA.
  User: Bianka
  Date: 2021. 12. 06.
  Time: 23:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ page import="java.io.File" %>

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
<c:choose>

    <c:when test="${!empty param.upload}">

        <c:choose>

            <c:when test="${empty DataSource}">
                <h1>Az adatbázis nem elérhető!</h1>
                <a href="CreateMatches.jsp">Vissza</a>
            </c:when>

            <c:otherwise>

                <c:choose>

                    <c:when test="${!empty param.home
                     && !empty param.guest
                     && !empty param.win
                     && !empty param.match_date}">

                        <c:choose>
                            <c:when test="${empty DataSource}">
                                <h1>Az adatbázis nem elérhető!</h1>
                                <a href="CreateMatches.jsp">Vissza</a>
                            </c:when>

                            <c:otherwise>

                                <sql:update var="InsertIntoMatches" dataSource="${DataSource}">
                                    INSERT INTO APP."Matches" ("FirstTeamName", "SecondTeamName", "FirstTeamWon", "SecondTeamWon", "Draw", "Date")
                                    VALUES ('${param.home}', '${param.guest}', ${(param.win=="1"? "true" : "false")}, ${(param.win=="2"? "true" : "false")}, ${(param.win=="3"? "true" : "false")}, '${param.match_date}')
                                </sql:update>

                            </c:otherwise>

                        </c:choose>

                    </c:when>

                    <c:otherwise>
                        <jsp:forward page="CreateMatches.jsp">
                            <jsp:param name="matchesErrorMsg" value="Kérem adjon meg minden szükséges információt!"/>
                        </jsp:forward>
                    </c:otherwise>

                </c:choose>

            </c:otherwise>

        </c:choose>

    </c:when>

    <c:otherwise>
        <jsp:forward page="CreateMatches.jsp">
            <jsp:param name="matchesErrorMsg" value="Kérem adjon meg minden szükséges információt!"/>
        </jsp:forward>
    </c:otherwise>

</c:choose>

</body>
</html>
