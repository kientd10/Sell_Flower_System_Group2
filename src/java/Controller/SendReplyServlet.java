package Controller;

import Model.FlowerRequest;
import dal.FlowerRequestDAO;
import dal.NotificationDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.*;

public class SendReplyServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int requestId = Integer.parseInt(request.getParameter("requestId"));
            String shopReply = request.getParameter("shopReply");
            Part sampleImagePart = request.getPart("sampleImage");

            // Kiểm tra file ảnh hợp lệ
            if (sampleImagePart == null || sampleImagePart.getSize() == 0 || !sampleImagePart.getContentType().startsWith("image/")) {
                request.setAttribute("error", "Vui lòng chọn file ảnh hợp lệ!");
                FlowerRequestDAO dao = new FlowerRequestDAO();
                FlowerRequest fr = dao.getRequestById(requestId);
                request.setAttribute("flowerRequest", fr);
                request.getRequestDispatcher("viewRequestDetail.jsp").forward(request, response);
                return;
            }

            // Lưu ảnh mẫu vào images/response/
            String fileName = System.currentTimeMillis() + "_" + sampleImagePart.getSubmittedFileName();
            String uploadPath = getServletContext().getRealPath("") + "images/response";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();
            sampleImagePart.write(uploadPath + File.separator + fileName);

            // Cập nhật yêu cầu với ảnh mẫu, lời nhắn và trạng thái
            FlowerRequestDAO dao = new FlowerRequestDAO();
            dao.updateShopReply(requestId, "images/response/" + fileName, shopReply);

            // Tạo notification cho khách hàng
            FlowerRequest fr = dao.getRequestById(requestId);
            NotificationDAO ndao = new NotificationDAO();
            ndao.create(fr.getCustomerId(), "Shop đã phản hồi yêu cầu hoa mẫu của bạn!", requestId);

            request.setAttribute("success", "Phản hồi thành công!");
            request.setAttribute("flowerRequest", fr);
            request.getRequestDispatcher("viewRequestDetail.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            int requestId = Integer.parseInt(request.getParameter("requestId"));
            try {
                FlowerRequestDAO dao = new FlowerRequestDAO();
                FlowerRequest fr = dao.getRequestById(requestId);
                request.setAttribute("error", "Phản hồi thất bại!");
                request.setAttribute("flowerRequest", fr);
                request.getRequestDispatcher("viewRequestDetail.jsp").forward(request, response);
            } catch (Exception ex) {
                ex.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/notificationManagement?error=Phản hồi thất bại!");
            }
        }
    }
} 