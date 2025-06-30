

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
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ADMIN
 */
@WebServlet(name="InvoiceManagement", urlPatterns={"/InvoiceManagement"})
public class InvoiceManagement extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<h1>Servlet InvoiceManagement at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
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
            List<Invoice> ListInvoice = new  ArrayList<>();
            dal.PaymentDAO paymentDao = new PaymentDAO();
            //in ra list invoice
            if(action.equals("displayAll")){
                ListInvoice = paymentDao.DisplayInvoice();
                int page, numperpage = 5;
            int size = ListInvoice.size();
            int num = (size % 5 == 0 ? (size / 5) : ((size / 5)) + 1);//number of pages
            String xpage = request.getParameter("page");//selected page
            if (xpage == null) {
                page = 1;
            } else {
                page = Integer.parseInt(xpage);
            }
            int start, end;
            start = (page - 1) * numperpage;
            end = Math.min(page * numperpage, size);
            List<Invoice> listInvoice = paymentDao.getListByPage(ListInvoice, start, end);
                request.setAttribute("listInvoice", listInvoice);
                request.setAttribute("page", page);
            request.setAttribute("num", num);
                request.getRequestDispatcher("invoiceManagement.jsp").forward(request, response);
                return;
            }
           
            //filter
            if(action.equals("filterAll")){
                String date =  request.getParameter("date");
                String price = request.getParameter("priceRange");
                
                ListInvoice = paymentDao.FilterInvoice(date, price);
//                int page, numperpage = 5;
//            int size = ListInvoice.size();
//            int num = (size % 5 == 0 ? (size / 5) : ((size / 5)) + 1);//number of pages
//            String xpage = request.getParameter("page");//selected page
//            if (xpage == null) {
//                page = 1;
//            } else {
//                page = Integer.parseInt(xpage);
//            }
//            int start, end;
//            start = (page - 1) * numperpage;
//            end = Math.min(page * numperpage, size);
//                List<Invoice> listInvoice = paymentDao.getListByPage(ListInvoice, start, end);
                request.setAttribute("listInvoice", ListInvoice);
                request.setAttribute("selectedRange", date);
                request.setAttribute("selectedPrice", price);
//                request.setAttribute("page", page);
//            request.setAttribute("num", num);
                request.getRequestDispatcher("invoiceManagement.jsp").forward(request, response);
                return;
            }
            
            //search
            if(action.equals("Search")){
                String search =  request.getParameter("value");
                ListInvoice = paymentDao.Search(search);
//                int page, numperpage = 5;
//            int size = ListInvoice.size();
//            int num = (size % 5 == 0 ? (size / 5) : ((size / 5)) + 1);//number of pages
//            String xpage = request.getParameter("page");//selected page
//            if (xpage == null) {
//                page = 1;
//            } else {
//                page = Integer.parseInt(xpage);
//            }
//            int start, end;
//            start = (page - 1) * numperpage;
//            end = Math.min(page * numperpage, size);
//                List<Invoice> listInvoice = paymentDao.getListByPage(ListInvoice, start, end);
                request.setAttribute("listInvoice", ListInvoice);
//                request.setAttribute("page", page);
//            request.setAttribute("num", num);
                request.getRequestDispatcher("invoiceManagement.jsp").forward(request, response);
                return;
            }
            
            

    }

    //in ra excel file
    public void ExportWord(List<Invoice> list ,String filePath){
        
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}


