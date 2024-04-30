<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    String hostName = request.getParameter("HostName");
    // Escape special characters to prevent XSS
    if (hostName != null) {
        hostName = org.apache.commons.lang.StringEscapeUtils.escapeHtml(hostName);
    }
%>

{
    "HostName": "<c:out value="${hostName}"/>",
    "HostStatus": "OK"
}
