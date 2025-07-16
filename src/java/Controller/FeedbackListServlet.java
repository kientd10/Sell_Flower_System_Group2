/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import Model.BouquetTemplate;
import Model.ProductFeedback;
import Model.User;
import dal.OrderDAO;
import dal.ProductFeedbackDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Admin
 */
@WebServlet(name = "FeedbackListServlet", urlPatterns = {"/feedbacklistservlet"})
public class FeedbackListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        OrderDAO orderDAO = new OrderDAO();
        ProductFeedbackDAO feedbackDAO = new ProductFeedbackDAO();

        try {
            // Lấy danh sách sản phẩm đã giao thành công
            List<BouquetTemplate> purchasedProducts = orderDAO.getPurchasedProductsByUser(user.getUserId());
            

            request.setAttribute("purchasedProducts", purchasedProducts);

            // Lấy feedback nếu người dùng đã đánh giá
            Map<Integer, ProductFeedback> userFeedbackMap = new HashMap<>();
            for (BouquetTemplate bt : purchasedProducts) {
                ProductFeedback feedback = feedbackDAO.getFeedback(bt.getTemplateId(), user.getUserId());
                if (feedback != null) {
                    userFeedbackMap.put(bt.getTemplateId(), feedback);
                }
            }
            request.setAttribute("userFeedbackMap", userFeedbackMap);

            request.getRequestDispatcher("feedback_list.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Hiển thị danh sách sản phẩm đã được giao và cho phép đánh giá";
    }
}