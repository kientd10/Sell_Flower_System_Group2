/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import Model.ProductFeedback;
import dal.ProductFeedbackDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

/**
 *
 * @author Admin
 */
@WebServlet(name="FeedbackServlet", urlPatterns={"/feedbackservlet"})
public class FeedbackServlet extends HttpServlet {
   
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
            out.println("<title>Servlet FeedbackServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet FeedbackServlet at " + request.getContextPath () + "</h1>");
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int customerId = ((Model.User) request.getSession().getAttribute("user")).getUserId();
        int productId = Integer.parseInt(request.getParameter("product_id"));

        ProductFeedbackDAO dao = new ProductFeedbackDAO();
        ProductFeedback fb = null;
        try {
            fb = dao.getFeedback(productId, customerId);
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("product_id", productId);
        request.setAttribute("feedback", fb);
        request.getRequestDispatcher("feedback_form.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int customerId = ((Model.User) request.getSession().getAttribute("user")).getUserId();
        int productId = Integer.parseInt(request.getParameter("product_id"));
        int rating = Integer.parseInt(request.getParameter("rating"));
        String comment = request.getParameter("comment");

        ProductFeedbackDAO dao = new ProductFeedbackDAO();
        try {
            ProductFeedback fb = dao.getFeedback(productId, customerId);
            if (fb == null) {
                fb = new ProductFeedback();
                fb.setCustomerId(customerId);
                fb.setProductId(productId);
                fb.setRating(rating);
                fb.setComment(comment);
                dao.insertFeedback(fb);
            } else {
                fb.setRating(rating);
                fb.setComment(comment);
                dao.updateFeedback(fb);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("cart");
    }
}

