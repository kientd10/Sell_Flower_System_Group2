/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.BouquetTemplate;
import Model.Category;
import dal.BouquetDAO;
import dal.CategoryDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ADMIN
 */
public class BouquetServlet extends HttpServlet {

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
            out.println("<title>Servlet BouquetServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BouquetServlet at " + request.getContextPath() + "</h1>");
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
    String categoryIdStr = request.getParameter("categoryId");
    List<BouquetTemplate> bouquets = new ArrayList<>();
    List<Category> categories = new ArrayList<>();

    try {
        // Load tất cả category để hiển thị menu
        CategoryDAO categoryDAO = new CategoryDAO();
        categories = categoryDAO.getAllCategories();

        if (categoryIdStr != null) {
            int categoryId = Integer.parseInt(categoryIdStr);
            BouquetDAO dao = new BouquetDAO();
            bouquets = dao.getBouquetsByCategoryId(categoryId);
        }
    } catch (NumberFormatException e) {
        e.printStackTrace();
    }

    // Set danh sách category vào request để hiển thị menu
    request.setAttribute("categories", categories);
    // Set danh sách sản phẩm theo category
    request.setAttribute("bouquets", bouquets);
    // Chuyển tiếp về trang index.jsp (hoặc trang hiển thị chính)
    request.getRequestDispatcher("index.jsp").forward(request, response);
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
