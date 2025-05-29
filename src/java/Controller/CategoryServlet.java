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

        String categoryIdStr = request.getParameter("categoryId");
        List<BouquetTemplate> bouquets = null;

        if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
            try {
                int categoryId = Integer.parseInt(categoryIdStr);
                bouquets = bouquetDAO.getBouquetsByCategoryId(categoryId);
            } catch (NumberFormatException e) {
                bouquets = bouquetDAO.getAllBouquets(); // fallback
            }
        } else {
            bouquets = bouquetDAO.getAllBouquets();
        }

        request.setAttribute("categories", categories);
        request.setAttribute("bouquets", bouquets);
        request.setAttribute("page", "category"); // báo JSP đây là trang category

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
