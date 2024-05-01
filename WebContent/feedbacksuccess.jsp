<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.ibm.security.appscan.altoromutual.model.Feedback" %>
<%@ page import="com.ibm.security.appscan.altoromutual.util.ServletUtil" errorPage="notfound.jsp"%>
<%@ page import="org.apache.commons.lang.StringEscapeUtils" %>

<jsp:include page="header.jspf"/>

<div id="wrapper" style="width: 99%;">
    <jsp:include page="toc.jspf"/>
    <td valign="top" colspan="3" class="bb">
        <div class="fl" style="width: 99%;">
            <h1>Thank You</h1>
            <p>Thank you for your comments<%= (request.getAttribute("message_feedback")!=null)?", "+StringEscapeUtils.escapeHtml((String)request.getAttribute("message_feedback")):"" %>. They will be reviewed by our Customer Service staff and given the full attention that they deserve.</p>
            <% 
                String email = request.getParameter("email_addr"); 
                if (email != null && !email.trim().isEmpty() && email.matches(ServletUtil.EMAIL_REGEXP)) { 
            %>
                <p>Our reply will be sent to your email: <%= ServletUtil.sanitizeHtmlWithRegex(StringEscapeUtils.escapeHtml(email.toLowerCase())) %></p>
            <% 
                } else { 
            %>
                <p>However, the email you provided is incorrect (<%= ServletUtil.sanitizeHtmlWithRegex(StringEscapeUtils.escapeHtml(email.toLowerCase())) %>) and you will not receive a response.</p>
            <% 
                } 
            %>
            
            <% if (ServletUtil.isAppPropertyTrue("enableFeedbackRetention")) { %>
                <br><br>
                <h3>Details of your feedback submission</h3>
                <% 
                    long feedbackId = -1;
                    Object feedbackIdObj = request.getAttribute("feedback_id");
                    if (feedbackIdObj instanceof String) {
                        try {
                            feedbackId = Long.parseLong((String)feedbackIdObj);
                        } catch (NumberFormatException e) {
                            // Log or handle the exception
                        }
                    }
                    
                    Feedback feedbackDetails = ServletUtil.getFeedback(feedbackId);
                    
                    if (feedbackDetails != null) {
                %>
                    <table border="0">
                        <tr>
                            <td align="right">Your Name:</td>
                            <td valign="top"><%= StringEscapeUtils.escapeHtml(feedbackDetails.getName()) %></td>
                        </tr>
                        <tr>
                            <td align="right">Your Email Address:</td>
                            <td valign="top"><%= StringEscapeUtils.escapeHtml(feedbackDetails.getEmail()) %></td>
                        </tr>
                        <tr>
                            <td align="right">Subject:</td>
                            <td valign="top"><%= StringEscapeUtils.escapeHtml(feedbackDetails.getSubject()) %></td>
                        </tr>
                        <tr>
                            <td align="right" valign="top">Question/Comment:</td>
                            <td><%= StringEscapeUtils.escapeHtml(feedbackDetails.getMessage()) %></td>
                        </tr>
                    </table>
                <% } %>
            <% } %>
        </div>
    </td>   
</div>

<jsp:include page="footer.jspf"/>
