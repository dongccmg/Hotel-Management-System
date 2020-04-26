package model;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

public class AllInfo {
    public boolean gorl;
    public ArrayList<String> ids=new ArrayList();
    public String checkintime;
    public Integer price;
    public boolean vip;
    public void setDate(Timestamp date) {
        this.checkintime = new SimpleDateFormat("yyyy-MM-dd").format(date);
    }
}
