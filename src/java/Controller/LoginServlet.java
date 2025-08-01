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
@WebServlet(name="LoginServlet", urlPatterns={"/LoginServlet"})
public class LoginServlet extends HttpServlet {
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
            out.println("<title>Servlet LoginServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginServlet at " + request.getContextPath () + "</h1>");
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
        String email = request.getParameter("email");
        String password1 = request.getParameter("password");
        String password = password1.trim();
        String hasspass = Customer.hashPassword(password);
        String remember = request.getParameter("remember");

        if (email == null || password == null) {
            request.setAttribute("error", "Email hoặc mật khẩu không được để trống!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        User user = userDAO.loginUser(email, hasspass);
        if (user != null && user.isIsActive()) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("roleId", user.getRoleId());
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("area", user.getArea());
            
            // Debug: In ra thông tin session sau khi lưu
            System.out.println("=== Login Debug ===");
            System.out.println("User logged in: " + user.getUsername());
            System.out.println("User ID: " + user.getUserId());
            System.out.println("Role ID: " + user.getRoleId());
            System.out.println("Session ID: " + session.getId());
            System.out.println("Session attributes after login:");
            java.util.Enumeration<String> attributeNames = session.getAttributeNames();
            while (attributeNames.hasMoreElements()) {
                String name = attributeNames.nextElement();
                Object value = session.getAttribute(name);
                System.out.println("  " + name + ": " + value + " (type: " + (value != null ? value.getClass().getSimpleName() : "null") + ")");
            }
            System.out.println("=== End Login Debug ===");
            
            if ("ON".equals(remember)) {
                setCookie(response, "email", email, 60 * 60 * 60 * 60);
                setCookie(response, "password", password, 60 * 60 * 60 * 60);
                setCookie(response, "remember", "ON", 60 * 60 * 60 * 60);
            } else {
                deleteCookie(request, response, "email");
                deleteCookie(request, response, "password");
                deleteCookie(request, response, "remember");
            }

            // Chuyển hướng dựa trên vai trò
            switch (user.getRoleId()) {
                case 1: // Khách hàng (Customer)
                    response.sendRedirect("home");
                    break;
                case 2: // Nhân viên (Staff)
                    response.sendRedirect("productmanagement?action=view");
                    break;
                case 3: // Quản lý (Manager)
                    response.sendRedirect("statistics");
                    break;
                case 4: // Người giao hàng (Shipper)
                    response.sendRedirect("orderManagement");
                    break;
                default:
                    request.setAttribute("error", "Vai trò không hợp lệ!");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                    break;
            }
        } else {
            request.setAttribute("email", email);
            request.setAttribute("password", password);
            request.setAttribute("error", "Email hoặc mật khẩu không đúng!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    private void setCookie(HttpServletResponse response, String name, String value, int maxAge) {
        Cookie cookie = new Cookie(name, value);
        cookie.setMaxAge(maxAge);
        cookie.setPath("/");
        response.addCookie(cookie);
    }

    private void deleteCookie(HttpServletRequest request, HttpServletResponse response, String name) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (name.equals(cookie.getName())) {
                    cookie.setMaxAge(0);
                    cookie.setPath("/");
                    response.addCookie(cookie);
                    break;
                }
            }
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
