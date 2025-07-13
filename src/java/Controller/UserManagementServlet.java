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
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.SQLException;
import java.util.List;
import java.util.regex.Pattern;

/**
 *
 * @author tuanh
 */
@WebServlet(name = "UserManagementServlet", urlPatterns = {"/UserManagementServlet"})
public class UserManagementServlet extends HttpServlet {

    UserDAO u = new UserDAO();

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
            out.println("<title>Servlet UserManagementServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UserManagementServlet at " + request.getContextPath() + "</h1>");
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

        String action = request.getParameter("action");
        Integer roleId = (Integer) request.getSession().getAttribute("roleId");

        if (roleId == null || (roleId != 3 && roleId != 2)) { // Only Manager (3) and Staff (2) can manage users
            response.sendRedirect("home");
            return;
        }

        UserDAO userDAO = new UserDAO();
        String searchTerm = request.getParameter("searchTerm");
        String pageSizeParam = request.getParameter("pageSize");
        String pageParam = request.getParameter("page");

        // Mặc định giá trị cho page và pageSize
        int page = pageParam != null ? Integer.parseInt(pageParam) : 1;
        int pageSize = pageSizeParam != null ? Integer.parseInt(pageSizeParam) : 10;

        try {
            if ("search".equals(action) || action == null) {
                List<User> users = userDAO.searchUsers(searchTerm, page, pageSize);
                int totalUsers = userDAO.getTotalUsers(searchTerm);
                int totalPages = (int) Math.ceil((double) totalUsers / pageSize);

                request.setAttribute("users", users);
                request.setAttribute("currentPage", page);
                request.setAttribute("pageSize", pageSize);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("searchTerm", searchTerm);
                request.getRequestDispatcher("userManagement.jsp").forward(request, response);
            } else if ("edit".equals(action)) {
                String idParam = request.getParameter("id");
                if (idParam != null && !idParam.isEmpty()) {
                    int userId = Integer.parseInt(idParam);
                    User user = userDAO.getInfoUserByID(userId);
                    request.setAttribute("userToEdit", user);
                    List<User> users = userDAO.searchUsers(searchTerm, page, pageSize);
                    int totalUsers = userDAO.getTotalUsers(searchTerm);
                    int totalPages = (int) Math.ceil((double) totalUsers / pageSize);

                    request.setAttribute("users", users);
                    request.setAttribute("currentPage", page);
                    request.setAttribute("pageSize", pageSize);
                    request.setAttribute("totalPages", totalPages);
                    request.setAttribute("searchTerm", searchTerm);
                    request.getRequestDispatcher("userManagement.jsp").forward(request, response);
                } else {
                    response.sendRedirect("userManagement.jsp?error=invalidId");
                }
            } else if ("deactivate".equals(action)) {
                String idParam = request.getParameter("id");
                if (idParam != null && !idParam.isEmpty()) {
                    int userId = Integer.parseInt(idParam);
                    boolean deactivated = userDAO.deactivateUser(userId);
                    if (!deactivated) {
                        request.setAttribute("error", "deactivateFailed");
                    } else {
                        request.setAttribute("success", "deactivate");
                    }
                    // Lấy lại danh sách người dùng sau khi vô hiệu hóa
                    List<User> users = userDAO.searchUsers(searchTerm, page, pageSize);
                    int totalUsers = userDAO.getTotalUsers(searchTerm);
                    int totalPages = (int) Math.ceil((double) totalUsers / pageSize);

                    // Set các thuộc tính cần thiết
                    request.setAttribute("users", users);
                    request.setAttribute("currentPage", page);
                    request.setAttribute("pageSize", pageSize);
                    request.setAttribute("totalPages", totalPages);
                    request.setAttribute("searchTerm", searchTerm);

                    // Chuyển tiếp đến JSP
                    request.getRequestDispatcher("userManagement.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "invalidId");
                    // Lấy danh sách người dùng ngay cả khi lỗi
                    List<User> users = userDAO.searchUsers(searchTerm, page, pageSize);
                    int totalUsers = userDAO.getTotalUsers(searchTerm);
                    int totalPages = (int) Math.ceil((double) totalUsers / pageSize);

                    request.setAttribute("users", users);
                    request.setAttribute("currentPage", page);
                    request.setAttribute("pageSize", pageSize);
                    request.setAttribute("totalPages", totalPages);
                    request.setAttribute("searchTerm", searchTerm);
                    request.getRequestDispatcher("userManagement.jsp").forward(request, response);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserManagementServlet.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("userManagement.jsp?error=operationFailed");
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
        Integer roleId = (Integer) request.getSession().getAttribute("roleId");
        if (roleId == null || (roleId != 3 && roleId != 2)) {
            response.sendRedirect("home");
            return;
        }

        String action = request.getParameter("action");
        User user = new User();

        // Chỉ set userId nếu action là update
        if ("update".equals(action)) {
            String userIdParam = request.getParameter("userId");
            if (userIdParam != null && !userIdParam.isEmpty()) {
                user.setUserId(Integer.parseInt(userIdParam));
            } else {
                response.sendRedirect("userManagement.jsp?error=invalidId");
                return;
            }
        }

        // Lấy và validate các tham số
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String roleIdParam = request.getParameter("roleId");
        String isActiveParam = request.getParameter("isActive");

        // Validation
        if (username == null || username.trim().isEmpty() || username.length() > 50) {
            response.sendRedirect("userManagement.jsp?error=invalidUsername");
            return;
        }
        if (email == null || email.trim().isEmpty() || !isValidEmail(email) || email.length() > 100) {
            response.sendRedirect("userManagement.jsp?error=invalidEmail");
            return;
        }
        if (password == null || password.trim().isEmpty() || password.length() < 6 || password.length() > 255) {
            response.sendRedirect("userManagement.jsp?error=invalidPassword");
            return;
        }
        if (fullName == null || fullName.trim().isEmpty() || fullName.length() > 100) {
            response.sendRedirect("userManagement.jsp?error=invalidFullName");
            return;
        }
        if (phone != null && !phone.trim().isEmpty() && !isValidPhone(phone)) {
            response.sendRedirect("userManagement.jsp?error=invalidPhone");
            return;
        }
        if (roleIdParam == null || !roleIdParam.matches("2|1|4")) {
            response.sendRedirect("userManagement.jsp?error=invalidRole");
            return;
        }
        if (isActiveParam == null) {
            response.sendRedirect("userManagement.jsp?error=invalidStatus");
            return;
        }

        user.setUsername(username.trim());
        user.setEmail(email.trim());
        user.setPassword(password.trim()); // Hash password in production
        user.setFullName(fullName.trim());
        user.setPhone(phone != null ? phone.trim() : null);
        user.setAddress(address != null ? address.trim() : null);
        user.setRoleId(Integer.parseInt(roleIdParam));
        user.setIsActive(Boolean.parseBoolean(isActiveParam));

        try {
            if ("add".equals(action)) {
                if (u.emailExists(email)) {
                    response.sendRedirect("userManagement.jsp?error=emailExists");
                    return;
                }
                if (u.isUsernameExists(username)) {
                    response.sendRedirect("userManagement.jsp?error=usernameExists");
                    return;
                }
                u.addUser(user);
            } else if ("update".equals(action)) {
                u.updateUser(user);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserManagementServlet.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("userManagement.jsp?error=operationFailed");
            return;
        }
        response.sendRedirect("userManagement.jsp");
    }

    // Hàm kiểm tra định dạng email
    private boolean isValidEmail(String email) {
        String emailRegex = "^[A-Za-z0-9+_.-]+@(.+)$";
        Pattern pattern = Pattern.compile(emailRegex);
        return pattern.matcher(email).matches();
    }

    // Hàm kiểm tra định dạng số điện thoại (ví dụ: 10-11 số, bắt đầu bằng 0)
    private boolean isValidPhone(String phone) {
        String phoneRegex = "^0[0-9]{9,10}$";
        Pattern pattern = Pattern.compile(phoneRegex);
        return pattern.matcher(phone).matches();

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
