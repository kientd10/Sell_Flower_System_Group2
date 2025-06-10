/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

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
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author PC
 */
public class RemoveServlet extends HttpServlet {

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
            out.println("<title>Servlet RemoveServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RemoveServlet at " + request.getContextPath() + "</h1>");
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
        int templateID = Integer.parseInt(request.getParameter("templateId"));
        if (user == null) {
            List<ShoppingCart> sessionCart = (List<ShoppingCart>) session.getAttribute("cart");
            if (sessionCart == null) {
                sessionCart = new ArrayList<>();
            }
            for (int i = 0; i < sessionCart.size(); i++) {
                if (sessionCart.get(i).getBouquetTemplate().getTemplateId() == templateID) {
                    sessionCart.remove(i);
                    break;
                }
            }
            session.setAttribute("cart", sessionCart);
            response.sendRedirect("cart");

        } else {
            List<ShoppingCart> cart_session = (List<ShoppingCart>) session.getAttribute("cart");
            int user_id = user.getUserId();
            if (cart_session == null) {
                BouquetDAO c = new BouquetDAO();
                List<ShoppingCart> cart_db = c.getCartItemsByUserId(user_id);
                session.setAttribute("cart", cart_db);
                request.setAttribute("cart", cart_db);
                request.getRequestDispatcher("cart.jsp").forward(request, response);
            } else {
                BouquetDAO c = new BouquetDAO();
                List<ShoppingCart> cart_db = c.getCartItemsByUserId(user_id);
                if (cart_db == null) {
                    cart_db = new ArrayList<>();
                }
                for (ShoppingCart sessionItem : cart_session) {
                    boolean found = false;
                    for (ShoppingCart cartItems : cart_db) {
                        if (sessionItem.getBouquetTemplate().getTemplateId() == cartItems.getBouquetTemplate().getTemplateId()) {
                            cartItems.setQuantity(cartItems.getQuantity() + sessionItem.getQuantity());
                            found = true;
                            break;
                        }
                    }
                    if (!found) {
                        cart_db.add(new ShoppingCart(user_id, sessionItem.getBouquetTemplate(), sessionItem.getQuantity()));
                    }
                }
                c.deleteCartItems(templateID, user_id);
                List<ShoppingCart> updatedCart = c.getCartItemsByUserId(user_id);
                session.setAttribute("cart", updatedCart);
                response.sendRedirect("cart");
            }
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
