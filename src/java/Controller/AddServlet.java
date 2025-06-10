/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.BouquetTemplate;
import Model.ShoppingCart;
import Model.User;
import dal.BouquetDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.AbstractList;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author PC
 */
public class AddServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
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
            out.println("<title>Servlet AddServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            List<ShoppingCart> sessionCart = (List<ShoppingCart>) session.getAttribute("cart");
            if (sessionCart == null) {
                sessionCart = new ArrayList<>();
            }
            BouquetDAO c = new BouquetDAO();
            int template_id = Integer.parseInt(request.getParameter("templateId"));
            BouquetTemplate b = c.getBouquetById(template_id);
            int quantity = 1;
            ShoppingCart e = new ShoppingCart( b, quantity);
            boolean found = false;
            for (ShoppingCart item : sessionCart) {
                if (item.getBouquetTemplate().getTemplateId() == template_id) {
                    item.setQuantity(item.getQuantity() + quantity);
                    found = true;
                    break;

                }
            }
            if (!found) {
                sessionCart.add(e);
            }
            session.setAttribute("cart", sessionCart);
            response.sendRedirect("home");
        } else {
            int user_id = user.getUserId();
            int template_id = Integer.parseInt(request.getParameter("templateId"));
            int quantity = 1;
            BouquetDAO c = new BouquetDAO();
            c.addToCart(user_id, template_id, quantity);
            response.sendRedirect("home");
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
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
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
