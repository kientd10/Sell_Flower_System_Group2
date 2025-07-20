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
import java.util.ArrayList;

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
        String action = request.getParameter("action");
        try {
            if (action != null) {
                switch (action) {
                    case "create":
                        request.getRequestDispatcher("addCategory.jsp").forward(request, response);
                        return;
                    case "update":
                        String idParam = request.getParameter("id");
                        if (idParam != null && !idParam.isEmpty()) {
                            try {
                                int categoryId = Integer.parseInt(idParam);
                                Category category = categoryDAO.getCategoryById(categoryId);
                                if (category != null) {
                                    request.setAttribute("category", category);
                                    request.getRequestDispatcher("updateCategory.jsp").forward(request, response);
                                } else {
                                    request.setAttribute("error", "Danh mục không tồn tại!");
                                    request.getRequestDispatcher("/jsp/error.jsp").forward(request, response);
                                }
                            } catch (NumberFormatException e) {
                                request.setAttribute("error", "ID danh mục không hợp lệ!");
                                request.getRequestDispatcher("/jsp/error.jsp").forward(request, response);
                            }
                        } else {
                            request.setAttribute("error", "Yêu cầu ID danh mục!");
                            request.getRequestDispatcher("/jsp/error.jsp").forward(request, response);
                        }
                        return;
                    case "management":
                        // Get parameters
                        String searchTerm = request.getParameter("search");
                        String status = request.getParameter("status");
                        String sortBy = request.getParameter("sortBy");
                        String sortOrder = request.getParameter("sortOrder");
                        String editIdParam = request.getParameter("editId"); // <-- Thêm dòng này
                        Integer editId = null;
                        if (editIdParam != null && !editIdParam.isEmpty()) {
                            try {
                                editId = Integer.parseInt(editIdParam);
                            } catch (NumberFormatException e) {
                                editId = null;
                            }
                        }
                        int pageNum = 1;
                        int recordsPerPage = 10;
                        String pageNumStr = request.getParameter("pageNum");
                        if (pageNumStr != null) {
                            try {
                                pageNum = Integer.parseInt(pageNumStr);
                            } catch (NumberFormatException e) {
                                pageNum = 1;
                            }
                        }
                        // Get categories with search and filter
                        List<Category> allCategories;
                        if ((searchTerm != null && !searchTerm.trim().isEmpty()) || 
                            (status != null && !status.trim().isEmpty())) {
                            allCategories = categoryDAO.searchAndFilterCategories(searchTerm, status);
                        } else {
                            allCategories = categoryDAO.getCategoriesWithProductCount();
                        }
                        // Sort categories
                        if (sortBy != null && sortOrder != null) {
                            allCategories = categoryDAO.sortCategories(allCategories, sortBy, sortOrder);
                        }
                        // Pagination
                        int totalRecords = allCategories.size();
                        int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);
                        List<Category> categoriesList = new ArrayList<>();
                        int startIndex = Math.min((pageNum - 1) * recordsPerPage, totalRecords);
                        int endIndex = Math.min(startIndex + recordsPerPage, totalRecords);
                        if (startIndex < totalRecords) {
                            categoriesList = allCategories.subList(startIndex, endIndex);
                        }
                        request.setAttribute("categories", categoriesList);
                        request.setAttribute("currentPage", pageNum);
                        request.setAttribute("totalPages", totalPages);
                        request.setAttribute("search", searchTerm);
                        request.setAttribute("status", status);
                        request.setAttribute("sortBy", sortBy);
                        request.setAttribute("sortOrder", sortOrder);
                        request.setAttribute("editId", editId); // <-- Truyền editId về JSP
                        // Truyền danh mục đã xóa mềm
                        List<Category> deletedCategories = categoryDAO.getDeletedCategories();
                        request.setAttribute("deletedCategories", deletedCategories);
                        // Tổng số danh mục (kể cả đã xóa mềm)
                        int totalCategories = categoryDAO.countAllCategories();
                        request.setAttribute("totalCategories", totalCategories);
                        // Số danh mục hoạt động (có sản phẩm)
                        long activeWithProduct = categoriesList.stream().filter(c -> c.getProductCount() > 0).count();
                        request.setAttribute("activeWithProduct", activeWithProduct);
                        request.getRequestDispatcher("categoryManagement.jsp").forward(request, response);
                        return;
                    default:
                        request.setAttribute("error", "Hành động không hợp lệ!");
                        request.getRequestDispatcher("/jsp/error.jsp").forward(request, response);
                        return;
                }
            }

            List<Category> categories = categoryDAO.getAllCategories();
            int pageNum = 1;
            int recordsPerPage = 12;
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
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi cơ sở dữ liệu: " + e.getMessage());
            request.getRequestDispatcher("/jsp/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if (action != null) {
                switch (action) {
                    case "create":
                        String categoryName = request.getParameter("categoryName");
                        if (categoryName == null || categoryName.trim().isEmpty()) {
                            setCategoryManagementAttributes(request, null);
                            List<Category> deletedCategories = categoryDAO.getDeletedCategories();
                            request.setAttribute("deletedCategories", deletedCategories);
                            request.setAttribute("error", "Tên danh mục là bắt buộc!");
                            request.getRequestDispatcher("categoryManagement.jsp").forward(request, response);
                            return;
                        }
                        if (categoryName.trim().length() > 30) {
                            setCategoryManagementAttributes(request, null);
                            List<Category> deletedCategories = categoryDAO.getDeletedCategories();
                            request.setAttribute("deletedCategories", deletedCategories);
                            request.setAttribute("error", "Tên danh mục không được vượt quá 30 ký tự!");
                            request.getRequestDispatcher("categoryManagement.jsp").forward(request, response);
                            return;
                        }
                        Category newCategory = new Category();
                        newCategory.setCategoryName(categoryName.trim());
                        try {
                            boolean success = categoryDAO.createCategory(newCategory);
                            if (success) {
                                response.sendRedirect(request.getContextPath() + "/category?action=management");
                            } else {
                                setCategoryManagementAttributes(request, null);
                                List<Category> deletedCategories = categoryDAO.getDeletedCategories();
                                request.setAttribute("deletedCategories", deletedCategories);
                                request.setAttribute("error", "Tạo danh mục thất bại!");
                                request.getRequestDispatcher("categoryManagement.jsp").forward(request, response);
                            }
                        } catch (Exception e) {
                            setCategoryManagementAttributes(request, null);
                            List<Category> deletedCategories = categoryDAO.getDeletedCategories();
                            request.setAttribute("deletedCategories", deletedCategories);
                            request.setAttribute("error", e.getMessage());
                            request.getRequestDispatcher("categoryManagement.jsp").forward(request, response);
                        }
                        return;
                    case "update":
                        String idParam = request.getParameter("categoryId");
                        String updatedName = request.getParameter("categoryName");
                        if (idParam == null || updatedName == null || updatedName.trim().isEmpty()) {
                            setCategoryManagementAttributes(request, idParam);
                            List<Category> deletedCategories = categoryDAO.getDeletedCategories();
                            request.setAttribute("deletedCategories", deletedCategories);
                            request.setAttribute("error", "Dữ liệu không hợp lệ!");
                            request.getRequestDispatcher("categoryManagement.jsp").forward(request, response);
                            return;
                        }
                        if (updatedName.trim().length() > 30) {
                            setCategoryManagementAttributes(request, idParam);
                            List<Category> deletedCategories = categoryDAO.getDeletedCategories();
                            request.setAttribute("deletedCategories", deletedCategories);
                            request.setAttribute("error", "Tên danh mục không được vượt quá 30 ký tự!");
                            request.getRequestDispatcher("categoryManagement.jsp").forward(request, response);
                            return;
                        }
                        try {
                            int categoryId = Integer.parseInt(idParam);
                            Category category = new Category();
                            category.setCategoryId(categoryId);
                            category.setCategoryName(updatedName.trim());
                            boolean success = categoryDAO.updateCategory(category);
                            if (success) {
                                response.sendRedirect(request.getContextPath() + "/category?action=management");
                            } else {
                                setCategoryManagementAttributes(request, idParam);
                                List<Category> deletedCategories = categoryDAO.getDeletedCategories();
                                request.setAttribute("deletedCategories", deletedCategories);
                                request.setAttribute("error", "Cập nhật danh mục thất bại!");
                                request.getRequestDispatcher("categoryManagement.jsp").forward(request, response);
                            }
                        } catch (NumberFormatException e) {
                            setCategoryManagementAttributes(request, idParam);
                            List<Category> deletedCategories = categoryDAO.getDeletedCategories();
                            request.setAttribute("deletedCategories", deletedCategories);
                            request.setAttribute("error", "ID danh mục không hợp lệ!");
                            request.getRequestDispatcher("categoryManagement.jsp").forward(request, response);
                        } catch (Exception e) {
                            setCategoryManagementAttributes(request, idParam);
                            List<Category> deletedCategories = categoryDAO.getDeletedCategories();
                            request.setAttribute("deletedCategories", deletedCategories);
                            request.setAttribute("error", e.getMessage());
                            request.getRequestDispatcher("categoryManagement.jsp").forward(request, response);
                        }
                        return;
                    case "delete":
                        idParam = request.getParameter("id");
                        if (idParam == null || idParam.trim().isEmpty()) {
                            request.setAttribute("error", "Yêu cầu ID danh mục!");
                            request.getRequestDispatcher("categoryManagement.jsp").forward(request, response);
                            return;
                        }
                        try {
                            int categoryId = Integer.parseInt(idParam);
                            boolean success = categoryDAO.deleteCategory(categoryId);
                            if (success) {
                                response.sendRedirect(request.getContextPath() + "/category?action=management");
                            } else {
                                request.setAttribute("error", "Xóa danh mục thất bại!");
                                request.getRequestDispatcher("categoryManagement.jsp").forward(request, response);
                            }
                        } catch (NumberFormatException e) {
                            request.setAttribute("error", "ID danh mục không hợp lệ!");
                            request.getRequestDispatcher("categoryManagement.jsp").forward(request, response);
                        } catch (Exception e) {
                            request.setAttribute("error", e.getMessage());
                            request.getRequestDispatcher("categoryManagement.jsp").forward(request, response);
                        }
                        return;
                    case "bulkDelete":
                        String[] categoryIds = request.getParameterValues("categoryIds");
                        if (categoryIds == null || categoryIds.length == 0) {
                            request.setAttribute("error", "Vui lòng chọn ít nhất một danh mục để xóa!");
                            response.sendRedirect(request.getContextPath() + "/category?action=management");
                            return;
                        }
                        
                        try {
                            List<Integer> idsToDelete = new ArrayList<>();
                            for (String id : categoryIds) {
                                idsToDelete.add(Integer.parseInt(id));
                            }
                            
                            boolean success = categoryDAO.bulkDeleteCategories(idsToDelete);
                            if (success) {
                                response.sendRedirect(request.getContextPath() + "/category?action=management");
                            } else {
                                request.setAttribute("error", "Xóa danh mục thất bại!");
                                response.sendRedirect(request.getContextPath() + "/category?action=management");
                            }
                        } catch (NumberFormatException e) {
                            request.setAttribute("error", "ID danh mục không hợp lệ!");
                            response.sendRedirect(request.getContextPath() + "/category?action=management");
                        } catch (Exception e) {
                            request.setAttribute("error", e.getMessage());
                            response.sendRedirect(request.getContextPath() + "/category?action=management");
                        }
                        return;
                    case "restore":
                        idParam = request.getParameter("id");
                        if (idParam == null || idParam.trim().isEmpty()) {
                            setCategoryManagementAttributes(request, null);
                            List<Category> deletedCategories = categoryDAO.getDeletedCategories();
                            request.setAttribute("deletedCategories", deletedCategories);
                            request.setAttribute("error", "Yêu cầu ID danh mục!");
                            request.getRequestDispatcher("categoryManagement.jsp").forward(request, response);
                            return;
                        }
                        try {
                            int categoryId = Integer.parseInt(idParam);
                            boolean success = categoryDAO.restoreCategory(categoryId);
                            if (success) {
                                response.sendRedirect(request.getContextPath() + "/category?action=management");
                            } else {
                                setCategoryManagementAttributes(request, null);
                                List<Category> deletedCategories = categoryDAO.getDeletedCategories();
                                request.setAttribute("deletedCategories", deletedCategories);
                                request.setAttribute("error", "Khôi phục danh mục thất bại!");
                                request.getRequestDispatcher("categoryManagement.jsp").forward(request, response);
                            }
                        } catch (NumberFormatException e) {
                            setCategoryManagementAttributes(request, null);
                            List<Category> deletedCategories = categoryDAO.getDeletedCategories();
                            request.setAttribute("deletedCategories", deletedCategories);
                            request.setAttribute("error", "ID danh mục không hợp lệ!");
                            request.getRequestDispatcher("categoryManagement.jsp").forward(request, response);
                        } catch (Exception e) {
                            setCategoryManagementAttributes(request, null);
                            List<Category> deletedCategories = categoryDAO.getDeletedCategories();
                            request.setAttribute("deletedCategories", deletedCategories);
                            request.setAttribute("error", e.getMessage());
                            request.getRequestDispatcher("categoryManagement.jsp").forward(request, response);
                        }
                        return;
                    default:
                        request.setAttribute("error", "Hành động không hợp lệ!");
                        request.getRequestDispatcher("/jsp/error.jsp").forward(request, response);
                        return;
                }
            }

            doGet(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi cơ sở dữ liệu: " + e.getMessage());
            request.getRequestDispatcher("/jsp/error.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "CategoryServlet for handling products by category";
    }

    // Thêm hàm tiện ích để set lại dữ liệu phân trang, danh sách categories, editId
    private void setCategoryManagementAttributes(HttpServletRequest request, String editIdParam) throws ServletException {
        try {
            String searchTerm = request.getParameter("search");
            String status = request.getParameter("status");
            String sortBy = request.getParameter("sortBy");
            String sortOrder = request.getParameter("sortOrder");
            Integer editId = null;
            if (editIdParam != null && !editIdParam.isEmpty()) {
                try {
                    editId = Integer.parseInt(editIdParam);
                } catch (NumberFormatException e) {
                    editId = null;
                }
            }
            int pageNum = 1;
            int recordsPerPage = 10;
            String pageNumStr = request.getParameter("pageNum");
            if (pageNumStr != null) {
                try {
                    pageNum = Integer.parseInt(pageNumStr);
                } catch (NumberFormatException e) {
                    pageNum = 1;
                }
            }
            List<Category> allCategories;
            if ((searchTerm != null && !searchTerm.trim().isEmpty()) || 
                (status != null && !status.trim().isEmpty())) {
                allCategories = categoryDAO.searchAndFilterCategories(searchTerm, status);
            } else {
                allCategories = categoryDAO.getCategoriesWithProductCount();
            }
            if (sortBy != null && sortOrder != null) {
                allCategories = categoryDAO.sortCategories(allCategories, sortBy, sortOrder);
            }
            int totalRecords = allCategories.size();
            int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);
            List<Category> categoriesList = new ArrayList<>();
            int startIndex = Math.min((pageNum - 1) * recordsPerPage, totalRecords);
            int endIndex = Math.min(startIndex + recordsPerPage, totalRecords);
            if (startIndex < totalRecords) {
                categoriesList = allCategories.subList(startIndex, endIndex);
            }
            request.setAttribute("categories", categoriesList);
            request.setAttribute("currentPage", pageNum);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("search", searchTerm);
            request.setAttribute("status", status);
            request.setAttribute("sortBy", sortBy);
            request.setAttribute("sortOrder", sortOrder);
            request.setAttribute("editId", editId);
        } catch (Exception ex) {
            request.setAttribute("categories", new ArrayList<Category>());
            request.setAttribute("currentPage", 1);
            request.setAttribute("totalPages", 1);
            request.setAttribute("editId", null);
        }
    }
}
