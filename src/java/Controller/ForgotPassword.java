/*
 * Password Reset Servlet for handling forgot password functionality
 */
package Controller;

import dal.PasswordResetDAO;
import dal.UserDAO;
import java.io.IOException;
import java.util.Properties;
import java.util.UUID;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import javax.mail.Authenticator;

/**
 * Servlet handling password reset requests GET: Displays forgot password form
 * POST: Processes email input and sends reset code
 */
@WebServlet(name = "ForgotPassword", urlPatterns = {"/forgot-password"})
public class ForgotPassword extends HttpServlet {

    private UserDAO userDAO;
    private PasswordResetDAO passwordResetDAO;
    private static final String EMAIL_REGEX = "^[A-Za-z0-9+_.-]+@(.+)$";

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
        passwordResetDAO = new PasswordResetDAO();
    }

    /**
     * Handles GET requests by forwarding to forgot-password.jsp
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
        } catch (Exception e) {
            log("Error in doGet: ", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "System error occurred. Please try again later.");
        }
    }

    /**
     * Handles POST requests for password reset Validates email, generates
     * token, and sends reset email
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");

        // Input validation
        if (email == null || email.trim().isEmpty()) {
            setErrorAndForward(request, response, "Please enter an email address.",
                    "/forgot-password.jsp");
            return;
        }

        // Email format validation
        if (!email.matches(EMAIL_REGEX)) {
            setErrorAndForward(request, response, "Invalid email format.",
                    "/forgot-password.jsp");
            return;
        }

        try {
            // Check if email exists in database
            if (!userDAO.emailExists(email)) {
                setErrorAndForward(request, response,
                        "Email not found in our system.",
                        "/forgot-password.jsp");
                return;
            }
            String token = passwordResetDAO.generateResetToken(email);
            if (token == null) {
                setErrorAndForward(request, response,
                        "Error generating reset token.",
                        "/forgot-password.jsp");
                return;
            }

            sendResetEmail(email, token);
            request.setAttribute("message",
                    "A password reset code has been sent to your email.");
            request.getRequestDispatcher("/verify-code.jsp?email=" + email)
                    .forward(request, response);

        } catch (MessagingException e) {
            log("Error sending email: ", e);
            setErrorAndForward(request, response,
                    "Error sending email: " + e.getMessage(),
                    "/forgot-password.jsp");
        } catch (Exception e) {
            log("Unexpected error: ", e);
            setErrorAndForward(request, response,
                    "System error occurred. Please try again later.",
                    "/forgot-password.jsp");
        }
    }

    /**
     * Sends password reset email with reset code
     *
     * @param email Recipient's email address
     * @param token Reset token
     * @throws MessagingException if email sending fails
     */
    private void sendResetEmail(String email, String token) throws MessagingException {
        final String username = "tutche180023@fpt.edu.vn"; // Replace with your email
        final String password = "nbrt tycv cskk dbfg"; // Replace with your app password

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(username));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
        message.setSubject("Flower Shop - Password Reset Code");

        // Construct reset link
        String resetLink = "http://yourdomain.com/reset-password?token=" + token;
        String emailContent = "<h2>Password Reset Request</h2>"
                + "<p>You have requested to reset your password for Flower Shop.</p>"
                + "<p>Your verification code is: <strong>" + token + "</strong></p>";

        message.setContent(emailContent, "text/html; charset=utf-8");

        Transport.send(message);
    }

    /**
     * Helper method to set error message and forward to JSP
     */
    private void setErrorAndForward(HttpServletRequest request,
            HttpServletResponse response,
            String errorMessage,
            String forwardPath)
            throws ServletException, IOException {
        request.setAttribute("error", errorMessage);
        request.getRequestDispatcher(forwardPath).forward(request, response);
    }

    /**
     * Processes requests for both HTTP GET and POST methods - not used
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
    }
}
