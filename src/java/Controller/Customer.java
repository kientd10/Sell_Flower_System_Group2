package Controller;

import Model.User;
import dal.UserDAO;
import dal.CategoryDAO;
import dal.BouquetDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import Model.Category;
import Model.BouquetTemplate;

@WebServlet(name = "Customer", urlPatterns = {"/Customer"})
public class Customer extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("logout".equals(action)) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if ("email".equals(cookie.getName())
                            || "password".equals(cookie.getName())
                            || "remember".equals(cookie.getName())) {
                        cookie.setMaxAge(0);
                        cookie.setPath("/");
                        response.addCookie(cookie);
                    }
                }
            }
            response.sendRedirect("home"); // ✅ Về trang chủ thay vì login.jsp
            return;
        }
        response.sendRedirect("home");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if(action.equals("signin")){
            handleSignIn(request, response);
        }else if(action.equals("signup")){
            handleSignUp(request, response);
        }else {
            response.sendRedirect("login.jsp");
        }
    }

    private void handleSignIn(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("signup".equals(action)) {
            handleSignUp(request, response);
        } else {
            response.sendRedirect("login.jsp");
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

        if (username == null || email == null || password == null || cfPassword == null
                || fullName == null || phone == null || address == null) {
            request.setAttribute("error", "Vui lòng điền đầy đủ thông tin!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

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

        User user = new User();
        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(password);
        user.setFullName(fullName);
        user.setPhone(phone);
        user.setAddress(address);
        user.setRoleId(1); // Mặc định là Khách hàng (role_id: 1)
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

    @Override
    public String getServletInfo() {
        return "Customer Servlet for handling login, logout, and signup";
    }
}
