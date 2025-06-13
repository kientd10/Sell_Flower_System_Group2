/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.paypal.api.payments.*;
import com.paypal.base.rest.*;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.*;
/**
 *
 * @author Admin
 */
@WebServlet(name="CreatePaymentServlet", urlPatterns={"/createpaymentservlet"})
public class CreatePaymentServlet extends HttpServlet {
private static final String CLIENT_ID = "Ab0JTQVS8jxSMPYwnh0q4mteBJJcuVF6CyjtnCUD5BaoigOzca7cc9drbkVMngu_-2OFJymF2ZL4mAkn";
private static final String CLIENT_SECRET = "EEK8ktGc8VoewI02nk2AWsQuWl7ztKENoR7Jyxf7-opB2pbldlIbei5PXEjRxe4JFghDFe7Fvmr2zQJ8";
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
            out.println("<title>Servlet CreatePaymentServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CreatePaymentServlet at " + request.getContextPath () + "</h1>");
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
        try {
            APIContext apiContext = new APIContext(
                    new OAuthTokenCredential(CLIENT_ID, CLIENT_SECRET).getAccessToken());
            apiContext.setConfigurationMap(new HashMap<String, String>() {{
                put("mode", "sandbox");
            }});

            Amount amount = new Amount();
            amount.setCurrency("USD");
            amount.setTotal("10.00");

            Transaction transaction = new Transaction();
            transaction.setAmount(amount);
            transaction.setDescription("Thanh toán đơn hàng hoa");

            Payer payer = new Payer();
            payer.setPaymentMethod("paypal");

            RedirectUrls redirectUrls = new RedirectUrls();
            redirectUrls.setCancelUrl("http://localhost:8080/FlowerSystem/cancel.jsp");
            redirectUrls.setReturnUrl("http://localhost:8080/FlowerSystem/execute-payment");

            Payment payment = new Payment();
            payment.setIntent("sale");
            payment.setPayer(payer);
            payment.setRedirectUrls(redirectUrls);
            payment.setTransactions(Collections.singletonList(transaction));

            Payment createdPayment = payment.create(apiContext);

            for (Links link : createdPayment.getLinks()) {
                if (link.getRel().equals("approval_url")) {
                    response.sendRedirect(link.getHref());
                    return;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi tạo thanh toán: " + e.getMessage());
        }
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
        processRequest(request, response);
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
