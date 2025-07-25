package Controller;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
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
@WebServlet(urlPatterns = {"/executepaymentservlet"})
public class ExecutePaymentServlet extends HttpServlet {

    private static final String CLIENT_ID = "AQVm8jRLqJ-HxX2a4hSE_Go8umQXyT2NSD3x3NHSLQkK2yY9_0ugWZKVALYbjbxM_tEFAVM351P8B1hn";
    private static final String CLIENT_SECRET = "EAlFh3_UlerbXCT64x0wKnWkEZNXUriN1y9f2s3alR3NpsJV7qA8r_AzGuS1SpNLOW_xb-nKOQSuMDtA";

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
            out.println("<title>Servlet ExecutePaymentServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ExecutePaymentServlet at " + request.getContextPath() + "</h1>");
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
        System.out.println("==> ExecutePaymentServlet được gọi");

        try {
            String paymentId = request.getParameter("paymentId");
            String payerId = request.getParameter("PayerID");

            // PayPal API context
            Map<String, String> configMap = new HashMap<>();
            configMap.put("mode", "sandbox");

            OAuthTokenCredential tokenCredential = new OAuthTokenCredential(CLIENT_ID, CLIENT_SECRET, configMap);
            APIContext apiContext = new APIContext(tokenCredential.getAccessToken());
            apiContext.setConfigurationMap(configMap);

            Payment payment = new Payment();
            payment.setId(paymentId);

            PaymentExecution paymentExecute = new PaymentExecution();
            paymentExecute.setPayerId(payerId);

            Payment executedPayment = payment.execute(apiContext, paymentExecute);

            if ("approved".equalsIgnoreCase(executedPayment.getState())) {
                // Lấy thông tin thanh toán
                String transactionId = executedPayment.getTransactions().get(0).getRelatedResources().get(0).getSale().getId();
                double amount = Double.parseDouble(executedPayment.getTransactions().get(0).getAmount().getTotal());

                // Lấy user và orderId từ session
                HttpSession session = request.getSession();
                Model.User user = (Model.User) session.getAttribute("user");
                int userId = user.getUserId();

                Integer orderId = (Integer) session.getAttribute("orderId");

                if (orderId == null) {
                    System.out.println("❌ orderId bị null trong session!");
                    request.getRequestDispatcher("cancel.jsp").forward(request, response);
                    return;
                }

                // ✅ Chỉ insert thanh toán (không insert lại đơn hàng)
                dal.PaymentDAO paymentDao = new dal.PaymentDAO();
                paymentDao.insertPaypalPayment(orderId, transactionId, amount, "Success");
                System.out.println("==> Đã insert thanh toán thành công vào bảng payments");

                // Xóa giỏ hàng
                session.removeAttribute("cart");

                // Gửi dữ liệu tới success.jsp
                request.setAttribute("transactionId", transactionId);
                request.setAttribute("amount", amount);
                request.setAttribute("orderId", orderId);
                request.getRequestDispatcher("success.jsp").forward(request, response);

            } else {
                request.getRequestDispatcher("cancel.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi xác nhận thanh toán: " + e.getMessage());
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
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
    }

    @Override
    public String getServletInfo() {
        return "Xử lý xác nhận thanh toán PayPal và ghi nhận giao dịch";
    }
}
