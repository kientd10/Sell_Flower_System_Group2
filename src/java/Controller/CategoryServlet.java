package Controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dal.CategoryDAO;
import dal.BouquetDAO;
import Model.Category;
import Model.BouquetTemplate;
import java.util.List;

public class CategoryServlet extends HttpServlet {

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

        List<Category> categories = categoryDAO.getAllCategories();

        int pageNum = 1;
        int recordsPerPage = 4; // hoặc số sản phẩm muốn hiển thị mỗi trang
        String pageNumStr = request.getParameter("pageNum");
        if (pageNumStr != null) {
            try {
                pageNum = Integer.parseInt(pageNumStr);
            } catch (NumberFormatException e) {
                pageNum = 1;
            }
        }

        String categoryIdStr = request.getParameter("categoryId");
        List<BouquetTemplate> bouquets = null;
        int totalRecords = 0;

        if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
            try {
                int categoryId = Integer.parseInt(categoryIdStr);
                int offset = (pageNum - 1) * recordsPerPage;

                bouquets = bouquetDAO.getBouquetsByCategoryIdPaging(categoryId, offset, recordsPerPage);
                totalRecords = bouquetDAO.countBouquetsByCategory(categoryId);

                request.setAttribute("categoryId", categoryId);
            } catch (NumberFormatException e) {
                bouquets = bouquetDAO.getAllBouquetsPaging((pageNum - 1) * recordsPerPage, recordsPerPage);
                totalRecords = bouquetDAO.countAllBouquets();
            }
        } else {
            int offset = (pageNum - 1) * recordsPerPage;
            bouquets = bouquetDAO.getAllBouquetsPaging(offset, recordsPerPage);
            totalRecords = bouquetDAO.countAllBouquets();
        }

        int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);

        request.setAttribute("categories", categories);
        request.setAttribute("bouquets", bouquets);
        request.setAttribute("page", "category");
        request.setAttribute("currentPage", pageNum);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Bạn có thể gọi doGet nếu muốn xử lý giống GET
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "CategoryServlet for handling products by category";
    }
}
