package Controller;

import Model.FlowerRequest;
import dal.FlowerRequestDAO;
import dal.NotificationDAO;
import Model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.*;

public class FlowerRequestServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            User user = (User) request.getSession().getAttribute("user");
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/login.jsp");
                return;
            }
            Part filePart = request.getPart("flowerImage");
            String description = request.getParameter("description");
            String color = request.getParameter("color");
            String event = request.getParameter("event");
            String note = request.getParameter("note");
            // Kiểm tra file ảnh hợp lệ
            if (filePart == null || filePart.getSize() == 0 || !filePart.getContentType().startsWith("image/")) {
                request.setAttribute("error", "Vui lòng chọn file ảnh hợp lệ!");
                request.getRequestDispatcher("flowerRequestForm.jsp").forward(request, response);
                return;
            }
            String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
            String uploadPath = getServletContext().getRealPath("") + "images/request";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();
            filePart.write(uploadPath + File.separator + fileName);
            FlowerRequest fr = new FlowerRequest();
            fr.setCustomerId(user.getUserId());
            fr.setImageUrl("images/request/" + fileName);
            fr.setDescription(description);
            fr.setColorPreference(color);
            fr.setEventType(event);
            fr.setNote(note);
            FlowerRequestDAO dao = new FlowerRequestDAO();
            dao.insertRequest(fr);
            NotificationDAO ndao = new NotificationDAO();
            ndao.createForManager("Có yêu cầu hoa mẫu mới từ " + user.getFullName(), fr.getRequestId());
            request.setAttribute("success", "Đã gửi yêu cầu thành công!");
            request.getRequestDispatcher("flowerRequestForm.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Gửi yêu cầu thất bại!");
            request.getRequestDispatcher("flowerRequestForm.jsp").forward(request, response);
        }
    }
} 