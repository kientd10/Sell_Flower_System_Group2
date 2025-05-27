/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import Model.User;
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author tuanh
 */
@WebServlet(name="Customer", urlPatterns={"/Customer"})
public class Customer extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet Customer</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Customer at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
       String action = request.getParameter("action");

        if ("signin".equals(action)) {
            handleSignIn(request, response);
        } else if ("signup".equals(action)) {
            handleSignUp(request, response);
        } else {
            response.sendRedirect("login.jsp");
        }
    }

    private void handleSignIn(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String remember = request.getParameter("remember");

        User user = userDAO.loginUser(email, password);
        if (user != null && user.isIsActive()) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // Xử lý cookie cho "Remember me"
            if ("ON".equals(remember)) {
                Cookie emailCookie = new Cookie("email", email);
                Cookie passwordCookie = new Cookie("password", password);
                Cookie rememberCookie = new Cookie("remember", "ON");
                emailCookie.setMaxAge(7 * 24 * 60 * 60); // 7 ngày
                passwordCookie.setMaxAge(7 * 24 * 60 * 60);
                rememberCookie.setMaxAge(7 * 24 * 60 * 60);
                response.addCookie(emailCookie);
                response.addCookie(passwordCookie);
                response.addCookie(rememberCookie);
            } else {
                // Xóa cookie nếu không chọn "Remember me"
                Cookie emailCookie = new Cookie("email", "");
                Cookie passwordCookie = new Cookie("password", "");
                Cookie rememberCookie = new Cookie("remember", "");
                emailCookie.setMaxAge(0);
                passwordCookie.setMaxAge(0);
                rememberCookie.setMaxAge(0);
                response.addCookie(emailCookie);
                response.addCookie(passwordCookie);
                response.addCookie(rememberCookie);
            }

            response.sendRedirect("index.jsp"); // Chuyển hướng tới trang chủ
        } else {
            request.setAttribute("error", "Email hoặc mật khẩu không đúng, hoặc tài khoản bị khóa!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    private void handleSignUp(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("name");
        String email = request.getParameter("Email");
        String password = request.getParameter("Password");
        String cfPassword = request.getParameter("CfPassword");
        String fullName = request.getParameter("fullname");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        // Kiểm tra dữ liệu đầu vào
        if (!password.equals(cfPassword)) {
            request.setAttribute("errorpass", "Mật khẩu xác nhận không khớp!");
            request.setAttribute("username", username);
            request.setAttribute("email", email);
            request.setAttribute("fullname", fullName);
            request.setAttribute("phone", phone);
            request.setAttribute("address", address);
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        if (userDAO.isUsernameExists(username)) {
            request.setAttribute("errorname", "Tên người dùng đã tồn tại!");
            request.setAttribute("email", email);
            request.setAttribute("fullname", fullName);
            request.setAttribute("phone", phone);
            request.setAttribute("address", address);
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        if (userDAO.emailExists(email)) {
            request.setAttribute("emailavailable", "Email đã được sử dụng!");
            request.setAttribute("username", username);
            request.setAttribute("fullname", fullName);
            request.setAttribute("phone", phone);
            request.setAttribute("address", address);
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Tạo người dùng mới
        User user = new User();
        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(password);
        user.setFullName(fullName);
        user.setPhone(phone);
        user.setAddress(address);
        user.setRoleId(1); // Gán vai trò Customer (role_id = 1)
        user.setIsActive(true);

        if (userDAO.registerUser(user)) {
            request.setAttribute("done", "Đăng ký thành công! Vui lòng đăng nhập.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Đăng ký thất bại! Vui lòng thử lại.");
            request.setAttribute("username", username);
            request.setAttribute("email", email);
            request.setAttribute("fullname", fullName);
            request.setAttribute("phone", phone);
            request.setAttribute("address", address);
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
