package Controller;

import dal.FlowerRequestDAO;
import dal.NotificationDAO;
import Model.FlowerRequest;
import Model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class CancelRequestServlet extends HttpServlet {
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
            if (fr == null || (!"sample_sent".equals(fr.getStatus()) && !"pending".equals(fr.getStatus()))) {
                response.sendRedirect("viewShopReply.jsp?error=Yêu cầu không hợp lệ!");
                return;
            }
            // Cập nhật trạng thái flower_request
            frDao.updateStatus(requestId, "rejected");
            // Tạo notification cho shop/manager
            NotificationDAO ndao = new NotificationDAO();
            ndao.createForManager("Khách hàng đã hủy yêu cầu hoa theo yêu cầu.", requestId);
            response.sendRedirect("index.jsp?msg=Đã hủy yêu cầu thành công!");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("viewShopReply.jsp?error=Hủy yêu cầu thất bại!");
        }
    }
} 