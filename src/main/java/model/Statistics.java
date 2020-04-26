package model;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Statistics {
    private String date;
    private int guestnum;
    private int reservedroom;
    private int credit;
    private int profit;
    private int addguest;

    public void setAddguest(int addguest) {
        this.addguest = addguest;
    }

    public void setCredit(int credit) {
        this.credit = credit;
    }

    public void setDate(Date date) {
        this.date = new SimpleDateFormat("yyyy-MM-dd").format(date);
    }

    public void setGuestnum(int guestnum) {
        this.guestnum = guestnum;
    }

    public void setProfit(int profit) {
        this.profit = profit;
    }

    public void setReservedroom(int reservedroom) {
        this.reservedroom = reservedroom;
    }

    public String getDate() {
        return date;
    }

    public int getAddguest() {
        return addguest;
    }

    public int getCredit() {
        return credit;
    }

    public int getGuestnum() {
        return guestnum;
    }

    public int getProfit() {
        return profit;
    }

    public int getReservedroom() {
        return reservedroom;
    }
}
