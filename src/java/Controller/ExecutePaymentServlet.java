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
        System.out.println("==> Servlet đã được gọi");
        try {
            String paymentId = request.getParameter("paymentId");
            String payerId = request.getParameter("PayerID");

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
                // Lấy thông tin thanh toán từ PayPal
                String transactionId = executedPayment.getTransactions().get(0).getRelatedResources().get(0).getSale().getId();
                double amount = Double.parseDouble(executedPayment.getTransactions().get(0).getAmount().getTotal());

                // Lấy user & cart từ session
                HttpSession session = request.getSession();
                Model.User user = (Model.User) session.getAttribute("user"); // thay đổi nếu bạn dùng tên khác
                int userId = user.getUserId();
                // 👇 THÊM DÒNG NÀY để kiểm tra giỏ hàng còn hay không
Object cartObj = session.getAttribute("cart");
System.out.println("==> cart trong session: " + cartObj);
                List<Model.ShoppingCart> cartItems = (List<Model.ShoppingCart>) session.getAttribute("cart");
System.out.println("==> cartItems size: " + (cartItems != null ? cartItems.size() : "null"));

                // Tạo đơn hàng
                dal.OrderDAO orderDao = new dal.OrderDAO();
                int orderId = orderDao.insertOrder(userId, cartItems, amount);
                System.out.println("==> Đã insert đơn hàng với orderId: " + orderId);

                // Lưu giao dịch PayPal vào bảng payments
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
