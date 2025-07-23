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
import java.security.MessageDigest;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.nio.charset.StandardCharsets;

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

        //Log out
        if (action.equals("logout")) {
            HttpSession session = request.getSession();
            session.removeAttribute("user");
            session.invalidate();
            response.sendRedirect("login.jsp");
        }

        //Sign up
        if (action.equals("signup")) {
            String name = request.getParameter("name");
            String email = request.getParameter("Email");
            String pass1 = request.getParameter("Password");
            String pass = pass1.trim();
            String cfPass1 = request.getParameter("CfPassword");
            String cfPass = cfPass1.trim();
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");

            boolean checkemail = dao.emailExists(email);
            // Kiểm tra username 
            
            if(dao.isUsernameExists(name)){
                request.setAttribute("errorpass", "Tên người dùng không hợp lệ!");
                request.setAttribute("username", name);
                request.setAttribute("email", email);
                request.setAttribute("phone", phone);
                request.setAttribute("address", address);
                request.setAttribute("pass", pass);
                request.setAttribute("CFpass", cfPass);
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            if (name.isBlank()) {
                request.setAttribute("errorpass", "Tên người dùng không hợp lệ!");
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
                request.setAttribute("emailavailable", "Email đã tồn tại!");
                request.setAttribute("pass", pass);
                request.setAttribute("CFpass", cfPass);
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            if (!isValidEmail(email)) {
                request.setAttribute("username", name);
                request.setAttribute("phone", phone);
                request.setAttribute("address", address);
                request.setAttribute("pass", pass);
                request.setAttribute("CFpass", cfPass);
                request.setAttribute("emailavailable", "Email không hợp lệ!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            // Kiểm tra mật khẩu và xác nhận mật khẩu
            if (pass.isBlank()) {
                request.setAttribute("errorpass", "Mật khẩu không hợp lệ!");
                request.setAttribute("username", name);
                request.setAttribute("email", email);
                request.setAttribute("phone", phone);
                request.setAttribute("address", address);
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
            if (!cfPass.equals(pass)) {//so sánh pass và confirm pass
                request.setAttribute("errorpass", "Mật khẩu xác nhận không đúng!");
                request.setAttribute("username", name);
                request.setAttribute("email", email);
                request.setAttribute("phone", phone);
                request.setAttribute("address", address);
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            //số điện thoại
            if (phone.isBlank()) {
                request.setAttribute("errorpass", "Số điện thoại không hợp lệ!");
                request.setAttribute("username", name);
                request.setAttribute("email", email);
                request.setAttribute("phone", phone);
                request.setAttribute("address", address);
                request.setAttribute("pass", pass);
                request.setAttribute("CFpass", cfPass);
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            if (!phone.matches("^0\\d{9}$")) {
                request.setAttribute("errorpass", "Số điện thoại bắt đầu từ 0 và có 10 chữ số!");
                request.setAttribute("username", name);
                request.setAttribute("email", email);
                request.setAttribute("phone", phone);
                request.setAttribute("address", address);
                request.setAttribute("pass", pass);
                request.setAttribute("CFpass", cfPass);
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            boolean checkPhone = dao.GetPhone(phone);
            if (checkPhone) {//kiểm tra trùng số điện thoại
                request.setAttribute("errorpass", "Số điện thoại đã tồn tại!");
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
            if (address.isBlank()) {
                request.setAttribute("errorpass", "Địa chỉ không hợp lệ!");
                request.setAttribute("username", name);
                request.setAttribute("email", email);
                request.setAttribute("phone", phone);
                request.setAttribute("address", address);
                request.setAttribute("pass", pass);
                request.setAttribute("CFpass", cfPass);
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            if (address.length() > 30) {
                request.setAttribute("errorpass", "Địa chỉ chứa tối đa 30 kí tự!");
                request.setAttribute("username", name);
                request.setAttribute("email", email);
                request.setAttribute("phone", phone);
                request.setAttribute("address", address);
                request.setAttribute("pass", pass);
                request.setAttribute("CFpass", cfPass);
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            String hassPassword = hashPassword(pass);

            // Nếu qua được tất cả các bước kiểm tra thì thực hiện đăng ký
            User user = new User();
            user.setUsername(name);
            user.setEmail(email);
            user.setPassword(hassPassword);
            user.setPhone(phone);
            user.setAddress(address);
            user.setRoleId(1); // Mặc định là Khách hàng
            user.setIsActive(true);

            boolean success = dao.registerUser(user);
            if (success) {
                ForgotPassword.sendRegistrationEmail(email, name);
                request.setAttribute("email", email);
                request.setAttribute("password", pass);
                request.setAttribute("done", "Đăng ký thành công!");
                request.getRequestDispatcher("login.jsp?action=login").forward(request, response);
            } else {
                request.setAttribute("errorpass", "Có lỗi xảy ra khi đăng ký, vui lòng thử lại!");
                request.setAttribute("username", name);
                request.setAttribute("email", email);
                request.setAttribute("phone", phone);
                request.setAttribute("address", address);
                request.setAttribute("pass", pass);
                request.setAttribute("CFpass", cfPass);
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

        }

    }

    public static String hashPassword(String password) {
        try {
            // Tạo đối tượng MessageDigest với SHA-256
            MessageDigest digest = MessageDigest.getInstance("SHA-256");

            // Chuyển chuỗi password thành mảng byte
            byte[] encodedHash = digest.digest(password.getBytes(StandardCharsets.UTF_8));

            // Chuyển byte[] thành chuỗi hex
            StringBuilder hexString = new StringBuilder();
            for (byte b : encodedHash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) {
                    hexString.append('0'); // nếu chỉ 1 ký tự thì thêm 0 ở đầu
                }
                hexString.append(hex);
            }

            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Không tìm thấy thuật toán SHA-256", e);
        }
    }

    // check emnail
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
