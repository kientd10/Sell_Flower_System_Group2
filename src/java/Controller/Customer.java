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
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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
            // Kiểm tra username đã tồn tại chưa
            if (checkusername) {
                request.setAttribute("errorname", "Username is existed!");
                request.setAttribute("email", email);
                request.setAttribute("phone", phone);
                request.setAttribute("address", address);
                request.setAttribute("pass", pass);
                request.setAttribute("CFpass", cfPass);
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
            
            if (name.isBlank()) {
                request.setAttribute("errorpass", "User name is not valid!");
                request.setAttribute("username", name);
                request.setAttribute("email", email);
                request.setAttribute("phone", phone);
                request.setAttribute("address", address);
                request.setAttribute("pass", pass);
                request.setAttribute("CFpass", cfPass);
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            // Kiểm tra email đã tồn tại chưa
            if (checkemail) {
                request.setAttribute("username", name);
                request.setAttribute("phone", phone);
                request.setAttribute("address", address);
                request.setAttribute("emailavailable", "Email is existed!");
                request.setAttribute("pass", pass);
                request.setAttribute("CFpass", cfPass);
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
            
            if(!isValidEmail(email)){
                request.setAttribute("username", name);
                request.setAttribute("phone", phone);
                request.setAttribute("address", address);
                request.setAttribute("pass", pass);
                request.setAttribute("CFpass", cfPass);
                request.setAttribute("emailavailable", "Email is not valid!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            // Kiểm tra mật khẩu và xác nhận mật khẩu
            if (pass.isBlank()) {
                request.setAttribute("errorpass", "Pass is not valid!");
                request.setAttribute("username", name);
                request.setAttribute("email", email);
                request.setAttribute("phone", phone);
                request.setAttribute("address", address);
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
             if(!cfPass.equals(pass)){
                request.setAttribute("errorpass", "Confirm is not true!");
                request.setAttribute("username", name);
                request.setAttribute("email", email);
                request.setAttribute("phone", phone);
                request.setAttribute("address", address);
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
             }
             
             //số điện thoại
             if (phone.isBlank()) {
                request.setAttribute("errorpass", "Phone is not valid!");
                request.setAttribute("username", name);
                request.setAttribute("email", email);
                request.setAttribute("phone", phone);
                request.setAttribute("address", address);
                request.setAttribute("pass", pass);
                request.setAttribute("CFpass", cfPass);
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
             
             if(!phone.matches("^0\\d{9}$")){
                 request.setAttribute("errorpass", "Phone must start with 0 and have 10 characters!");
                request.setAttribute("username", name);
                request.setAttribute("email", email);
                request.setAttribute("phone", phone);
                request.setAttribute("address", address);
                request.setAttribute("pass", pass);
                request.setAttribute("CFpass", cfPass);
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
             }
             
             //địa chỉ
             if (address.isBlank() ) {
                request.setAttribute("errorpass", "Address is not valid!");
                request.setAttribute("username", name);
                request.setAttribute("email", email);
                request.setAttribute("phone", phone);
                request.setAttribute("address", address);
                request.setAttribute("pass", pass);
                request.setAttribute("CFpass", cfPass);
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
             
             if (address.length()>30) {
                request.setAttribute("errorpass", "Address is too long!");
                request.setAttribute("username", name);
                request.setAttribute("email", email);
                request.setAttribute("phone", phone);
                request.setAttribute("address", address);
                request.setAttribute("pass", pass);
                request.setAttribute("CFpass", cfPass);
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
             
             

            // Nếu qua được tất cả các bước kiểm tra thì thực hiện đăng ký
            User user = new User();
            user.setUsername(name);
            user.setEmail(email);
            user.setPassword(pass);
            user.setPhone(phone);
            user.setAddress(address);
            user.setRoleId(1); // Mặc định là Khách hàng
            user.setIsActive(true);

            dao.registerUser(user);

            request.setAttribute("done", "Register successful!");
            request.getRequestDispatcher("login.jsp").forward(request, response);

        }

    }
    
    public boolean isValidEmail(String email) {
        // Biểu thức chính quy cho định dạng email
        String emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Z|a-z]{2,}$";

        // Tạo đối tượng Pattern
        Pattern pattern = Pattern.compile(emailRegex);

        // Tạo đối tượng Matcher
        Matcher matcher = pattern.matcher(email);

        // Kiểm tra chuỗi với biểu thức chính quy
        return matcher.matches();
    }


    @Override
    public String getServletInfo() {
        return "Customer Servlet for handling login, logout, and signup";
    }
}
