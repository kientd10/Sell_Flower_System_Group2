package Controller;

import dal.FlowerRequestDAO;
import dal.NotificationDAO;
import dal.OrderDAO;
import Model.FlowerRequest;
import Model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;

public class ConfirmOrderServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            User user = (User) request.getSession().getAttribute("user");
            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }
            int requestId = Integer.parseInt(request.getParameter("requestId"));
            FlowerRequestDAO frDao = new FlowerRequestDAO();
            FlowerRequest fr = frDao.getRequestById(requestId);
            if (fr == null || !"sample_sent".equals(fr.getStatus())) {
                response.sendRedirect("viewShopReply.jsp?error=Yêu cầu không hợp lệ!");
                return;
            }
            // Lưu requestId vào session để nhận diện đơn hoa theo yêu cầu
            request.getSession().setAttribute("customFlowerRequestId", requestId);
            request.getSession().setAttribute("customFlowerQuantity", fr.getQuantity());
            request.getSession().setAttribute("customFlowerPrice", fr.getSuggestedPrice());
            // Xóa giỏ hàng khỏi session để tránh hiển thị sản phẩm thường ở checkout
            request.getSession().removeAttribute("cart");
            request.getSession().removeAttribute("selectedCartIds");
            // Chuyển sang trang checkout
            response.sendRedirect("checkout.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("viewShopReply.jsp?error=Đặt hàng thất bại!");
        }
    }
} 