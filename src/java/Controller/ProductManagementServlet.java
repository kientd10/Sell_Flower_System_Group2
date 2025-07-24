/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.BouquetTemplate;
import Model.Category;
import dal.BouquetDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.text.Normalizer;
import java.util.List;
import java.io.File;

/**
 *
 * @author PC
 */
@MultipartConfig
public class ProductManagementServlet extends HttpServlet {

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
            out.println("<title>Servlet ProductManagementServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductManagementServlet at " + request.getContextPath() + "</h1>");
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
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        String mode = request.getParameter("mode");
        BouquetDAO dao = new BouquetDAO();
        if (action == null) {
            action = "view";
        }
        switch (action) {

            case "edit":
                int editId = Integer.parseInt(request.getParameter("editId"));
                BouquetTemplate editingItem = dao.getBouquetById(editId);
                request.setAttribute("categoryList", dao.getAllCategory());
                request.setAttribute("editingItem", editingItem);
                request.setAttribute("editTemplateID", editId);
                request.setAttribute("editMode", true);
                request.setAttribute("action", "view");
                List<BouquetTemplate> list = dao.getAllBouquets();
                for (BouquetTemplate b : list) {
                    b.setCategoryName(dao.getCategoryNameById(b.getTemplateId()));
                }
                request.setAttribute("bouquetList", list);
                request.getRequestDispatcher("productManagement.jsp")
                        .forward(request, response);
                break;
            case "update":
                int id = Integer.parseInt(request.getParameter("templateId"));
                String name = request.getParameter("templateName");
                String desc = request.getParameter("description");
                double price = Double.parseDouble(request.getParameter("basePrice"));
                int stock = Integer.parseInt(request.getParameter("stock"));
                String imageUrl = request.getParameter("imageUrl"); // ✅ dòng thêm

                dao.updateBouquet(id, name, desc, price, imageUrl, stock); // ✅ dòng sửa
                response.sendRedirect("productmanagement?action=view");
                break;

            case "delete":
                int delId = Integer.parseInt(request.getParameter("id"));
                dao.softDeleteBouquet(delId);
                response.sendRedirect("productmanagement?action=view");
                break;
            case "view":
            default:
                int page = 1;
                int limit = 10;
                String pageParam = request.getParameter("page");
                String search = request.getParameter("search");

                if (search != null) {
                    String before = search;
                    search = Normalizer.normalize(search, Normalizer.Form.NFC); // ✅ chuẩn hóa Unicode tổ hợp
                    System.out.println("🔍 Raw input: " + before);
                    System.out.println("🔍 Normalized: " + search);
                }

                String categoryParam = request.getParameter("filterCategory");
                int filterCategoryId = -1;
                if (categoryParam != null && !categoryParam.isEmpty()) {
                    try {
                        filterCategoryId = Integer.parseInt(categoryParam);
                    } catch (NumberFormatException e) {
                        filterCategoryId = -1;
                    }
                }
                if (pageParam != null && !pageParam.isEmpty()) {
                    page = Integer.parseInt(pageParam);
                }

                int offset = (page - 1) * limit;

                List<BouquetTemplate> all;
                int totalItems;

                if (filterCategoryId != -1) {
                    System.out.println("📦 Filter by category ID: " + filterCategoryId);
                    all = dao.getBouquetsByCategoryIdPaging(filterCategoryId, offset, limit);
                    totalItems = dao.countBouquetsByCategory(filterCategoryId);
                    request.setAttribute("selectedFilterCategory", filterCategoryId);
                } else if (search != null && !search.trim().isEmpty()) {
                    System.out.println("🔎 Searching with keyword: " + search);
                    all = dao.searchBouquetTemplatesWithPaging(search, offset, limit);
                    totalItems = dao.countSearchResults(search);
                    System.out.println("📊 Found " + totalItems + " results for search = " + search);
                    request.setAttribute("search", search);
                } else {
                    System.out.println("📋 Viewing all bouquets");
                    all = dao.getAllBouquetsPaging(offset, limit);
                    totalItems = dao.countAllBouquets();
                }

                for (BouquetTemplate b : all) {
                    System.out.println("🟢 Loaded: " + b.getTemplateId() + " - " + b.getTemplateName());
                    b.setCategoryName(dao.getCategoryNameById(b.getTemplateId()));
                }

                int totalPages = (int) Math.ceil((double) totalItems / limit);

                request.setAttribute("bouquetList", all);
                request.setAttribute("categoryList", dao.getAllCategory());
                request.setAttribute("currentPage", page);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("editMode", false);
                request.setAttribute("selectedFilterCategory", filterCategoryId);
                request.getRequestDispatcher("productManagement.jsp").forward(request, response);
                break;
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
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect("productmanagement?action=view");
            return;
        }

