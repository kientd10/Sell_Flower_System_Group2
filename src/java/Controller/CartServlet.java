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
import java.util.Arrays;

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
         HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        int user_id = user.getUserId();
        BouquetDAO c = new BouquetDAO();

        String[] templateIds = request.getParameterValues("templateId[]");
        String[] quantities = request.getParameterValues("quantity[]");
        String[] cartIds = request.getParameterValues("cartId[]");
        String[] checkedCartIds = request.getParameterValues("isChecked[]");
        if (templateIds != null && quantities != null && templateIds.length == quantities.length) {
            try {
                for (int i = 0; i < templateIds.length; i++) {
                    int templateId = Integer.parseInt(templateIds[i]);
                    int quantity = Integer.parseInt(quantities[i]);
                    c.updateQuantity(user_id, templateId, quantity);
                }
            } catch (Exception ex) {
                Logger.getLogger(CartServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        List<String> selectedCartIds = new ArrayList<>();
        if (checkedCartIds != null) {
            selectedCartIds.addAll(Arrays.asList(checkedCartIds));
        }

        if (selectedCartIds.isEmpty()) {
            session.setAttribute("error", "Chọn ít nhất 1 sản phẩm");
            response.sendRedirect("cart");
            return;
        } else {
            session.removeAttribute("error");
        }

        session.setAttribute("selectedCartIds", selectedCartIds);
        response.sendRedirect("checkout.jsp");
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
