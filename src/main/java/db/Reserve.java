package db;

import model.RoomandDeposit;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.TimeZone;

public class Reserve {
    private static final Object UTC= TimeZone.getTimeZone("UTC");
    Connection ct;
    PreparedStatement pstmt;
    String url;
    String user;
    String password;

    public Reserve(){
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

    public ArrayList availableRoom(String RoomType){
        try{
            ArrayList al=new ArrayList();
            pstmt = ct.prepareStatement("select room.RoomNumber,room.RoomType,room.RoomPrice,room.Status,deposit.depositprice from room inner join deposit on room.RoomType = deposit.RoomType");
            ResultSet rs = pstmt.executeQuery();

            while(rs.next()){
                if( (rs.getString(4).equals("空闲"))
                        && rs.getString(2).equals(RoomType)){
                    RoomandDeposit rd = new RoomandDeposit();
                    rd.setRoomNumber(rs.getInt(1));
                    rd.setRoomType(rs.getString(2));
                    rd.setRoomPrice(rs.getInt(3));
                    rd.setStatus(rs.getString(4));
                    rd.setdepositprice(rs.getInt(5));
                    al.add(rd);
                }
            }
            return al;
        }
        catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }

    public boolean reserve(String IdentityNumber, String Name, int RoomLiving){
        if(  addReserve(IdentityNumber, Name, RoomLiving) &&
                updateRoom(RoomLiving) &&
                NotExistThenaddPermanent(IdentityNumber, Name) &&
                updateOraddOverall() )
            return true;
        return false;
    }

    public boolean addReserve(String Identity, String Name, int RoomLiving){
        try{
            pstmt=ct.prepareStatement("insert into Reserve (RoomNumber, IdentityNumber, customername) values(?,?,?)");
            pstmt.setInt(1, RoomLiving);
            pstmt.setString(2, Identity);
            pstmt.setString(3, Name);
            pstmt.executeUpdate();
            return true;
        }catch(Exception e){
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateRoom(int RoomLiving){
        try{
            String status = "预约";
            pstmt = ct.prepareStatement("update Room set Status=? where RoomNumber=?");
            pstmt.setString(1, status);
            pstmt.setInt(2, RoomLiving);
            if(pstmt.executeUpdate() != 1){
                return false;
            }
            return true;
        }catch(Exception e){
            e.printStackTrace();
            return false;
        }
    }

    public boolean NotExistThenaddPermanent(String Identity, String Name){
        try {
            pstmt = ct.prepareStatement("select count(*) as coun from permanent where IdentityNumber=?");
            pstmt.setString(1, Identity);
            ResultSet rs = pstmt.executeQuery();
            rs.next();
            int count = rs.getInt("coun");
            if(count == 0){
                String vip = "否";
                int own = 0;
                pstmt=ct.prepareStatement("insert into permanent (customername, IdentityNumber, VipStatus, OwnMoney) values(?,?,?,?)");
                pstmt.setString(1, Name);
                pstmt.setString(2, Identity);
                pstmt.setString(3, vip);
                pstmt.setInt(4, own);
                pstmt.executeUpdate();
            }
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
                int numpeople = 0; int roomres = 1; int ownmoney = 0; int profit = 0; int numvip = 0;
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
                pstmt = ct.prepareStatement("select RoomReserved from overall where YearMonthDay=?");
                pstmt.setDate(1, d);
                rs = pstmt.executeQuery();
                rs.next();
                int numres = rs.getInt(1) + 1;
                pstmt = ct.prepareStatement("update overall set RoomReserved=? where YearMonthDay=?");
                pstmt.setInt(1, numres);
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
