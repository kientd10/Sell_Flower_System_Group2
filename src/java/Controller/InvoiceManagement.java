package Controller;

import Model.Invoice;
import dal.PaymentDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "InvoiceManagement", urlPatterns = {"/InvoiceManagement"})
public class InvoiceManagement extends HttpServlet {

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
            out.println("<title>Servlet InvoiceManagement</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet InvoiceManagement at " + request.getContextPath() + "</h1>");
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
        doPost(request, response);
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
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");
        List<Invoice> ListInvoice = new ArrayList<>();
        dal.PaymentDAO paymentDao = new PaymentDAO();
        List<Invoice> listInvoices = paymentDao.DisplayInvoice();

        long countToday = listInvoices.stream()
                .filter(invoice -> {
                    if (invoice.getDate() == null) {
                        return false;
                    }
                    LocalDate createdDate = invoice.getDate().toLocalDate(); // ✅ Sửa tại đây
                    return createdDate.equals(LocalDate.now());
                })
                .count();

        request.setAttribute("listInvoices", listInvoices);
        request.setAttribute("countToday", countToday);

        //in ra list invoice
        if (action.equals("displayAll")) {
            ListInvoice = paymentDao.DisplayInvoice();
            List<Invoice> listInvoice = paginate(ListInvoice, request);

            request.setAttribute("listInvoice", listInvoice);
            request.getRequestDispatcher("invoiceManagement.jsp").forward(request, response);
            return;
        }

        //filter
        if (action.equals("filterAll")) {
            String date = request.getParameter("date");
            String price = request.getParameter("priceRange");
            String sortprice = request.getParameter("sortPrice");

            ListInvoice = paymentDao.FilterInvoice(date, price,sortprice);
            List<Invoice> listInvoice = paginate(ListInvoice, request);

            request.setAttribute("listInvoice", listInvoice);
            request.setAttribute("selectedRange", date);
            request.setAttribute("selectedPrice", price);
            request.setAttribute("selectedSort", sortprice);
            request.getRequestDispatcher("invoiceManagement.jsp").forward(request, response);
            return;
        }

        //search
        if (action.equals("Search")) {
            String search = request.getParameter("value");
            if (search == null || search.trim().isEmpty()) {
                search = "%";
            } else {
                search = "%" + search + "%";
            }

            ListInvoice = paymentDao.Search(search);
            List<Invoice> listInvoice = paginate(ListInvoice, request);

            request.setAttribute("listInvoice", listInvoice);
            request.getRequestDispatcher("invoiceManagement.jsp").forward(request, response);
            return;
        }

    }

    //in ra excel file
    private List<Invoice> paginate(List<Invoice> invoices, HttpServletRequest request) {
        int pageSize = 5;
        int size = invoices.size();
        int numPages = (size % pageSize == 0) ? (size / pageSize) : (size / pageSize) + 1;
        String xpage = request.getParameter("page");
        if (xpage != null) {
            xpage = xpage.trim();
        } else {
            xpage = xpage;
        }

        int page = (xpage == null) ? 1 : Integer.parseInt(xpage);

        int start = (page - 1) * pageSize;
        int end = Math.min(page * pageSize, size);

        request.setAttribute("page", page);
        request.setAttribute("num", numPages);

        return invoices.subList(start, end);
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
