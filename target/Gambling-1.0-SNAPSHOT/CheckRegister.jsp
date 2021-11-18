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

<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
%>

<sql:setDataSource
        var="DataSource"
        driver="org.apache.derby.jdbc.EmbeddedDriver"
        scope="application"
        url="jdbc:derby:Gambling_DataSource_Embedded"
/>

<html>
<head>
    <title>Title</title>
</head>
<body>
<c:choose>

    <c:when test="${!empty param.register}">

        <c:choose>
            <c:when test="${empty DataSource}">
                <h1>Az adatbázis nem elérhető!</h1>
                <a href="Register.jsp">Vissza</a>
            </c:when>

            <c:otherwise>

                <c:choose>

                    <c:when test="${!empty param.username && !empty param.password}">

                        <c:choose>

                            <c:when test="${empty DataSource}">
                                <h1>Az adatbázis nem elérhető!</h1>
                                <a href="Register.jsp">Vissza</a>
                            </c:when>

                            <c:otherwise>
                                <sql:query dataSource="${DataSource}" var="RegisteredUsers">
                                    SELECT * FROM APP."Users"
                                </sql:query>

                                <c:choose>
                                    <c:when test="${RegisteredUsers.rowCount eq 0}">

                                        <sql:update dataSource="${DataSource}" var="InsertIntoUser">
                                            INSERT INTO APP."Users" ("Name", "Username", "Password", "IsAdmin")
                                            VALUES ('${param.name}', '${param.username}', '${param.password}', false)
                                        </sql:update>

                                        <h1>Sikeres regisztráció!</h1>
                                        <a href="Login.jsp">Tovább a bejelentkezéshez!</a>

                                    </c:when>

                                    <c:otherwise>
                                        <%
                                            boolean isUserNameTaken = false;
                                        %>

                                        <c:forEach var="registeredUser" items="${RegisteredUsers.rows}">
                                            <c:if test="${registeredUser.username eq param.username}">
                                            <%
                                                isUserNameTaken = true;
                                            %>
                                            <%--TODO break?!--%>
                                            </c:if>
                                        </c:forEach>

                                        <%
                                            session.setAttribute("isUserNameTaken",isUserNameTaken);
                                        %>

                                        <c:choose>

                                            <c:when test="${isUserNameTaken eq 'true'}">
                                                <jsp:forward page="Register.jsp">
                                                    <jsp:param name="registerErrorMsg" value="Már létező felhasználónév!"/>
                                                </jsp:forward>
                                            </c:when>

                                            <c:otherwise>

                                                <sql:update dataSource="${DataSource}" var="InsertIntoUser">
                                                    INSERT INTO APP."Users" ("Name", "Username", "Password", "IsAdmin")
                                                    VALUES ('${param.name}', '${param.username}', '${param.password}', false)
                                                </sql:update>

                                                <h1>Sikeres regisztráció!</h1>
                                                <a href="Login.jsp">Tovább a bejelentkezéshez!</a>
                                            </c:otherwise>

                                        </c:choose>

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

            </c:otherwise>

        </c:choose>

    </c:when>

    <c:otherwise>
        <jsp:forward page="Register.jsp">
            <jsp:param name="registerErrorMsg" value="Kérem adjon meg felhasználónevet és jelszót is!"/>
        </jsp:forward>
    </c:otherwise>

</c:choose>
</body>
</html>
