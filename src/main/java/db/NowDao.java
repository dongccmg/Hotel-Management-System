package db;

import model.Now;
import model.Room;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.TimeZone;

public class NowDao {
    private static final Object UTC= TimeZone.getTimeZone("UTC");
    Connection ct;
    PreparedStatement pstmt;
    String url;
    String user;
    String password;

    public NowDao(){
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

    public ArrayList NowTable(){
        try{
            ArrayList al=new ArrayList();
            pstmt = ct.prepareStatement("select * from now");
            ResultSet rs = pstmt.executeQuery();

            while(rs.next()){
                Now now = new Now();
                now.setIdentityNumber(rs.getString(1));
                now.setRoomLiving(rs.getInt(2));

                al.add(now);
            }

            return al;
        }
        catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }


    public ArrayList SearchRoom(Integer roomnumber){
        try{
            ArrayList al=new ArrayList();
            pstmt = ct.prepareStatement("select * from Room");
            ResultSet rs = pstmt.executeQuery();

            while(rs.next()){
                if( (rs.getInt(1)==roomnumber ) ){
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

            pstmt = ct.prepareStatement("UPDATE permanent SET OwnMoney=? WHERE (IdentityNumber=?)");
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


}