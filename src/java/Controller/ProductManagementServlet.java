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
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author PC
 */
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
        String action = request.getParameter("action");
        String mode = request.getParameter("mode");
        BouquetDAO dao = new BouquetDAO();
        if (action == null) {
            action = "view";
        }
        switch (action) {
            case "add":

            case "management":

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
                request.setAttribute("categoryList", dao.getAllCategory());
                dao.updateBouquet(id, name, desc, price, name, stock);
                response.sendRedirect("productmanagement?action=view");
                break;
                
            case "delete":

            case "view":
            default:
                request.setAttribute("editMode", false);
                List<BouquetTemplate> all = dao.getAllBouquets();
                for (BouquetTemplate b : all) {
                    b.setCategoryName(dao.getCategoryNameById(b.getTemplateId()));
                }
                request.setAttribute("bouquetList", all);
                request.setAttribute("categoryList", dao.getAllCategory());
                request.getRequestDispatcher("productManagement.jsp")
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
