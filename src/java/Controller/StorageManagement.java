/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.BouquetTemplate;
import Model.FlowerColor;
import Model.FlowerType;
import Model.RawFlower;
import Model.TemplateIngredient;
import dal.BouquetDAO;
import dal.StorageDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author PC
 */
public class StorageManagement extends HttpServlet {

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
            out.println("<title>Servlet StorageManagement</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet StorageManagement at " + request.getContextPath() + "</h1>");
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
        String action = request.getParameter("action");
        String mode = request.getParameter("mode");
        StorageDAO dao = new StorageDAO();
        BouquetDAO dao1 = new BouquetDAO();
        if (action == null) {
            action = "view";
        }
        switch (action) {
            case "add":
                List<RawFlower> RawFlowerList = dao.getAllRawFlower();
                List<BouquetTemplate> bouquetList = dao1.getAllBouquets();
                for (BouquetTemplate b : bouquetList) {
                    b.setCategoryName(dao1.getCategoryNameById(b.getTemplateId()));
                    List<TemplateIngredient> listIng = null;
                    try {
                        listIng = dao.getAllTemplateIngredient(b.getTemplateId());
                    } catch (SQLException ex) {
                        Logger.getLogger(StorageManagement.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    b.setIngredients(listIng);
                }
                List<FlowerType> FlowerType = dao.getAllFlowerType();
                List<FlowerColor> FlowerColor = dao.getAllFlowerColor();
                request.setAttribute("editMode", true);
                request.setAttribute("action", "view");
                request.setAttribute("bouquetList", bouquetList);
                request.setAttribute("TypeList", FlowerType);
                request.setAttribute("ColorList", FlowerColor);
                request.setAttribute("RawFlowerList", RawFlowerList);
                request.setAttribute("categoryList", dao1.getAllCategory());
                request.getRequestDispatcher("storageManagement.jsp")
                        .forward(request, response);
                break;
            case "addProduct":
                int id = Integer.parseInt(request.getParameter("newTemplateID"));
                String name = request.getParameter("newTemplateName");
                double price = Double.parseDouble(request.getParameter("newBasePrice"));
                int stock = Integer.parseInt(request.getParameter("newStock"));
                String[] category = request.getParameterValues("newCategory");
                if (category != null) {
                    for (int i = 0; i < category.length; i++) {
                        try {
                            int categoryId = Integer.parseInt(category[i]);
                            dao.AddTemplateByProduct(id, name, price, stock,categoryId);
                        } catch (Exception ex) {
                            Logger.getLogger(StorageManagement.class.getName()).log(Level.SEVERE, null, ex);
                        }
                    }
                }
                String[] typeIds = request.getParameterValues("typeId");
                String[] colorIds = request.getParameterValues("colorId");
                String[] quantities = request.getParameterValues("quantity");

                if (typeIds != null) {
                    for (int i = 0; i < typeIds.length; i++) {
                        try {
                            int typeId = Integer.parseInt(typeIds[i]);
                            int colorId = Integer.parseInt(colorIds[i]);
                            int qty = Integer.parseInt(quantities[i]);
                            dao.AddIngredientByProduct(id, typeId, colorId, qty);
                        } catch (Exception ex) {
                            Logger.getLogger(StorageManagement.class.getName()).log(Level.SEVERE, null, ex);
                        }
                    }
                }
                response.sendRedirect("storagemanagement?action=view");
                break;
            case "edit":
                int editId = Integer.parseInt(request.getParameter("editId"));

                break;
            case "update":
                response.sendRedirect("productmanagement?action=view");
                break;

            case "delete":

            case "view":
            default:
                request.setAttribute("editMode", false);
                List<RawFlower> all = dao.getAllRawFlower();
                List<BouquetTemplate> bouquet = dao1.getAllBouquets();
                for (BouquetTemplate b : bouquet) {
                    b.setCategoryName(dao1.getCategoryNameById(b.getTemplateId()));
                    List<TemplateIngredient> listIng = null;
                    try {
                        listIng = dao.getAllTemplateIngredient(b.getTemplateId());
                    } catch (SQLException ex) {
                        Logger.getLogger(StorageManagement.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    b.setIngredients(listIng);
                }
                request.setAttribute("bouquetList", bouquet);
                request.setAttribute("RawFlowerList", all);
                request.setAttribute("categoryList", dao1.getAllCategory());
                request.getRequestDispatcher("storageManagement.jsp")
                        .forward(request, response);
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
