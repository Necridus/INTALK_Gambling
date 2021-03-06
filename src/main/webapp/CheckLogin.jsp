<%--
  Created by IntelliJ IDEA.
  User: kimme
  Date: 2021. 11. 14.
  Time: 20:02
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
    <title>Title</title>
</head>
<body>

<c:if test="${!empty validUser}">
    <%
        session.removeAttribute("validUser");
    %>
</c:if>

<c:if test="${!empty validPassword }">
    <%
        session.removeAttribute("validPassword");
    %>
</c:if>

<c:choose>

    <c:when test="${!empty param.login}">

        <c:choose>

            <c:when test="${empty DataSource}">
                <h1>Az adatbázis nem elérhető!</h1>
                <a href="Login.jsp">Vissza</a>
            </c:when>

            <c:otherwise>

                <c:choose>

                    <c:when test="${!empty param.username && !empty param.password}">

                        <sql:query dataSource="${DataSource}" var="RegisteredUsers">
                            SELECT * FROM APP."Users"
                        </sql:query>

                        <%!Boolean isAdmin = false;%>
                        <c:forEach var="registeredUser" items="${RegisteredUsers.rows}">

                            <c:if test="${registeredUser.username eq param.username && registeredUser.password eq param.password}">
                                    <%
                                        session.setAttribute("validUser", request.getParameter("username"));
                                        session.setAttribute("validPassword", request.getParameter("password"));
                                        session.setAttribute("isAdmin", isAdmin);
                                    %>
                                        ${isAdmin = registeredUser.IsAdmin}
                            </c:if>

                        </c:forEach>

                        <c:choose>

                            <c:when test="${!empty validUser && !empty validPassword }">
                                 <c:choose>
                                     <c:when test="${isAdmin eq true}">
                                         <%
                                             response.sendRedirect("CreateMatches.jsp");
                                          %>
                                     </c:when>
                                     <c:otherwise>
                                         <%
                                             response.sendRedirect("PlaceBet.jsp");
                                         %>
                                     </c:otherwise>
                                 </c:choose>
                            </c:when>

                            <c:otherwise>
                                <jsp:forward page="Login.jsp">
                                    <jsp:param name="loginErrorMsg" value="Téves felhasználónév és/vagy jelszó!"/>
                                </jsp:forward>
                            </c:otherwise>

                        </c:choose>

                    </c:when>

                    <c:otherwise>
                        <jsp:forward page="Login.jsp">
                            <jsp:param name="loginErrorMsg" value="Kérem adjon meg felhasználónevet és jelszót is!"/>
                        </jsp:forward>
                    </c:otherwise>

                </c:choose>

            </c:otherwise>

        </c:choose>

    </c:when>

    <c:otherwise>
        <jsp:forward page="Login.jsp">
            <jsp:param name="loginErrorMsg" value="Kérem adjon meg felhasználónevet és jelszót is!"/>
        </jsp:forward>
    </c:otherwise>

</c:choose>
</body>
</html>
