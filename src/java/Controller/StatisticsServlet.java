/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.StatisticsModel;
import dal.StatisticsDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Calendar;
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
 * @author tuanh
 */
@WebServlet(name = "StatisticsServlet", urlPatterns = {"/statistics"})
public class StatisticsServlet extends HttpServlet {

    private StatisticsDAO statisticsDAO = new StatisticsDAO();

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
            out.println("<title>Servlet StatisticsServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet StatisticsServlet at " + request.getContextPath() + "</h1>");
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
        try {
            // Get current date (July 15, 2025)
            Calendar cal = Calendar.getInstance();
            int day = cal.get(Calendar.DAY_OF_MONTH);
            int month = cal.get(Calendar.MONTH) + 1; // Month is 0-based, so add 1
            int year = cal.get(Calendar.YEAR);

            // Get parameters for custom date range (if provided)
            String dayParam = request.getParameter("day");
            String monthParam = request.getParameter("month");
            String yearParam = request.getParameter("year");
            String viewType = request.getParameter("viewType"); // daily, monthly, yearly

            if (dayParam != null && !dayParam.isEmpty()) {
                day = Integer.parseInt(dayParam);
            }
            if (monthParam != null && monthParam.matches("\\d+")) {
                int parsedMonth = Integer.parseInt(monthParam);
                if (parsedMonth >= 1 && parsedMonth <= 12) {
                    month = parsedMonth;
                }
            }   
            if (yearParam != null && !yearParam.isEmpty()) {
                year = Integer.parseInt(yearParam);
            }
            if (viewType == null || viewType.isEmpty()) {
                viewType = "monthly";
            }

            StatisticsModel stats;
            if ("daily".equals(viewType)) {
                // Daily statistics
                double dailyRevenue = statisticsDAO.getDailyRevenue(day, month, year);
                int dailyOrderCount = statisticsDAO.getDailyOrderCount(day, month, year);
                stats = new StatisticsModel(dailyRevenue, dailyOrderCount);
            } else if ("yearly".equals(viewType)) {
                // Yearly statistics
                double yearlyRevenue = statisticsDAO.getYearlyRevenue(year);
                int yearlyOrderCount = statisticsDAO.getYearlyOrderCount(year);
                stats = new StatisticsModel(yearlyRevenue, yearlyOrderCount);
            } else {
                // Monthly statistics (default)
                double monthlyRevenue = statisticsDAO.getMonthlyRevenue(month, year);
                int monthlyOrderCount = statisticsDAO.getMonthlyOrderCount(month, year);
                stats = new StatisticsModel(monthlyRevenue, monthlyOrderCount);
            }

            // Get data for chart
            List<Double> monthlyRevenues = statisticsDAO.getMonthlyRevenueForChart(year);

            // Set attributes for JSP
            request.setAttribute("stats", stats);
            request.setAttribute("day", day);
            request.setAttribute("month", month);
            request.setAttribute("year", year);
            request.setAttribute("viewType", viewType);
            request.setAttribute("monthlyRevenues", monthlyRevenues);

            // Forward to management.jsp
            request.getRequestDispatcher("/management.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
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
