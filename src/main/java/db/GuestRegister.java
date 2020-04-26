package db;

import model.vip;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.TimeZone;

public class GuestRegister {
    private static final Object UTC= TimeZone.getTimeZone("UTC");
    Connection ct;
    PreparedStatement pstmt;
    String url;
    String user;
    String password;

    public GuestRegister(){
        url= "jdbc:mysql://localhost:3306/hotel?characterEncoding=UTF-8"+"&serverTimezone=UTC";
        user ="root";
        password ="root";
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            ct= DriverManager.getConnection(url,user,password);
        }catch(Exception e){
            e.printStackTrace();
        }
    }

    public vip register(String id, String name){
        addorupdatePermanent(id, name);
        String num = NotExistThenaddVip(id, name);
        if(num!="该用户已是贵宾,不需重复注册!" && num!=null){
            updateOraddOverall();
        }
        vip v = new vip();
        v.setVipNumber(num);
        return v;
    }

    public String NotExistThenaddVip(String Identity, String Name){
        try{
            ResultSet rs;
            int count;
            pstmt = ct.prepareStatement("select count(*) as coun from vip where IdentityNumber=?");
            pstmt.setString(1, Identity);
            rs = pstmt.executeQuery();
            rs.next();
            count = rs.getInt("coun");
            if(count == 0) {
                pstmt = ct.prepareStatement("select * from vip order by VipNumber desc limit 0,1");
                rs = pstmt.executeQuery();
                if( rs!=null && rs.next() ) {
                    String vipnum = rs.getString(1);
                    int num  = Integer.valueOf(vipnum).intValue();
                    vipnum = String.format("%010d", num + 1);
                    pstmt = ct.prepareStatement("insert into vip (VipNumber , IdentityNumber) values(?,?)");
                    pstmt.setString(1, vipnum);
                    pstmt.setString(2, Identity);
                    pstmt.executeUpdate();
                    return vipnum;
                }
                else
                {
                    String vipnum = String.format("%010d", 1);
                    pstmt = ct.prepareStatement("insert into vip (VipNumber , IdentityNumber) values(?,?)");
                    pstmt.setString(1, vipnum);
                    pstmt.setString(2, Identity);
                    pstmt.executeUpdate();
                    return vipnum;
                }
            }
            else if(count == 1){
                return "该用户已是贵宾,不需重复注册!";
            }
            else
                return null;
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }

    public boolean addorupdatePermanent(String Identity, String Name){
        try {
            ResultSet rs;
            int count;
            String vip = "是";
            int own = 0;

            pstmt = ct.prepareStatement("select count(*) as coun from permanent where IdentityNumber=?");
            pstmt.setString(1, Identity);
            rs = pstmt.executeQuery();
            rs.next();
            count = rs.getInt("coun");
            if(count == 0) {
                pstmt = ct.prepareStatement("insert into permanent (customername, IdentityNumber, VipStatus, OwnMoney) values(?,?,?,?)");
                pstmt.setString(1, Name);
                pstmt.setString(2, Identity);
                pstmt.setString(3, vip);
                pstmt.setInt(4, own);
                pstmt.executeUpdate();
            }
            else if(count == 1){
                pstmt = ct.prepareStatement("update permanent set VipStatus=? where IdentityNumber=?");
                pstmt.setString(1, vip);
                pstmt.setString(2, Identity);
                if(pstmt.executeUpdate() != 1){
                    return false;
                }
            }
            else
                return false;
            return true;
        }catch(Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateOraddOverall(){
        try{
            java.sql.Date d = new java.sql.Date(System.currentTimeMillis());
            pstmt = ct.prepareStatement("select count(*) as coun from overall where YearMonthDay=?");
            pstmt.setDate(1, d);
            ResultSet rs = pstmt.executeQuery();
            rs.next();
            int count = rs.getInt("coun");
            if(count == 0){
                int numpeople = 0;int roomres = 0; int ownmoney = 0; int profit = 0; int numvip = 1;
                pstmt=ct.prepareStatement("insert into overall (YearMonthDay, OverallPeople, RoomReserved, OverallMoneyOwn, Profit, VipIncreased ) values(?,?,?,?,?,?)");
                pstmt.setDate(1, d);
                pstmt.setInt(2, numpeople);
                pstmt.setInt(3, roomres);
                pstmt.setInt(4, ownmoney);
                pstmt.setInt(5, profit);
                pstmt.setInt(6, numvip);
                pstmt.executeUpdate();
            }
            else if(count == 1){
                pstmt = ct.prepareStatement("select VipIncreased from overall where YearMonthDay=?");
                pstmt.setDate(1, d);
                rs = pstmt.executeQuery();
                rs.next();
                int vip = rs.getInt(1) + 1;
                pstmt = ct.prepareStatement("update overall set VipIncreased=? where YearMonthDay=?");
                pstmt.setInt(1, vip);
                pstmt.setDate(2, d);
                if(pstmt.executeUpdate() != 1){
                    return false;
                }
            }
            else {
                return false;
            }
            return true;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }

}
