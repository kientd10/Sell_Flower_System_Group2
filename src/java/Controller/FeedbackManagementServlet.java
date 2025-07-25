/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import Model.ProductFeedback;
import dal.ProductFeedbackDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
@WebServlet(name="FeedbackManagementServlet", urlPatterns={"/feedbacks"})
public class FeedbackManagementServlet extends HttpServlet {
   
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
            out.println("<title>Servlet FeedbackManagementServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet FeedbackManagementServlet at " + request.getContextPath () + "</h1>");
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

        ProductFeedbackDAO dao = new ProductFeedbackDAO();

        try {
            String action = request.getParameter("action");

            // ===== XÓA PHẢN HỒI =====
            if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                dao.deleteFeedbackById(id);
                response.sendRedirect("feedbacks");
                return;
            }

            // ===== LỌC PHẢN HỒI =====
            String ratingParam = request.getParameter("rating");
            String timeParam = request.getParameter("time");

            List<ProductFeedback> feedbacks = dao.getAllFeedbacksWithCustomerName();

            // Lọc theo đánh giá
            if (ratingParam != null && !ratingParam.isEmpty()) {
                int rating = Integer.parseInt(ratingParam);
                feedbacks.removeIf(f -> f.getRating() != rating);
            }

            // Lọc theo thời gian
            if (timeParam != null && !timeParam.isEmpty()) {
                java.time.LocalDateTime now = java.time.LocalDateTime.now();
                java.time.LocalDateTime fromTime = switch (timeParam) {
                    case "today" -> now.toLocalDate().atStartOfDay();
                    case "yesterday" -> now.minusDays(1).toLocalDate().atStartOfDay();
                    case "week" -> now.with(java.time.DayOfWeek.MONDAY).toLocalDate().atStartOfDay();
                    case "month" -> now.withDayOfMonth(1).toLocalDate().atStartOfDay();
                    case "quarter" -> now.withMonth(((now.getMonthValue() - 1) / 3) * 3 + 1).withDayOfMonth(1).toLocalDate().atStartOfDay();
                    default -> null;
                };

                if (fromTime != null) {
                    feedbacks.removeIf(f -> f.getCreatedAt().toLocalDateTime().isBefore(fromTime));
                }
            }

            request.setAttribute("feedbacks", feedbacks);
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("error", "Không thể tải danh sách phản hồi.");
        }

        request.getRequestDispatcher("/feedbackManagement.jsp").forward(request, response);
    }

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
