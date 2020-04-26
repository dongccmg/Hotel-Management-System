package db;

import model.*;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.TimeZone;

public class CheckOutDao {
    private static final Object UTC= TimeZone.getTimeZone("UTC");
    Connection ct;
    PreparedStatement pstmt;
    String url;
    String user;
    String password;

    public CheckOutDao(){
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

    public ArrayList RoomTable(String roomstatus){
        try{
            ArrayList al=new ArrayList();
            pstmt = ct.prepareStatement("select * from Room where status=?");
            pstmt.setString(1, roomstatus);
            ResultSet rs = pstmt.executeQuery();

            while(rs.next()){
                //if( (rs.getString(5).equals("有人") ) ){
                    Room room = new Room();
                    room.setRoomNumber(rs.getInt(1));
                    room.setRoomType(rs.getString(2));
                    room.setTelephone(rs.getString(3));
                    room.setRoomPrice(rs.getInt(4));
                    room.setStatus(rs.getString(5));
                    al.add(room);
                //}
            }
            return al;
        }
        catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }


    public ArrayList SearchRoom(Integer roomnumber,String roomstatus){
        try{
            ArrayList al=new ArrayList();
            pstmt = ct.prepareStatement("select * from Room");
             ResultSet rs = pstmt.executeQuery();

            while(rs.next()){
                if( (rs.getInt(1)==roomnumber )&&(rs.getString(5).equals(roomstatus) ) ){
                    Room room = new Room();
                    room.setRoomNumber(rs.getInt(1));
                    room.setRoomType(rs.getString(2));
                    room.setTelephone(rs.getString(3));
                    room.setRoomPrice(rs.getInt(4));
                    room.setStatus(rs.getString(5));
                    al.add(room);
                }
            }
            return al;
        }
        catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }

    public boolean CheckoutUpdate(Integer roomnumber,String paymen,Integer ownmoney){
        try{
            pstmt = ct.prepareStatement("UPDATE room SET status ='空闲' WHERE (RoomNumber=?)");
            pstmt.setInt(1, roomnumber);
            pstmt.execute();

            pstmt = ct.prepareStatement("UPDATE permanent SET OwnMoney=OwnMoney+? WHERE (IdentityNumber=?)");
            pstmt.setInt(1, ownmoney);
            pstmt.setString(2, paymen);
            pstmt.execute();
            pstmt = ct.prepareStatement("DELETE FROM now WHERE (roomliving=?)");
            pstmt.setInt(1, roomnumber);
            pstmt.execute();

            return true;
        }
        catch(Exception e){
            e.printStackTrace();
            return false;
        }
    }


    public boolean RoomChange(Integer oldroom, Integer newroom) {
        try{
            System.out.println("Dao："+oldroom);
            pstmt = ct.prepareStatement("UPDATE room SET status ='空闲' WHERE (RoomNumber=?)");
            pstmt.setInt(1, oldroom);
            pstmt.execute();
            pstmt = ct.prepareStatement("UPDATE room SET status ='有人' WHERE (RoomNumber=?)");
            pstmt.setInt(1, newroom);
            pstmt.execute();
            pstmt = ct.prepareStatement("UPDATE checkin SET roomliving=? WHERE (roomliving=?)");
            pstmt.setInt(1, newroom);
            pstmt.setInt(2, oldroom);
            pstmt.execute();
            pstmt = ct.prepareStatement("UPDATE now SET roomliving=? WHERE (roomliving=?)");
            pstmt.setInt(1, newroom);
            pstmt.setInt(2, oldroom);
            pstmt.execute();
            return true;
        }
        catch(Exception e){
            e.printStackTrace();
            return false;
        }

    }

    public boolean OverallUpdate(Integer own,Integer earn ){
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
                int numpeople =0 ;int roomres = 0; int ownmoney = own; int profit = earn; int numvip = 0;
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
                pstmt = ct.prepareStatement("update overall set OverallMoneyOwn=OverallMoneyOwn+?, profit=profit+? where YearMonthDay=?");
                pstmt.setInt(1, own);
                pstmt.setInt(2, earn);
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
}