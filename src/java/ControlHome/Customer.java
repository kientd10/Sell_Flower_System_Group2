/*customer
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package ControlHome;

import DAO.CustomerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "Customer", urlPatterns = {"/Customer"})
public class Customer extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            response.setCharacterEncoding("UTF-8");
            request.setCharacterEncoding("UTF-8");
            response.setContentType("text/html;charset=UTF-8");
            String action = request.getParameter("action");
            CustomerDAO dao = new CustomerDAO();

            //Log in
            
            if (action.equals("signin")) {
                String email = request.getParameter("email");
                String pass = request.getParameter("password");
                String remember = request.getParameter("remember");
                Entity.Customer a = dao.Signin(email, pass);
                if (a == null) {
                    request.setAttribute("error", "Account is not exist!");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                } else {
                    HttpSession session = request.getSession();
                    session.setAttribute("user", a);
                    Cookie Email = new Cookie("email", email);
                    Cookie Pass = new Cookie("password", pass);
                    Cookie Remember = new Cookie("remember", remember);
                    if (remember != null) {
                        Email.setMaxAge(60 * 60 * 24 * 30);
                        Pass.setMaxAge(60 * 60 * 24 * 3);
                        Remember.setMaxAge(60 * 60 * 24 * 30);
                    } else {
                        Email.setMaxAge(0);
                        Pass.setMaxAge(0);
                        Remember.setMaxAge(0);
                    }
                    response.addCookie(Email);
                    response.addCookie(Pass);
                    response.addCookie(Remember);
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                }

            }

            //Log out
            if (action.equals("logout")) {
                HttpSession session = request.getSession();
                session.removeAttribute("user");
                session.invalidate();
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

            //Sign up
            if (action.equals("signup")) {
                String name = request.getParameter("name");
                String email = request.getParameter("Email");
                String pass = request.getParameter("Password");
                String cfPass = request.getParameter("CfPassword");
                String fullname = request.getParameter("fullname");
                String phone = request.getParameter("phone");
                String address = request.getParameter("address");
                String checkemail = dao.checkEmail(email.trim());
                String checkusername = dao.checkName(name);
                if (checkusername == null) {
                    if (checkemail == null) {
                        if (pass.equals(cfPass)) {
                            request.setAttribute("done", "Register successfull!");
                            dao.signup(name, email, pass, fullname, phone, address);
                            request.getRequestDispatcher("login.jsp").forward(request, response);
                        } else {
                            request.setAttribute("errorpass", "Confirm pass is not true!");
                            request.setAttribute("username", name);
                            request.setAttribute("fullname", fullname);
                            request.setAttribute("email", email);
                            request.setAttribute("phone", phone);
                            request.setAttribute("address", address);
                            request.getRequestDispatcher("login.jsp").forward(request, response);
                        }
                    } else {
                        request.setAttribute("username", name);
                        request.setAttribute("fullname", fullname);
                        request.setAttribute("phone", phone);
                        request.setAttribute("address", address);
                        request.setAttribute("emailavailable", "Email is existed!");
                        request.getRequestDispatcher("login.jsp").forward(request, response);
                    }
                } else {
                    request.setAttribute("errorname", "Username is existed!");
                    request.setAttribute("fullname", fullname);
                    request.setAttribute("email", email);
                    request.setAttribute("phone", phone);
                    request.setAttribute("address", address);
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }

            }
        }

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
