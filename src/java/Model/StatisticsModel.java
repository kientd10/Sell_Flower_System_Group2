/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author tuanh
 */
public class StatisticsModel {
    private double monthlyRevenue;
    private int monthlyOrderCount;

    public StatisticsModel() {
    }

    public StatisticsModel(double monthlyRevenue, int monthlyOrderCount) {
        this.monthlyRevenue = monthlyRevenue;
        this.monthlyOrderCount = monthlyOrderCount;
    }

    public double getMonthlyRevenue() {
        return monthlyRevenue;
    }

    public void setMonthlyRevenue(double monthlyRevenue) {
        this.monthlyRevenue = monthlyRevenue;
    }

    public int getMonthlyOrderCount() {
        return monthlyOrderCount;
    }

    public void setMonthlyOrderCount(int monthlyOrderCount) {
        this.monthlyOrderCount = monthlyOrderCount;
    }
    
}
