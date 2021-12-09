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

<sql:query var="ListMatches" dataSource="${DataSource}">
    SELECT * FROM APP."Matches"
</sql:query>

<c:if test="${param.deleteId ne null}">
    <sql:update dataSource="${DataSource}" var="InsertIntoMatches">
        DELETE FROM APP."Matches" WHERE ID = ${param.deleteId}
    </sql:update>

    <sql:query var="ListMatches" dataSource="${DataSource}">
        SELECT * FROM APP."Matches"
    </sql:query>
</c:if>

<html>
<head>
    <title>Mérkőzések</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="style.css">
    <link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon">
    <link rel="icon" href="images/favicon.ico" type="image/x-icon">
</head>
<body class="text-center fontFormat bodyBackground">
<div class="customWideContainer justify-content-center col-10 rounded-3">
    <% if (session.getAttribute("validUser") == null) { %>
        <jsp:forward page="Login.jsp">
        <jsp:param name="loginErrorMsg" value="A mérkőzések kezeléséhez jelentkezz be!"/>
        </jsp:forward>
    <% } %>

    <c:if test="${param.logout ne null}">
        <jsp:forward page="Login.jsp">
            <jsp:param name="loginErrorMsg" value="Sikeres kijelentkezés"/>
        </jsp:forward>
        <%session.invalidate();%>
    </c:if>

    <h1 class="fw-bold">Üdvözöllek <%= session.getAttribute("validUser")%>!</h1>
    <form action="CreateMatches.jsp" method="post">
        <input type="submit" value="Kijelentkezés" name="logout" class="btn btn-secondary mt-2 mb-2 p-1">
    </form>
    <br>

    <h2 class="fw-bold">Mérkőzések hozzáadása vagy törlése</h2>
    <div class="row">
    <p class="fst-italic">(Lehetőséged van focimeccsek hozzáadására vagy törlésére az ellenfelek, a győztes csapat és a meccs dátumának megadásával!)</p>
    </div>
        <form action="CheckCreateMatches.jsp" method="POST">
             <div class="row justify-content-center">
             <table class="table table-borderless w-50 table-sm mt-4 mb-4">
            <tr>
                <td class="text-end fw-bold pt-2">Hazai csapat:</td>
                <td><input type="textbox" name="home" size="20" class="rounded-2 p-2"></td>
            </tr>
            <tr>
                <td class="text-end fw-bold pt-2">Vendég csapat:</td>
                <td><input type="textbox" name="guest" size="20" class="rounded-2 p-2"></td>
            </tr>
            <tr>
                <td class="text-end fw-bold pt-4">Ki lesz a győztes csapat?</td>
                <td>
                    <label><input type="radio" name="win" value="1" class="m-1">Hazai csapat</label><br>
                    <label><input type="radio" name="win" value="2" class="m-1">Vendég csapat</label><br>
                    <label><input type="radio" name="win" value="3" class="m-1">Döntetlen</label>
                </td>
            </tr>
            <tr>
                <td class="text-end fw-bold pt-2">Mérkőzés dátuma:</td>
                <td><input type="date" name="match_date" class="rounded-2 p-2"></td>
            </tr>
             </table>
        <div class="row justify-content-center">
                     <input type="submit" name="upload" value="Hozzáadás" class="btn btn-primary w-25 p-3 text-uppercase">
        </div>
             </div>
    </form>
    <c:if test="${!empty param.matchesErrorMsg}">
        <p class="text-danger fw-bold">
            ${param.matchesErrorMsg}
        </p>
    </c:if>
<hr>
    <h2 class="fw-bold">Mérkőzések listája: </h2>
<c:choose>
    <c:when test="${!empty ListMatches.rows}">
    <form action="CreateMatches.jsp" method="post">
        <div class="row justify-content-center">
        <table class="table table-borderless table-striped w-75 mt-4 mb-4 text-center">
            <tr class="fw-bold">
                <td>Meccs dátuma</td>
                <td>Hazai csapat</td>
                <td>Vendég csapat</td>
                <td>Győztes csapat</td>
                <td>Mérkőzés törlése</td>
            </tr>
            <c:forEach var="listMatches" items="${ListMatches.rows}">
                <tr>
                    <td>${listMatches.Date}</td>
                    <td>${listMatches.FirstTeamName}</td>
                    <td>${listMatches.SecondTeamName}</td>
                    <td>
                        <c:if test="${listMatches.FirstTeamWon == true}">
                            ${listMatches.FirstTeamName}
                        </c:if>
                        <c:if test="${listMatches.SecondTeamWon == true}">
                            ${listMatches.SecondTeamName}
                        </c:if>
                        <c:if test="${listMatches.Draw == true}">
                            Döntetlen
                        </c:if>
                    </td>
                    <td><button name="deleteId" id="deleteId" value="${listMatches.ID}" type="submit" class="btn btn-danger">Törlés</button></td>
                </tr>
            </c:forEach>
        </table>
        </div>
    </form>
    </c:when>
    <c:otherwise>
        <p class="fw-bold text-center">Még nem hoztál létre egy mérkőzést sem!</p>
    </c:otherwise>
</c:choose>
</div>
</body>
</html>
