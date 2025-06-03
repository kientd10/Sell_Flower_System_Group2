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
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 *
 * @author ADMIN
 */
public class HomeServlet extends HttpServlet {

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
            out.println("<title>Servlet HomeServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomeServlet at " + request.getContextPath() + "</h1>");
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
    ////////////////////////// 
    private CategoryDAO categoryDAO;
    private BouquetDAO bouquetDAO;

    @Override
    public void init() throws ServletException {
        categoryDAO = new CategoryDAO();
        bouquetDAO = new BouquetDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
      HttpSession session = request.getSession();
        
        // Lấy các thuộc tính từ session (nếu có từ SearchServlet)
        List<BouquetTemplate> searchResults = (List<BouquetTemplate>) session.getAttribute("searchResults");
        String searchQuery = (String) session.getAttribute("searchQuery");
        String error = (String) session.getAttribute("error");

        try {
            // Lấy danh sách danh mục
            List<Category> categories = categoryDAO.getAllCategories();
            request.setAttribute("categories", categories);

            // Lấy danh sách sản phẩm nổi bật (cho slider)
            List<BouquetTemplate> featuredBouquets = bouquetDAO.getAllBouquets(); // Sử dụng tạm getAllBouquets()
            request.setAttribute("featuredBouquets", featuredBouquets);

            // Xử lý danh sách bouquets
            List<BouquetTemplate> bouquets;
            String page; // để phân biệt home, category, hoặc search

            String categoryIdStr = request.getParameter("categoryId");
            if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
                page = "category";
                try {
                    int categoryId = Integer.parseInt(categoryIdStr);
                    bouquets = bouquetDAO.getBouquetsByCategoryId(categoryId);
                } catch (NumberFormatException e) {
                    bouquets = bouquetDAO.getAllBouquets(); // fallback nếu lỗi
                    page = "home";
                }
            } else if (searchResults != null) {
                // Nếu có kết quả tìm kiếm từ SearchServlet
                page = "search";
                bouquets = searchResults;
                request.setAttribute("searchQuery", searchQuery); // Truyền searchQuery để hiển thị
            } else {
                page = "home";
                bouquets = bouquetDAO.getAllBouquets(); // mặc định hiển thị tất cả
            }

            request.setAttribute("bouquets", bouquets);
            request.setAttribute("page", page);  // truyền biến page vào JSP để phân biệt

            // Chuyển error từ session sang request nếu có
            if (error != null) {
                request.setAttribute("error", error);
            }

            // Xóa các thuộc tính trong session sau khi sử dụng
            session.removeAttribute("searchResults");
            session.removeAttribute("searchQuery");
            session.removeAttribute("error");

            // Forward về index.jsp
            request.getRequestDispatcher("index.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi khi tải trang chủ. Vui lòng thử lại.");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }

    ////////////////////////////
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
