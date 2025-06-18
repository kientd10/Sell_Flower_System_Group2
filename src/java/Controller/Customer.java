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
        doPost(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");
        UserDAO dao = new UserDAO();
        //login
        if (action.equals("signin")) {
            String email = request.getParameter("email");
            String pass = request.getParameter("password");
            String remember = request.getParameter("remember");
            Model.User a = dao.loginUser(email, pass);
            if (a == null) {
                request.setAttribute("error", "Account is not exist!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                //set cookie
                HttpSession session = request.getSession();
                session.setAttribute("user", a);
                Cookie Email = new Cookie("email", email);
                Cookie Pass = new Cookie("password", pass);
                Cookie Remember = new Cookie("remember", remember);
                if (remember != null) {
                    Email.setMaxAge(60 * 60 * 24 * 30);
                    Pass.setMaxAge(60 * 60 * 24 * 3);
                    Remember.setMaxAge(60 * 60 * 24 * 30);
                } else {
                    Email.setMaxAge(0);
                    Pass.setMaxAge(0);
                    Remember.setMaxAge(0);
                }
                response.addCookie(Email);
                response.addCookie(Pass);
                response.addCookie(Remember);
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }

        }

        //Log out
        if (action.equals("logout")) {
            HttpSession session = request.getSession();
            session.removeAttribute("user");
            session.invalidate();
            response.sendRedirect("home");
        }

        //Sign up
        if (action.equals("signup")) {
            String name = request.getParameter("name");
            String email = request.getParameter("Email");
            String pass = request.getParameter("Password");
            String cfPass = request.getParameter("CfPassword");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");

            boolean checkemail = dao.emailExists(email);
            boolean checkusername = dao.isUsernameExists(name);
            if (checkusername == false) { // check user name exist
                if (checkemail == false) { // check email exist
                    if (pass.equals(cfPass)) { // pass equal confirm pass -> signup
                        request.setAttribute("done", "Register successfull!");
                        User user = new User();
                        user.setUsername(name);
                        user.setEmail(email);
                        user.setPassword(pass);
                        user.setPhone(phone);
                        user.setAddress(address);
                        user.setRoleId(1); // Mặc định là Khách hàng (role_id: 1)
                        user.setIsActive(true);
                        dao.registerUser(user);
                        request.getRequestDispatcher("login.jsp").forward(request, response);
                    } else {
                        request.setAttribute("errorpass", "Confirm pass is not true!");
                        request.setAttribute("username", name);
                        request.setAttribute("email", email);
                        request.setAttribute("phone", phone);
                        request.setAttribute("address", address);
                        request.getRequestDispatcher("login.jsp").forward(request, response);
                    }
                } else {
                    request.setAttribute("username", name);
                    request.setAttribute("phone", phone);
                    request.setAttribute("address", address);
                    request.setAttribute("emailavailable", "Email is existed!");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("errorname", "Username is existed!");
                request.setAttribute("email", email);
                request.setAttribute("phone", phone);
                request.setAttribute("address", address);
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

        }

    }

    @Override
    public String getServletInfo() {
        return "Customer Servlet for handling login, logout, and signup";
    }
}
