/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this licenseAdd commentMore actions
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import dal.PasswordResetDAO;
import dal.UserDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Properties;
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
import java.io.PrintWriter;
import javax.mail.Authenticator;
import javax.mail.internet.MimeUtility;

/**
 *
 * @author tuanh
 */
@WebServlet(name = "ForgotPassword", urlPatterns = {"/forgot-password"})
public class ForgotPassword extends HttpServlet {

    private UserDAO userDAO;
    private PasswordResetDAO passwordResetDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
        passwordResetDAO = new PasswordResetDAO();
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ForgotPassword</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ForgotPassword at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi hệ thống. Vui lòng thử lại sau.");
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập email.");
            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
            return;
        }

        String token = passwordResetDAO.generateResetToken(email);
        if (token == null) {
            request.setAttribute("error", "Email không tồn tại hoặc lỗi hệ thống.");
            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
        } else {
            try {
                sendResetEmail(email, token);
                request.setAttribute("message", "Mã xác nhận đã được gửi đến email của bạn.");
                request.getRequestDispatcher("/verify-code.jsp?email=" + email).forward(request, response);
            } catch (MessagingException e) {
                request.setAttribute("error", "Lỗi khi gửi email: " + e.getMessage());
                request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
            }
        }
    }

    private void sendResetEmail(String email, String token) throws MessagingException {
        final String username = "thangbdhe187283@fpt.edu.vn"; // Thay bằng email của bạn
        final String password = "h h j l s c m y f v h g j j e t"; // Thay bằng mật khẩu ứng dụng

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
        message.setText("Your password reset code is: " + token + "\nThis code is valid for 5 minute.");

        Transport.send(message);
        System.out.println("Email sent successfully to " + email);

    }

    public static void sendRegistrationEmail(String toEmail, String username) {
        // 1. Cấu hình mail server
        final String fromEmail = "thangbdhe187283@fpt.edu.vn";  // email gửi đi
        final String password = "h h j l s c m y f v h g j j e t";      // dùng app password nếu là Gmail

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com"); // SMTP server
        props.put("mail.smtp.port", "587");            // TLS port
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true"); // TLS

        // 2. Tạo session
        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        try {
            // 3. Tạo email message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail, "FlowerShop", "UTF-8")); // Đặt tên người gửi
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            String subject = "Đăng ký thành công tài khoản tại Flower Shop!";
            String content = "<h2>Chào mừng bạn đến với Flower Shop 🌸</h2>"
                    + "<p>Cảm ơn bạn đã đăng ký. Hãy ghé thăm website của chúng tôi để đặt hoa nhé!</p>";

            message.setSubject(MimeUtility.encodeText(subject, "UTF-8", "B")); // tiêu đề chuẩn
            message.setContent(content, "text/html; charset=UTF-8");           // nội dung HTML

            Transport.send(message);
            System.out.println("Email sent successfully!");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
