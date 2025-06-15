/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.Employee;
import java.sql.SQLException;
import dal.DBcontext;
import dal.EmployeeDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.util.Date;

/**
 *
 * @author tuanh
 */
@WebServlet(name = "EmployeeServlet", urlPatterns = {"/employee"})
public class EmployeeServlet extends HttpServlet {

    private EmployeeDAO employeeDAO;

    @Override

    public void init() throws ServletException {
        employeeDAO = new EmployeeDAO();
    }

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
            out.println("<title>Servlet EmployeeServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EmployeeServlet at " + request.getContextPath() + "</h1>");
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
        String action = request.getPathInfo();
        try {
            switch (action) {
                case "/list":
                    request.setAttribute("employees", employeeDAO.getAllEmployees());
                    request.getRequestDispatcher("/management.jsp?page=staff-management.jsp").forward(request, response);
                    break;
                case "/add":
                    request.getRequestDispatcher("/add-staff.jsp").forward(request, response);
                    break;
                case "/edit":
                    String editId = request.getParameter("id");
                    System.out.println("Edit ID received: " + editId); // Debug
                    if (editId != null && !editId.trim().isEmpty()) {
                        try {
                            int id = Integer.parseInt(editId);
                            Employee employee = employeeDAO.getEmployeeById(id);
                            if (employee != null) {
                                request.setAttribute("employee", employee);
                                request.getRequestDispatcher("/edit-staff.jsp").forward(request, response);
                            } else {
                                response.sendRedirect(request.getContextPath() + "/employee/list?error=employee_not_found");
                            }
                        } catch (NumberFormatException e) {
                            response.sendRedirect(request.getContextPath() + "/employee/list?error=invalid_id");
                        }
                    } else {
                        response.sendRedirect(request.getContextPath() + "/employee/list?error=no_id");
                    }
                    break;
                case "/delete":
                    String deleteId = request.getParameter("id");
                    System.out.println("Delete ID received: " + deleteId); // Debug
                    if (deleteId != null && !deleteId.trim().isEmpty()) {
                        try {
                            int id = Integer.parseInt(deleteId);
                            employeeDAO.deleteEmployee(id);
                            response.sendRedirect(request.getContextPath() + "/employee/list");
                        } catch (NumberFormatException e) {
                            response.sendRedirect(request.getContextPath() + "/employee/list?error=invalid_id");
                        }
                    } else {
                        response.sendRedirect(request.getContextPath() + "/employee/list?error=no_id");
                    }
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException("Database error: " + e.getMessage(), e);
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
