package Controller;

import dal.FlowerRequestDAO;
import Model.FlowerRequest;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name="CancelRequestServlet", urlPatterns={"/cancel-request"})
public class CancelRequestServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String requestIdStr = request.getParameter("requestId");
        String errorMsg = null;
        try {
            if (requestIdStr != null) {
                int requestId = Integer.parseInt(requestIdStr);
                FlowerRequestDAO dao = new FlowerRequestDAO();
                boolean deleted = dao.deleteRequestAndNotificationsIfNoOrder(requestId);
                if (!deleted) {
                    errorMsg = "Đơn hàng đang xử lí, vui lòng xem ở mục chi tiết đơn hàng!";
                    FlowerRequest fr = dao.getRequestById(requestId);
                    request.setAttribute("flowerRequest", fr);
                    request.setAttribute("errorMsg", errorMsg);
                    request.getRequestDispatcher("viewShopReply.jsp").forward(request, response);
                    return;
                }
            }
        } catch (Exception ignore) {}
        response.sendRedirect(request.getContextPath() + "/home");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
} 