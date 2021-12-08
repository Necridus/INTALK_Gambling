<%--
  Created by IntelliJ IDEA.
  User: kimme
  Date: 2021. 11. 14.
  Time: 20:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ page import="java.io.File" %>

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
    <title>Regisztráció</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="style.css">
</head>
<body class="text-center fontFormat bodyBackground">
<div class="customContainer justify-content-center col-5 rounded-3">
<c:choose>

    <c:when test="${!empty param.register}">

        <c:choose>
            <c:when test="${empty DataSource}">
                <h1>Az adatbázis nem elérhető!</h1>
                <a href="Register.jsp">Vissza</a>
            </c:when>

            <c:otherwise>

                <c:choose>

                    <c:when test="${!empty param.email && !empty param.username && !empty param.password && !empty param.confirmpassword}">

                        <c:choose>

                            <c:when test="${param.username.length()>= 5
                             && param.password.length() >= 5
                             && param.username ne param.username.toLowerCase()
                             && param.username ne param.username.toUpperCase()}">

                                <c:choose>

                                    <c:when test="${param.password eq param.confirmpassword}">
                                                <sql:query dataSource="${DataSource}" var="RegisteredUsers">
                                                    SELECT * FROM APP."Users"
                                                </sql:query>

                                                <c:choose>
                                                    <c:when test="${RegisteredUsers.rowCount eq 0}">

                                                        <sql:update dataSource="${DataSource}" var="InsertIntoUser">
                                                            INSERT INTO APP."Users" ("Email", "Username", "Password", "IsAdmin")
                                                            VALUES ('${param.email}', '${param.username}', '${param.password}', false)
                                                        </sql:update>

                                                        <h1>Sikeres regisztráció!</h1>
                                                        <a href="Login.jsp">Tovább a bejelentkezéshez!</a>

                                                    </c:when>

                                                    <c:otherwise>
                                                        <%
                                                            boolean isUserNameTaken = false;
                                                            boolean isEmailTaken = false;
                                                        %>

                                                        <c:forEach var="registeredUser" items="${RegisteredUsers.rows}">
                                                            <c:if test="${registeredUser.username eq param.username}">
                                                                <%
                                                                    isUserNameTaken = true;
                                                                %>
                                                            </c:if>
                                                            <c:if test="${registeredUser.email eq param.email}">
                                                                <%
                                                                    isEmailTaken = true;
                                                                %>
                                                            </c:if>
                                                        </c:forEach>

                                                        <%
                                                            session.setAttribute("isUserNameTaken",isUserNameTaken);
                                                            session.setAttribute("isEmailTaken",isEmailTaken);
                                                        %>

                                                        <c:choose>

                                                            <c:when test="${isUserNameTaken eq 'true'}">
                                                                <jsp:forward page="Register.jsp">
                                                                    <jsp:param name="registerErrorMsg" value="Már létező felhasználónév!"/>
                                                                </jsp:forward>
                                                            </c:when>

                                                            <c:when test="${isEmailTaken eq 'true'}">
                                                                <jsp:forward page="Register.jsp">
                                                                    <jsp:param name="registerErrorMsg" value="Már regisztrálc E-Mail cím!"/>
                                                                </jsp:forward>
                                                            </c:when>

                                                            <c:otherwise>

                                                                <sql:update dataSource="${DataSource}" var="InsertIntoUser">
                                                                    INSERT INTO APP."Users" ("Email", "Username", "Password", "IsAdmin")
                                                                    VALUES ('${param.email}', '${param.username}', '${param.password}', false)
                                                                </sql:update>

                                                                <h1>Sikeres regisztráció!</h1>
                                                                <a href="Login.jsp">Tovább a bejelentkezéshez!</a>
                                                            </c:otherwise>

                                                        </c:choose>

                                                    </c:otherwise>

                                                </c:choose>
                                    </c:when>

                                <c:otherwise>
                                    <jsp:forward page="Register.jsp">
                                        <jsp:param name="registerErrorMsg" value="A jelszó és annak megerősítése nem egyezik!"/>
                                    </jsp:forward>
                                </c:otherwise>
                                </c:choose>
                            </c:when>
                            <c:otherwise>
                                <jsp:forward page="Register.jsp">
                                    <jsp:param name="registerErrorMsg" value="A felhasználónév és a jelszó legalább 5 karakter hosszúak legyenek, továbbá a felhasználónév tartalmazzon legalább egy kis- és nagybetűt!"/>
                                </jsp:forward>
                            </c:otherwise>
                        </c:choose>
                    </c:when>

                    <c:otherwise>
                        <jsp:forward page="Register.jsp">
                            <jsp:param name="registerErrorMsg" value="Kérem adjon meg minden adatot!"/>
                        </jsp:forward>
                    </c:otherwise>

                </c:choose>

            </c:otherwise>

        </c:choose>

    </c:when>

    <c:otherwise>
        <jsp:forward page="Register.jsp">
            <jsp:param name="registerErrorMsg" value="Kérem adjon meg felhasználónevet és jelszót is!"/>
        </jsp:forward>
    </c:otherwise>

</c:choose>
</div>
</body>
</html>
