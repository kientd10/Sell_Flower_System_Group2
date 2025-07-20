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
            // Tạo order mới
            OrderDAO orderDao = new OrderDAO();
            int orderId = orderDao.createOrderForCustomRequest(user.getUserId(), fr.getSuggestedPrice(), requestId);
            // Cập nhật trạng thái flower_request
            frDao.updateStatus(requestId, "accepted");
            // Tạo notification cho shop/manager
            NotificationDAO ndao = new NotificationDAO();
            ndao.createForManager("Khách hàng đã xác nhận đặt hoa theo yêu cầu!", requestId);
            response.sendRedirect("orderDetail.jsp?orderId=" + orderId + "&msg=Đặt hàng thành công!");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("viewShopReply.jsp?error=Đặt hàng thất bại!");
        }
    }
} 