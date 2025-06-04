<%@ page import="model.*" %>
<%
    Account auth = (Account) session.getAttribute("auth");
    if (auth != null) {
        request.setAttribute("auth", auth);
    }
%>
