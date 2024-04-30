/**
This application is for demonstration use only. It contains known application security
vulnerabilities that were created expressly for demonstrating the functionality of
application security testing tools. These vulnerabilities may present risks to the
technical environment in which the application is installed. You must delete and
uninstall this demonstration application upon completion of the demonstration for
which it is intended. 

IBM DISCLAIMS ALL LIABILITY OF ANY KIND RESULTING FROM YOUR USE OF THE APPLICATION
OR YOUR FAILURE TO DELETE THE APPLICATION FROM YOUR ENVIRONMENT UPON COMPLETION OF
A DEMONSTRATION. IT IS YOUR RESPONSIBILITY TO DETERMINE IF THE PROGRAM IS APPROPRIATE
OR SAFE FOR YOUR TECHNICAL ENVIRONMENT. NEVER INSTALL THE APPLICATION IN A PRODUCTION
ENVIRONMENT. YOU ACKNOWLEDGE AND ACCEPT ALL RISKS ASSOCIATED WITH THE USE OF THE APPLICATION.

IBM AltoroJ
(c) Copyright IBM Corp. 2008, 2013 All Rights Reserved.
 */
package com.ibm.security.appscan.altoromutual.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ibm.security.appscan.altoromutual.util.ServletUtil;

/**
 * Administrator login servlet
 * @author Alexei
 */
public class AdminLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String password = request.getParameter("password");
        if (password == null || password.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/login.jsp");
            return;
        }

        if (!isPasswordCorrect(password)) {
            request.setAttribute("loginError", "Invalid password.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/login.jsp");
            try {
                dispatcher.forward(request, response);
            } catch (ServletException | IOException e) {
                // Handle exception if forward fails
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/admin/login.jsp");
            }
        } else {
            try {
                request.getSession(true).setAttribute(ServletUtil.SESSION_ATTR_ADMIN_KEY, ServletUtil.SESSION_ATTR_ADMIN_VALUE);
                response.sendRedirect(request.getContextPath() + "/admin/admin.jsp");
            } catch (IOException e) {
                // Handle exception if redirect fails
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/admin/login.jsp");
            }
        }
    }

    // Method to securely compare passwords
    private boolean isPasswordCorrect(String inputPassword) {
        String storedPasswordHash = "7c222fb2927d828af22f592134e8932480637c0d"; // Hash of "Altoro1234" using SHA-1
        
        try {
            // Hash the input password using SHA-1
            MessageDigest md = MessageDigest.getInstance("SHA-1");
            byte[] inputPasswordHash = md.digest(inputPassword.getBytes());

            // Compare the hashed passwords securely
            return MessageDigest.isEqual(inputPasswordHash, hexStringToByteArray(storedPasswordHash));
        } catch (NoSuchAlgorithmException e) {
            // Handle hashing algorithm not found exception
            e.printStackTrace();
            return false;
        }
    }

    // Utility method to convert a hexadecimal string to a byte array
    private byte[] hexStringToByteArray(String hexString) {
        int len = hexString.length();
        byte[] data = new byte[len / 2];
        for (int i = 0; i < len; i += 2) {
            data[i / 2] = (byte) ((Character.digit(hexString.charAt(i), 16) << 4)
                                 + Character.digit(hexString.charAt(i+1), 16));
        }
        return data;
    }
}
