package db;
import model.AllInfo;

import java.sql.*;
import java.sql.Timestamp;
import java.util.TimeZone;

public class AllInfoDao {
    private static final Object UTC= TimeZone.getTimeZone("UTC");
    Connection ct;
    PreparedStatement pstmt;
    String url;
    String user;
    String password;

    public AllInfoDao(){
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
    public AllInfo showinfo(Integer roomnumber){
        try{
            AllInfo al=new AllInfo();
            al.gorl=false;
            al.vip=false;
            Boolean status=false;
            System.out.println(roomnumber);
            String firstsql="select YearMonthDay from checkin where roomliving=? order by YearMonthDay desc limit 0,1";
            pstmt = ct.prepareStatement(firstsql);
            pstmt.setInt(1,roomnumber);
            ResultSet rs = pstmt.executeQuery();
            rs.next();
            Timestamp recenttime=rs.getTimestamp(1);
            System.out.println("recenttime:"+recenttime);
            pstmt = ct.prepareStatement("select * from checkin left outer join vip on checkin.identitynumber=vip.identitynumber where YearMonthDay=?");
            pstmt.setTimestamp(1,recenttime);
            rs = pstmt.executeQuery();
            while(rs.next()){
                if(rs.getString(5).equals("是")) {
                    al.gorl = true;
                }
                if(rs.getString(7)!=null) {
                    al.vip = true;
                }
                System.out.println("ren: "+rs.getString(2));
                al.ids.add(rs.getString(2));
            }
            pstmt = ct.prepareStatement("SELECT room.RoomPrice FROM room where roomNumber=?");
            pstmt.setInt(1, roomnumber);
            rs = pstmt.executeQuery();
            while(rs.next()) {
                al.price=rs.getInt(1);
                System.out.println("price:"+al.price);
            }
            /*pstmt = ct.prepareStatement("SELECT yearmonthday FROM checkin where roomliving=?");
            pstmt.setInt(1, roomnumber);
            rs = pstmt.executeQuery();
            while(rs.next()) {
                al.setDate(new java.util.Date((rs.getDate(1).getTime())));
                System.out.println("ttime:"+al.checkintime);
            }*/
            al.setDate(recenttime);
            return al;
        }
        catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }

}
