<%--
  Created by IntelliJ IDEA.
  User: kimme
  Date: 2021. 11. 14.
  Time: 20:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<c:choose>
    <c:when test="${!empty param.register}">
        <c:choose>
            <c:when test="${!empty param.username && !empty param.password}">
                <c:choose>
                    <c:when test="${1 eq 1}">
                        <%session.setAttribute("validUser",request.getParameter("username"));%>
                        <%session.setAttribute("validpassword",request.getParameter("password"));%>
                        Sikeres regisztráció!
                    </c:when>
                    <c:otherwise>
                        <jsp:forward page="Register.jsp">
                            <jsp:param name="registerErrorMsg" value="Már létező felhasználónév!"/>
                        </jsp:forward>
                    </c:otherwise>
                </c:choose>
            </c:when>
            <c:otherwise>
                <jsp:forward page="Register.jsp">
                    <jsp:param name="registerErrorMsg" value="Kérem adjon meg felhasználónevet és jelszót is!"/>
                </jsp:forward>
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
