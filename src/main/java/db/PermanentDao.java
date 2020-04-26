package db;

import model.Permanent;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.TimeZone;

public class PermanentDao {
    private static final Object UTC= TimeZone.getTimeZone("UTC");
    Connection ct;
    PreparedStatement pstmt;
    String url;
    String user;
    String password;

    public PermanentDao(){
        url= "jdbc:mysql://localhost:3306/hotel?characterEncoding=UTF-8"+"&serverTimezone=UTC";
        user ="root";
        password ="root";
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            ct=DriverManager.getConnection(url,user,password);
        }catch(Exception e){
            e.printStackTrace();
        }
    }

    public ArrayList PerTable(){
        try{
            ArrayList al=new ArrayList();
            pstmt = ct.prepareStatement("select * from Permanent");
            ResultSet rs = pstmt.executeQuery();

            while(rs.next()){
                Permanent per = new Permanent();
                per.setCustomerName(rs.getString(1));
                per.setIdentityNumber(rs.getString(2));
                per.setVipStatus(rs.getString(3));
                per.setOwnMoney(rs.getInt(4));
                al.add(per);
            }
            return al;
        }
        catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }


    public ArrayList PerSearch(String id){
        try{
            ArrayList al=new ArrayList();
            String sql;
            id=id.trim();
            sql="select * from Permanent where identitynumber like \'%"+id+"%\'";
            //System.out.println("sql:  "+sql);
            pstmt = ct.prepareStatement(sql);

            //pstmt.setString(1, id);
            ResultSet rs = pstmt.executeQuery();
            while(rs.next()){
                Permanent per = new Permanent();
                per.setCustomerName(rs.getString(1));
                per.setIdentityNumber(rs.getString(2));
                per.setVipStatus(rs.getString(3));
                per.setOwnMoney(rs.getInt(4));
                al.add(per);
            }
            return al;
        }
        catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }

    public boolean PerUpdate(String id,Integer ownmoney,Integer returnmoney){
        try{
            ownmoney-=returnmoney;
            pstmt = ct.prepareStatement("UPDATE permanent SET ownmoney =? WHERE (IdentityNumber=?)");
            pstmt.setInt(1, ownmoney);
            pstmt.setString(2, id);
            pstmt.execute();
            return true;
        }
        catch(Exception e){
            e.printStackTrace();
            return false;
        }
    }

    public boolean OverallUpdate(Integer returnmoney ){
        try{
            java.sql.Date d = new java.sql.Date(System.currentTimeMillis());
            String datestring=new SimpleDateFormat("yyyy-MM-dd").format(d);
            System.out.println("date: "+d);
            System.out.println("datestring: "+datestring);
            pstmt = ct.prepareStatement("select count(*) as coun from overall where YearMonthDay=?");
            pstmt.setString(1, datestring);
            ResultSet rs = pstmt.executeQuery();
            rs.next();
            int count = rs.getInt("coun");
            if(count == 0){
                int numpeople =0 ;int roomres = 0; int ownmoney = -returnmoney; int profit = returnmoney; int numvip = 0;
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
                pstmt = ct.prepareStatement("update overall set OverallMoneyOwn=OverallMoneyOwn-?, profit=profit+? where YearMonthDay=?");
                pstmt.setInt(1, returnmoney);
                pstmt.setInt(2, returnmoney);
                pstmt.setString(3, datestring);
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


    public ArrayList OwnTable(){
        try{
            ArrayList al=new ArrayList();
            pstmt = ct.prepareStatement("select * from Permanent where ownmoney>0");
            ResultSet rs = pstmt.executeQuery();

            while(rs.next()){
                Permanent per = new Permanent();
                per.setCustomerName(rs.getString(1));
                per.setIdentityNumber(rs.getString(2));
                per.setVipStatus(rs.getString(3));
                per.setOwnMoney(rs.getInt(4));
                al.add(per);
            }
            return al;
        }
        catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }
}