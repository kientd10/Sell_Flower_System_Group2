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
import java.sql.SQLException;
import java.util.List;
import java.util.regex.Pattern;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "UserManagementServlet", urlPatterns = {"/UserManagementServlet"})
public class UserManagementServlet extends HttpServlet {

    UserDAO u = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        Integer roleId = (Integer) request.getSession().getAttribute("roleId");

        if (roleId == null || (roleId != 3 && roleId != 2)) {
            response.sendRedirect("home");
            return;
        }

        String searchTerm = request.getParameter("searchTerm");
        String pageSizeParam = request.getParameter("pageSize");
        String pageParam = request.getParameter("page");

        int page = pageParam != null ? Integer.parseInt(pageParam) : 1;
        int pageSize = pageSizeParam != null ? Integer.parseInt(pageSizeParam) : 10;
        String roleFilterParam = request.getParameter("roleFilter");
        Integer roleFilter = (roleFilterParam != null && !roleFilterParam.isEmpty())
                ? Integer.parseInt(roleFilterParam) : null;
        try {
            if ("edit".equals(action)) {
                String idParam = request.getParameter("id");
                if (idParam != null && !idParam.isEmpty()) {
                    int userId = Integer.parseInt(idParam);
                    User user = u.getInfoUserByID(userId);
                    request.setAttribute("userToEdit", user);
                } else {
                    request.setAttribute("error", "invalidId");
                }
            } else if ("deactivate".equals(action)) {
                String idParam = request.getParameter("id");
                if (idParam != null && !idParam.isEmpty()) {
                    int userId = Integer.parseInt(idParam);
                    boolean deactivated = u.deactivateUser(userId);
                    if (!deactivated) {
                        request.setAttribute("error", "deactivateFailed");
                    } else {
                        request.setAttribute("success", "deactivate");
                    }
                } else {
                    request.setAttribute("error", "invalidId");
                }
            }

            List<User> users = u.searchUsers(searchTerm, roleFilter, page, pageSize);
            int totalUsers = u.getTotalUsers(searchTerm, roleFilter);

            int totalPages = (int) Math.ceil((double) totalUsers / pageSize);

            request.setAttribute("users", users);
            request.setAttribute("currentPage", page);
            request.setAttribute("pageSize", pageSize);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("searchTerm", searchTerm);
            request.setAttribute("roleFilter", roleFilter);
            request.getRequestDispatcher("userManagement.jsp").forward(request, response);

        } catch (SQLException ex) {
            Logger.getLogger(UserManagementServlet.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("UserManagementServlet?action=search&error=operationFailed");
        }
    }

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

        if ("update".equals(action)) {
            String userIdParam = request.getParameter("userId");
            if (userIdParam != null && !userIdParam.isEmpty()) {
                user.setUserId(Integer.parseInt(userIdParam));
            } else {
                response.sendRedirect("UserManagementServlet?action=search&error=invalidId");
                return;
            }
        }

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String roleIdParam = request.getParameter("roleId");
        String area = request.getParameter("area");

        String isActiveParam = request.getParameter("isActive");

        // === VALIDATION CHUNG ===
        if (username == null || username.trim().isEmpty() || username.length() > 50) {
            response.sendRedirect("UserManagementServlet?action=search&error=invalidUsername");
            return;
        }
        if (email == null || email.trim().isEmpty() || !isValidEmail(email) || email.length() > 100) {
            response.sendRedirect("UserManagementServlet?action=search&error=invalidEmail");
            return;
        }
        if (phone != null && !phone.trim().isEmpty() && !isValidPhone(phone)) {
            response.sendRedirect("UserManagementServlet?action=search&error=invalidPhone");
            return;
        }
        if (isActiveParam == null) {
            response.sendRedirect("UserManagementServlet?action=search&error=invalidStatus");
            return;
        }

        try {
            if ("add".equals(action)) {
                // Validate password
                if (password == null || password.trim().isEmpty() || password.length() < 6 || password.length() > 255) {
                    response.sendRedirect("UserManagementServlet?action=search&error=invalidPassword");
                    return;
                }
                // Validate role
                if (roleIdParam == null || !roleIdParam.matches("2|1|4")) {
                    response.sendRedirect("UserManagementServlet?action=search&error=invalidRole");
                    return;
                }
                // Validate fullName
                if (fullName == null || fullName.trim().isEmpty() || fullName.length() > 100) {
                    response.sendRedirect("UserManagementServlet?action=search&error=invalidFullName");
                    return;
                }

                if (u.emailExists(email)) {
                    response.sendRedirect("UserManagementServlet?action=search&error=emailExists");
                    return;
                }
                if (u.isUsernameExists(username)) {
                    response.sendRedirect("UserManagementServlet?action=search&error=usernameExists");
                    return;
                }

                user.setUsername(username.trim());
                user.setEmail(email.trim());
                user.setPassword(password.trim());
                user.setFullName(fullName.trim());
                user.setPhone(phone != null ? phone.trim() : null);
                user.setAddress(address != null ? address.trim() : null);
                user.setArea(area != null ? area.trim() : null);
                user.setRoleId(Integer.parseInt(roleIdParam));              
                user.setIsActive(Boolean.parseBoolean(isActiveParam));

                u.addUser(user);
                response.sendRedirect("UserManagementServlet?action=search&success=add");

            } else if ("update".equals(action)) {
                // Lấy dữ liệu cũ
                User oldUser = u.getInfoUserByID(user.getUserId());
                if (oldUser == null) {
                    response.sendRedirect("UserManagementServlet?action=search&error=invalidId");
                    return;
                }

                user.setUsername(username.trim());
                user.setEmail(email.trim());
                user.setPassword(oldUser.getPassword());
                user.setRoleId(oldUser.getRoleId());
                user.setPhone(phone != null ? phone.trim() : null);
                user.setAddress(address != null ? address.trim() : null);
                user.setArea(area != null ? area.trim() : null);
                user.setIsActive(Boolean.parseBoolean(isActiveParam));

                // Giữ lại tên cũ nếu người dùng không nhập gì
                if (fullName != null && !fullName.trim().isEmpty()) {
                    user.setFullName(fullName.trim());
                } else {
                    user.setFullName(oldUser.getFullName());
                }

                u.updateUser(user);
                response.sendRedirect("UserManagementServlet?action=search&success=update");
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserManagementServlet.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("UserManagementServlet?action=search&error=operationFailed");
        }
    }

    private boolean isValidEmail(String email) {
        String emailRegex = "^[A-Za-z0-9+_.-]+@(.+)$";
        return Pattern.compile(emailRegex).matcher(email).matches();
    }

    private boolean isValidPhone(String phone) {
        String phoneRegex = "^0[0-9]{9,10}$";
        return Pattern.compile(phoneRegex).matcher(phone).matches();
    }

    @Override
    public String getServletInfo() {
        return "User management servlet";
    }
}