        BouquetDAO dao = new BouquetDAO();
        switch (action) {
            case "save": {
                try {
                    // Get and validate all required fields
                    String idParam = request.getParameter("templateId");
                    String name = request.getParameter("templateName");
                    String desc = request.getParameter("description");
                    String basePriceStr = request.getParameter("basePrice");
                    String stockStr = request.getParameter("stock");
                    String categoryIdStr = request.getParameter("categoryId");
                    
                    // Validate name
                    if (name == null || name.trim().isEmpty()) {
                        request.setAttribute("error", "Tên sản phẩm không được để trống.");
                        request.getRequestDispatcher("productManagement.jsp").forward(request, response);
                        return;
                    }
                    
                    // Validate price
                    double price = 0;
                    try {
                        price = Double.parseDouble(basePriceStr);
                        if (price <= 0) {
                            request.setAttribute("error", "Giá sản phẩm phải lớn hơn 0.");
                            request.getRequestDispatcher("productManagement.jsp").forward(request, response);
                            return;
                        }
                    } catch (NumberFormatException e) {
                        request.setAttribute("error", "Giá sản phẩm không hợp lệ.");
                        request.getRequestDispatcher("productManagement.jsp").forward(request, response);
                        return;
                    }
                    
                    // Validate category
                    int categoryId = 0;
                    try {
                        categoryId = Integer.parseInt(categoryIdStr);
                        if (categoryId <= 0) {
                            request.setAttribute("error", "Bạn phải chọn danh mục sản phẩm.");
                            request.getRequestDispatcher("productManagement.jsp").forward(request, response);
                            return;
                        }
                    } catch (NumberFormatException e) {
                        request.setAttribute("error", "Danh mục sản phẩm không hợp lệ.");
                        request.getRequestDispatcher("productManagement.jsp").forward(request, response);
                        return;
                    }
                    
                    // Validate stock
                    int stock = 0;
                    try {
                        stock = Integer.parseInt(stockStr);
                        if (stock < 0) {
                            request.setAttribute("error", "Số lượng tồn kho không được âm.");
                            request.getRequestDispatcher("productManagement.jsp").forward(request, response);
                            return;
                        }
                    } catch (NumberFormatException e) {
                        stock = 0; // Default to 0 if invalid
                    }
                    
                    // Validate user session
                    Model.User user = (Model.User) request.getSession().getAttribute("user");
                    if (user == null) {
                        request.setAttribute("error", "Bạn phải đăng nhập để thêm/sửa sản phẩm.");
                        request.getRequestDispatcher("productManagement.jsp").forward(request, response);
                        return;
                    }
                    
                    // Handle file upload
                    String imageUrl = "";
                    Part imagePart = request.getPart("productImage");
                    if (imagePart != null && imagePart.getSize() > 0) {
                        if (!imagePart.getContentType().startsWith("image/")) {
                            request.setAttribute("error", "File phải là ảnh (jpg, png, gif).");
                            request.getRequestDispatcher("productManagement.jsp").forward(request, response);
                            return;
                        }
                        
                        String fileName = System.currentTimeMillis() + "_" + imagePart.getSubmittedFileName();
                        String uploadPath = getServletContext().getRealPath("") + "images" + File.separator + "products";
                        File uploadDir = new File(uploadPath);
                        if (!uploadDir.exists()) {
                            uploadDir.mkdirs();
                        }
                        
                        imagePart.write(uploadPath + File.separator + fileName);
                        imageUrl = "images/products/" + fileName;
                    } else if (idParam != null && !idParam.trim().isEmpty()) {
                        // If editing and no new image uploaded, keep existing image
                        try {
                            int id = Integer.parseInt(idParam);
                            BouquetTemplate existing = dao.getBouquetById(id);
                            if (existing != null && existing.getImageUrl() != null && !existing.getImageUrl().trim().isEmpty()) {
                                imageUrl = existing.getImageUrl();
                            } else {
                                request.setAttribute("error", "Không tìm thấy ảnh sản phẩm cũ.");
                                request.getRequestDispatcher("productManagement.jsp").forward(request, response);
                                return;
                            }
                        } catch (NumberFormatException e) {
                            request.setAttribute("error", "ID sản phẩm không hợp lệ.");
                            request.getRequestDispatcher("productManagement.jsp").forward(request, response);
                            return;
                        }
                    } else {
                        request.setAttribute("error", "Bạn phải chọn ảnh sản phẩm.");
                        request.getRequestDispatcher("productManagement.jsp").forward(request, response);
                        return;
                    }
                    
                    // Process the save/update
                    if (idParam == null || idParam.trim().isEmpty()) {
                        // Add new product
                        BouquetTemplate newTemplate = new BouquetTemplate();
                        newTemplate.setTemplateName(name);
                        newTemplate.setDescription(desc != null ? desc : "");
                        newTemplate.setImageUrl(imageUrl);
                        newTemplate.setBasePrice(price);
                        newTemplate.setCategoryId(categoryId);
                        newTemplate.setCreatedBy(user.getUserId());
                        newTemplate.setStock(stock);
                        dao.addBouquet(newTemplate);
                    } else {
                        // Update existing product
                        try {
                            int id = Integer.parseInt(idParam);
                            dao.updateBouquetFull(id, name, desc != null ? desc : "", price, imageUrl, stock, categoryId);
                        } catch (NumberFormatException e) {
                            request.setAttribute("error", "ID sản phẩm không hợp lệ.");
                            request.getRequestDispatcher("productManagement.jsp").forward(request, response);
                            return;
                        }
                    }
                    
                    response.sendRedirect("productmanagement?action=view");
                    
                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
                    request.getRequestDispatcher("productManagement.jsp").forward(request, response);
                }
                break;
            }
            default:
                response.sendRedirect("productmanagement?action=view");
        }
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
