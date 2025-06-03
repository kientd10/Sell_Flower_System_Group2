/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import dal.BouquetDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import Model.BouquetTemplate;
import Model.ShoppingCart;
import Model.User;

/**
 *
 * @author PC
 */
public class CartServlet extends HttpServlet {

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
            out.println("<title>Servlet CartServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CartServlet at " + request.getContextPath() + "</h1>");
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
        User user = (User) request.getSession().getAttribute("user");
        int user_id = user.getUserId();
        BouquetDAO c = new BouquetDAO();
        List<ShoppingCart> cart_items = c.getCartItemsByUserId(user_id);
        request.setAttribute("cart", cart_items);
        request.setAttribute("userId", user_id);
        request.getRequestDispatcher("cart.jsp").forward(request, response);
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
        String cartId = request.getParameter("cartId");
        String isChecked = request.getParameter("isChecked");
        if (cartId != null) {
            HttpSession session = request.getSession();
            List<String> selectedCartIds = (List<String>) session.getAttribute("selectedCartIds");
            if (selectedCartIds == null) {
                selectedCartIds = new ArrayList<>();
            }
            if (isChecked != null) {
                if (!selectedCartIds.contains(cartId)) {
                    selectedCartIds.add(cartId);
                }
            } else {
                selectedCartIds.remove(cartId);
            }
            if(!selectedCartIds.isEmpty()){
                session.removeAttribute("error");
            }
            session.setAttribute("selectedCartIds", selectedCartIds);
            response.sendRedirect("cart");
            return;
        }
        int userId = Integer.parseInt(request.getParameter("userId"));
        int templateId = Integer.parseInt(request.getParameter("templateId"));
        String action = request.getParameter("action");
        BouquetDAO c = new BouquetDAO();
        ShoppingCart item = c.getItems(userId, templateId);
        int current_quantity = item.getQuantity();
        int new_quantity = "up".equals(action) ? current_quantity + 1 : current_quantity - 1;
        if (new_quantity >= 0) {
            try {
                c.updateQuantity(userId, templateId, new_quantity);
            } catch (Exception ex) {
                Logger.getLogger(CartServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {

        }
        double basePrice = item.getBouquetTemplate().getBasePrice();
        double new_price = new_quantity * basePrice;
        request.setAttribute("updatedTemplateId", templateId);
        request.setAttribute("updatedQuantity", new_quantity);
        request.setAttribute("updatedLineTotal", new_price);
        List<ShoppingCart> cart_items = c.getCartItemsByUserId(userId);
        request.setAttribute("cart", cart_items);
        request.setAttribute("userId", userId);
        request.getRequestDispatcher("cart.jsp")
                .forward(request, response);
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
