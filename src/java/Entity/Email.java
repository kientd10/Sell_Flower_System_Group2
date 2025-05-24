/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entity;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author ADMIN
 */
public class Email {
    public boolean ValidEmail(String Email){
        // Biểu thức chính quy cho định dạng email
        String emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Z|a-z]{2,}$";
        
        //Tạo đối tượng pattern
        Pattern pattern = Pattern.compile(emailRegex);
        
        //Tạo đối tượng matcher
        Matcher matcher = pattern.matcher(Email);
        
        //kiểm tra chuỗi với biẻu thức chính quy
        return matcher.matches();
    }
}
