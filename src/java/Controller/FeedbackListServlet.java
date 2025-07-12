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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Admin
 */
@WebServlet(name="FeedbackListServlet", urlPatterns={"/feedbacklistservlet"})
public class FeedbackListServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet FeedbackListServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet FeedbackListServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
   @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy user từ session
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        OrderDAO dao = new OrderDAO();
        ProductFeedbackDAO fdao = new ProductFeedbackDAO();

        try {
            // Danh sách sản phẩm đã mua
            List<BouquetTemplate> list = dao.getPurchasedProductsByUser(user.getUserId());
            request.setAttribute("purchasedProducts", list);

            // Map lưu đánh giá đã có của user
            Map<Integer, ProductFeedback> userFeedbackMap = new HashMap<>();
            for (BouquetTemplate b : list) {
                ProductFeedback feedback = fdao.getFeedback(b.getTemplateId(), user.getUserId());
                if (feedback != null) {
                    userFeedbackMap.put(b.getTemplateId(), feedback);
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
        return "Hiển thị danh sách sản phẩm đã mua và cho phép đánh giá";
    }
}