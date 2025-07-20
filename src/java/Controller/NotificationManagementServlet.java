package Controller;

import dal.FlowerRequestDAO;
import Model.FlowerRequest;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class NotificationManagementServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            FlowerRequestDAO dao = new FlowerRequestDAO();
            List<FlowerRequest> requests = dao.getAllRequests();
            request.setAttribute("requests", requests);
            request.getRequestDispatcher("notificationManagement.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/index.jsp?error=Không thể tải danh sách yêu cầu!");
        }
    }
} 