/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import Model.BouquetTemplate;
import dal.BouquetDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author Admin
 */
@WebServlet(name = "StaffBouquetServlet", urlPatterns = {"/staffbouquetservlet"})
public class StaffBouquetServlet extends HttpServlet {

    private BouquetDAO bouquetDAO;

    @Override
    public void init() throws ServletException {
        bouquetDAO = new BouquetDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "view";

        switch (action) {
            case "add":
request.getRequestDispatcher("editBouquet.jsp").forward(request, response);
                break;

            case "edit":
                try {
                    int id = Integer.parseInt(request.getParameter("id"));
                    request.setAttribute("bouquet", bouquetDAO.getBouquetById(id));
                    request.getRequestDispatcher("editBouquet.jsp").forward(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendRedirect("staffbouquetservlet");
                }
                break;

            case "delete":
                try {
                    int deleteId = Integer.parseInt(request.getParameter("id"));
                    bouquetDAO.softDeleteBouquet(deleteId); // xóa mềm
                } catch (Exception e) {
                    e.printStackTrace();
                }
                response.sendRedirect("staffbouquetservlet");
                break;

            case "view":
            default:
                List<BouquetTemplate> list = bouquetDAO.getAllBouquets(); // chỉ lấy is_active = TRUE
                request.setAttribute("bouquetList", list);
                request.getRequestDispatcher("manageBouquets.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = request.getParameter("id") == null || request.getParameter("id").isEmpty()
                ? 0 : Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        String imageUrl = request.getParameter("imageUrl");

        BouquetTemplate bouquet = new BouquetTemplate(id, name, description, price, imageUrl);

        if (id > 0) {
            bouquetDAO.updateBouquet(bouquet);
        } else {
            bouquetDAO.addBouquet(bouquet);
        }

        response.sendRedirect("staffbouquetservlet");
    }

    @Override
    public String getServletInfo() {
        return "StaffBouquetServlet - quản lý sản phẩm cho nhân viên";
    }
}