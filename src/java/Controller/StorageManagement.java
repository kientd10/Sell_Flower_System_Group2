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
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;

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
        StorageDAO dao = new StorageDAO();
        BouquetDAO dao1 = new BouquetDAO();
        List<FlowerColor> listColor = dao1.listColor();
        List<FlowerType> listType = dao.getAllFlowerType();
        List<BouquetTemplate> bouquet3 = dao1.getAllBouquets();
            List<BouquetTemplate> bouquet4 = getCategory_Name(bouquet3);
        request.setAttribute("productList", bouquet4);
        request.setAttribute("flowerNameList", listType);
        request.setAttribute("colorList", listColor);
        if (action.equals("view")) {
            List<RawFlower> rawFlowerList = dao.getAllRawFlower();
            //List<RawFlower> RawFlowerList = paginate(rawFlowerList, request);
            List<BouquetTemplate> bouquet1 = dao1.getAllBouquets();
            List<BouquetTemplate> bouquet = getCategory_Name(bouquet1);
            List<BouquetTemplate> bouquet2 = paginate1(bouquet, request);
            request.setAttribute("bouquetList", bouquet2);
            request.setAttribute("RawFlowerList", rawFlowerList);
            request.getRequestDispatcher("storageManagement.jsp").forward(request, response);
            return;
        }
        
        if(action.equals("updateRawflower")){
            String FlowerID = request.getParameter("rawflowerId");
            String typeID = request.getParameter("typeId");
            String colorID = request.getParameter("colorId");
            String quantity = request.getParameter("quantity");
            String supplierName = request.getParameter("supplierName");
            String unitPrice = request.getParameter("unitPrice");
            String importDate = request.getParameter("importDate");
            String expiryDate = request.getParameter("expiryDate");
            String notes = request.getParameter("notes");
            RawFlower rf = new RawFlower();
            rf.setRawFlowerId(Integer.parseInt(FlowerID));
            rf.setColorId(Integer.parseInt(colorID));
            rf.setQuantity(Integer.parseInt(quantity));
            rf.setSupplierName(supplierName);
            rf.setUnitPrice(Double.parseDouble(unitPrice));
            rf.setImportDate(java.sql.Date.valueOf(importDate));
            rf.setExpiryDate(java.sql.Date.valueOf(expiryDate));
            rf.setTypeId(Integer.parseInt(typeID));
            rf.setNotes(notes);
            dao.UpdateRawFlower(rf);
            response.sendRedirect("storagemanagement?action=view");
            return;
        }
        
        if(action.equals("deleteRawflower")){
            String id = request.getParameter("id");
            int ID = Integer.parseInt(id);
            dao.deleteRawflower(ID);
            response.sendRedirect("storagemanagement?action=view");
            return;
        }
        
        if(action.equals("addRawflower")){
            String typeID = request.getParameter("typeId");
            String colorID = request.getParameter("colorId");
            String quantity = request.getParameter("quantity");
            String supplierName = request.getParameter("supplierName");
            String unitPrice = request.getParameter("unitPrice");
            String importDate = request.getParameter("importDate");
            String expiryDate = request.getParameter("expiryDate");
            String notes = request.getParameter("notes");
            RawFlower rf = new RawFlower();
            rf.setColorId(Integer.parseInt(colorID));
            rf.setQuantity(Integer.parseInt(quantity));
            rf.setSupplierName(supplierName);
            rf.setUnitPrice(Double.parseDouble(unitPrice));
            rf.setImportDate(java.sql.Date.valueOf(importDate));
            rf.setExpiryDate(java.sql.Date.valueOf(expiryDate));
            rf.setTypeId(Integer.parseInt(typeID));
            rf.setNotes(notes);
            dao.addRawflower(rf);
            response.sendRedirect("storagemanagement?action=view");
            return;
        }
        if(action.equals("addProduct")){
            String templateID = request.getParameter("templateId");
            String quantity = request.getParameter("quantity");
            BouquetTemplate bq = new BouquetTemplate();
            bq.setTemplateId(Integer.parseInt(templateID));
            bq.setStock(Integer.parseInt(quantity));
            dao.updateBouquet(bq);
            List<TemplateIngredient> listIng= dao.getIngredientsByTemplateId(Integer.parseInt(templateID));
            response.sendRedirect("storagemanagement?action=view");
            return;
        }

    }
    
    
    private List<BouquetTemplate> getCategory_Name(List<BouquetTemplate> list){
        StorageDAO dao = new StorageDAO();
        BouquetDAO dao1 = new BouquetDAO();
        for (BouquetTemplate b : list) {
                b.setCategoryName(dao1.getCategoryNameById(b.getTemplateId()));
                List<TemplateIngredient> listIng = null;
                try {
                    listIng = dao.getAllTemplateIngredient(b.getTemplateId());
                } catch (SQLException ex) {
                    Logger.getLogger(StorageManagement.class.getName()).log(Level.SEVERE, null, ex);
                }
                b.setIngredients(listIng);
            }
        return list;
    }

    private List<RawFlower> paginate(List<RawFlower> rawflower, HttpServletRequest request) {
        int pageSize = 5;
        int size = rawflower.size();
        int numPages = (size % pageSize == 0) ? (size / pageSize) : (size / pageSize) + 1;
        String xpage = request.getParameter("page");
        int page = 1;
        if (xpage != null) {
            page = Integer.parseInt(xpage);
        } 

        int start = (page - 1) * pageSize;
        int end = Math.min(page * pageSize, size);
        request.setAttribute("page", page);
        request.setAttribute("num", numPages);

        return rawflower.subList(start, end);
    }

    private List<BouquetTemplate> paginate1(List<BouquetTemplate> bouquet, HttpServletRequest request) {
        int pageSize = 5;
        int size = bouquet.size();
        int numPages = (size % pageSize == 0) ? (size / pageSize) : (size / pageSize) + 1;
        String xpage = request.getParameter("page1");
        int page = 1;
        if (xpage != null) {
            page = Integer.parseInt(xpage);
        }
        
        


        int start = (page - 1) * pageSize;
        int end = Math.min(page * pageSize, size);
        request.setAttribute("page1", page);
        request.setAttribute("num1", numPages);

        return bouquet.subList(start, end);
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
