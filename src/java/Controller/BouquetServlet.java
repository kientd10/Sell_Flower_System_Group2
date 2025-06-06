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
        //////////////////// View 
        String categoryIdStr = request.getParameter("categoryId");
        String minPriceStr = request.getParameter("minPrice");
        String maxPriceStr = request.getParameter("maxPrice");
        int page = 1;
        int recordsPerPage = 12;

        if (request.getParameter("pageNum") != null) {
            try {
                page = Integer.parseInt(request.getParameter("pageNum"));
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        int offset = (page - 1) * recordsPerPage;
        int categoryId = -1;
        Double minPrice = null, maxPrice = null;

        try {
            if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
                categoryId = Integer.parseInt(categoryIdStr);
            }
            if (minPriceStr != null && !minPriceStr.isEmpty()) {
                minPrice = Double.parseDouble(minPriceStr);
            }
            if (maxPriceStr != null && !maxPriceStr.isEmpty()) {
                maxPrice = Double.parseDouble(maxPriceStr);
            }
        } catch (NumberFormatException e) {
            minPrice = null;
            maxPrice = null;
        }

        try {
            BouquetDAO bouquetDAO = new BouquetDAO();
            CategoryDAO categoryDAO = new CategoryDAO();

            List<BouquetTemplate> bouquets;
            List<Category> categories = categoryDAO.getAllCategories();
            int totalRecords;

            // Phân loại chính xác từng loại lọc
            if (categoryId != -1 && minPrice == null && maxPrice == null) {
                // Chỉ lọc theo categoryId
                bouquets = bouquetDAO.filterBouquets(categoryId, null, null, offset, recordsPerPage);
                totalRecords = bouquetDAO.countFilteredBouquets(categoryId, null, null);
                request.setAttribute("page", "category");
                request.setAttribute("categoryId", categoryId);
            } else if (categoryId != -1 || minPrice != null || maxPrice != null) {
                // Có lọc theo category + price
                bouquets = bouquetDAO.filterBouquets(categoryId, minPrice, maxPrice, offset, recordsPerPage);
                totalRecords = bouquetDAO.countFilteredBouquets(categoryId, minPrice, maxPrice);
                request.setAttribute("page", "filter");
                request.setAttribute("categoryId", categoryId != -1 ? categoryId : null);
                request.setAttribute("minPrice", minPrice);
                request.setAttribute("maxPrice", maxPrice);
            } else {
                // Không lọc
                bouquets = bouquetDAO.getAllBouquetsPaging(offset, recordsPerPage);
                totalRecords = bouquetDAO.countAllBouquets();
                request.setAttribute("page", "home");
            }

            int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);

            request.setAttribute("categories", categories);
            request.setAttribute("bouquets", bouquets);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);

            request.getRequestDispatcher("index.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
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
