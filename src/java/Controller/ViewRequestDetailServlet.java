package Controller;

import dal.FlowerRequestDAO;
import Model.FlowerRequest;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ViewRequestDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int requestId = Integer.parseInt(request.getParameter("requestId"));
            FlowerRequestDAO dao = new FlowerRequestDAO();
            FlowerRequest fr = dao.getRequestById(requestId);
            if (fr == null) {
                response.sendRedirect(request.getContextPath() + "/notificationManagement?error=Không tìm thấy yêu cầu!");
                return;
            }
            request.setAttribute("flowerRequest", fr);
            request.getRequestDispatcher("viewRequestDetail.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/notificationManagement?error=Lỗi khi xem chi tiết!");
        }
    }
} 