/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import dal.PasswordResetDAO;
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;

/**
 *
 * @author tuanh
 */
@WebServlet(name = "ResetPassword", urlPatterns = {"/reset-password"})
public class ResetPassword extends HttpServlet {

    private PasswordResetDAO passwordResetDAO;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        passwordResetDAO = new PasswordResetDAO();
        userDAO = new UserDAO();
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
            out.println("<title>Servlet ResetPassword</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ResetPassword at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

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
            request.getRequestDispatcher("/reset-password.jsp").forward(request, response);
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
        String code = request.getParameter("code");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        try {
            // Kiểm tra nếu đây là yêu cầu xác nhận mã (từ verify-code.jsp)
            if (password == null && confirmPassword == null) {
                if (code == null || code.trim().isEmpty() || email == null || email.trim().isEmpty()) {
                    request.setAttribute("error", "Dữ liệu không hợp lệ. Vui lòng nhập mã và email.");
                    request.getRequestDispatcher("/verify-code.jsp?email=" + (email != null ? email : "")).forward(request, response);
                    return;
                }

                // Validate code
                String validEmail = passwordResetDAO.validateResetToken(code.trim());
                if (validEmail == null || !validEmail.equals(email.trim())) {
                    request.setAttribute("error", "Mã xác nhận không hợp lệ hoặc email không khớp.");
                    request.getRequestDispatcher("/verify-code.jsp?email=" + email).forward(request, response);
                    return;
                }

                // Mã hợp lệ, chuyển sang reset-password.jsp
                request.setAttribute("email", email);
                request.setAttribute("code", code);
                request.getRequestDispatcher("/reset-password.jsp").forward(request, response);
                return;
            }

            // Kiểm tra nếu đây là yêu cầu đặt lại mật khẩu (từ reset-password.jsp)
            if (password != null && confirmPassword != null) {
                if (code == null || code.trim().isEmpty() || email == null || email.trim().isEmpty()) {
                    request.setAttribute("error", "Dữ liệu không hợp lệ. Vui lòng thử lại.");
                    request.getRequestDispatcher("/reset-password.jsp").forward(request, response);
                    return;
                }

                // Validate code again for security
                String validEmail = passwordResetDAO.validateResetToken(code.trim());
                if (validEmail == null || !validEmail.equals(email.trim())) {
                    request.setAttribute("error", "Mã xác nhận không hợp lệ hoặc đã hết hạn.");
                    request.getRequestDispatcher("/verify-code.jsp?email=" + email).forward(request, response);
                    return;
                }

                // Validate passwords
                if (!password.equals(confirmPassword)) {
                    request.setAttribute("error", "Mật khẩu không khớp.");
                    request.getRequestDispatcher("/reset-password.jsp").forward(request, response);
                    return;
                }

                // Kiểm tra mật khẩu mới có trùng với mật khẩu cũ không
                String oldPassword = userDAO.getPassword(email);
                String password_hash = Customer.hashPassword(password);
                if (oldPassword != null && password_hash.equals(oldPassword)) {
                    request.setAttribute("error", "Mật khẩu mới không được trùng với mật khẩu cũ.");
                    request.getRequestDispatcher("/reset-password.jsp").forward(request, response);
                    return;
                }

                // Update password
                boolean success = userDAO.updatePassword(email, password_hash);
                if (success) {
                    if (passwordResetDAO.deleteToken(code)) {
                        request.setAttribute("email", email);
                        request.setAttribute("password", password);
                        request.setAttribute("done", "Đổi mặt khẩu thành công");
                        request.setAttribute("message", "Đặt lại mật khẩu thành công. Vui lòng đăng nhập.");
                        request.getRequestDispatcher("/login.jsp").forward(request, response);
                    } else {
                        request.setAttribute("error", "Lỗi khi xóa mã xác nhận. Vui lòng thử lại.");
                        request.getRequestDispatcher("/reset-password.jsp").forward(request, response);
                    }
                } else {
                    request.setAttribute("error", "Không thể đặt lại mật khẩu. Vui lòng thử lại.");
                    request.getRequestDispatcher("/reset-password.jsp").forward(request, response);
                }
                return;
            }

            // Trường hợp không xác định
            request.setAttribute("error", "Yêu cầu không hợp lệ. Vui lòng thử lại.");
            request.getRequestDispatcher("/verify-code.jsp?email=" + (email != null ? email : "")).forward(request, response);

        } catch (SQLException e) {
            System.err.println("Lỗi SQL: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Lỗi cơ sở dữ liệu: " + e.getMessage());
            request.getRequestDispatcher("/verify-code.jsp?email=" + (email != null ? email : "")).forward(request, response);
        } catch (Exception e) {
            System.err.println("Lỗi hệ thống: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống. Vui lòng thử lại sau.");
            request.getRequestDispatcher("/verify-code.jsp?email=" + (email != null ? email : "")).forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description reset password";
    }
}
