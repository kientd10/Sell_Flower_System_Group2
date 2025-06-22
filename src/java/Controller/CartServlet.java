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
import dal.OrderDAO;
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
    HttpSession session = request.getSession();
    User user = (User) session.getAttribute("user");

    List<ShoppingCart> cartList;

    if (user == null) {
        cartList = (List<ShoppingCart>) session.getAttribute("cart");
        if (cartList == null) {
            cartList = new ArrayList<>();
            session.setAttribute("cart", cartList);
        }
    } else {
        boolean merged = session.getAttribute("cartMerged") != null;
        List<ShoppingCart> cart_session = (List<ShoppingCart>) session.getAttribute("cart");
        int user_id = user.getUserId();

        BouquetDAO c = new BouquetDAO();
        cartList = c.getCartItemsByUserId(user_id);
        if (cartList == null) {
            cartList = new ArrayList<>();
        }

        if (!merged && cart_session != null) {
            for (ShoppingCart sessionItem : cart_session) {
                boolean found = false;
                for (ShoppingCart cartItems : cartList) {
                    if (sessionItem.getBouquetTemplate().getTemplateId() == cartItems.getBouquetTemplate().getTemplateId()) {
                        cartItems.setQuantity(cartItems.getQuantity() + sessionItem.getQuantity());
                        found = true;
                        break;
                    }
                }
                if (!found) {
                    cartList.add(new ShoppingCart(user_id, sessionItem.getBouquetTemplate(), sessionItem.getQuantity()));
                }
            }
            session.setAttribute("cartMerged", true);
        }

        session.setAttribute("cart", cartList);

        // ✅ THÊM: luôn set purchasedProducts nếu đã đăng nhập
        OrderDAO orderDAO = new OrderDAO();
        List<BouquetTemplate> purchasedProducts = orderDAO.getPurchasedProductsByUser(user_id);
        request.setAttribute("purchasedProducts", purchasedProducts);
    }

    // ✅ luôn set cart và forward sau cùng
    request.setAttribute("cart", cartList);
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
        List<ShoppingCart> allCartItems = c.getCartItemsByUserId(user_id);
List<ShoppingCart> selectedItems = new ArrayList<>();

for (ShoppingCart item : allCartItems) {
    if (selectedCartIds.contains(String.valueOf(item.getCartId()))) {
        selectedItems.add(item);
    }
}

session.setAttribute("cart", selectedItems); // ✅ chỉ lưu sản phẩm được chọn
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
