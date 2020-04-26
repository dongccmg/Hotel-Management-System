package db;

import model.ResInf;
import model.RoomandDeposit;
import java.sql.*;
import java.util.ArrayList;
import java.util.TimeZone;

public class CheckIn {
    private static final Object UTC= TimeZone.getTimeZone("UTC");
    Connection ct;
    PreparedStatement pstmt;
    String url;
    String user;
    String password;

    public CheckIn(){
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

    public ArrayList availableRoom(String RoomType){
        try{
            ArrayList al=new ArrayList();
            pstmt = ct.prepareStatement("select Room.RoomNumber,Room.RoomType,Room.RoomPrice,Room.Status,Deposit.depositprice from Room inner join Deposit on Room.RoomType = Deposit.RoomType");
            ResultSet rs = pstmt.executeQuery();

            while(rs.next()){
                if( (rs.getString(4).equals("空闲") || rs.getString(4).equals("预约") )
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

    public ResInf ReserveInformation(int RoomNumber){
        try{
            pstmt = ct.prepareStatement("select count(*) as coun from Reserve where RoomNumber=?");
            pstmt.setInt(1, RoomNumber);
            ResultSet rs = pstmt.executeQuery();
            rs.next();
            int count = rs.getInt("coun");
            if(count == 0){
                ResInf resInf = new ResInf();
                resInf.setRoomNumber(RoomNumber);
                resInf.setIdentityNumber("");
                resInf.setcustomername("");
                return resInf;
            }
            else if(count == 1){
                pstmt = ct.prepareStatement("select * from Reserve where RoomNumber=?");
                pstmt.setInt(1, RoomNumber);
                rs = pstmt.executeQuery();
                rs.next();
                String id = rs.getString(2);
                String name = rs.getString(3);
                ResInf resInf = new ResInf();
                resInf.setRoomNumber(RoomNumber);
                resInf.setIdentityNumber(id);
                resInf.setcustomername(name);
                return resInf;
            }
            else {
                return null;
            }
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }

    public boolean checkIn(String IdentityNumber, String Name, int RoomLiving, int Gorl, String ID2, String Name2, String ID3, String Name3){
        if( addNow(IdentityNumber, RoomLiving,ID2, ID3) &&
                updateRoom(RoomLiving) &&
                NotExistThenaddPermanent(IdentityNumber, Name, ID2, Name2, ID3, Name3) &&
                addCheckin(IdentityNumber, RoomLiving, ID2, ID3,Gorl) &&
                deleteReserve(RoomLiving) &&
                updateOraddOverall(ID2, ID3) )
            return true;
        else
            return false;
    }

    public boolean addNow(String Identity, int RoomLiving, String ID2, String ID3){
        try{
            pstmt=ct.prepareStatement("insert into now (IdentityNumber, RoomLiving) values(?,?)");
            pstmt.setString(1, Identity);
            pstmt.setInt(2, RoomLiving);
            pstmt.executeUpdate();
            if( ID2!=null && ID2.length()!=0 ){
                pstmt=ct.prepareStatement("insert into now (IdentityNumber, RoomLiving) values(?,?)");
                pstmt.setString(1, ID2);
                pstmt.setInt(2, RoomLiving);
                pstmt.executeUpdate();
            }
            if(ID3!=null && ID3.length()!=0){
                pstmt=ct.prepareStatement("insert into now (IdentityNumber, RoomLiving) values(?,?)");
                pstmt.setString(1, ID3);
                pstmt.setInt(2, RoomLiving);
                pstmt.executeUpdate();
            }
            return true;
        }catch(Exception e){
            e.printStackTrace();
            return false;
        }
    }


    public boolean updateRoom(int RoomLiving){
        try{
            String status = "有人";
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

    public boolean NotExistThenaddPermanent(String Identity, String Name, String ID2, String Name2, String ID3, String Name3){
        try {
            ResultSet rs;
            int count;
            String vip = "否";
            int own = 0;

            if( Identity!=null && Identity.length()!=0 ){
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
            }
            if( ID2!=null && ID2.length()!=0 ){
                pstmt = ct.prepareStatement("select count(*) as coun from permanent where IdentityNumber=?");
                pstmt.setString(1, ID2);
                rs = pstmt.executeQuery();
                rs.next();
                count = rs.getInt("coun");
                if(count == 0){
                    pstmt=ct.prepareStatement("insert into permanent (customername, IdentityNumber, VipStatus, OwnMoney) values(?,?,?,?)");
                    pstmt.setString(1, Name2);
                    pstmt.setString(2, ID2);
                    pstmt.setString(3, vip);
                    pstmt.setInt(4, own);
                    pstmt.executeUpdate();
                }
            }
            if( ID3!=null && ID3.length()!=0 ){
                pstmt = ct.prepareStatement("select count(*) as coun from permanent where IdentityNumber=?");
                pstmt.setString(1, ID3);
                rs = pstmt.executeQuery();
                rs.next();
                count = rs.getInt("coun");
                if(count == 0){
                    pstmt=ct.prepareStatement("insert into permanent (customername, IdentityNumber, VipStatus, OwnMoney) values(?,?,?,?)");
                    pstmt.setString(1, Name3);
                    pstmt.setString(2, ID3);
                    pstmt.setString(3, vip);
                    pstmt.setInt(4, own);
                    pstmt.executeUpdate();
                }
            }
            return true;
        }catch(Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean addCheckin(String Identity, int RoomLiving, String ID2, String ID3, int Gor){
        try{
            String Gorl = "否";
            if(Gor == 0)
                Gorl = "是";

            pstmt=ct.prepareStatement("select count(*) as coun from Checkin");
            ResultSet rs = pstmt.executeQuery();
            rs.next();
            int num = rs.getInt("coun");
            num = num + 1;
            Timestamp d = new Timestamp(System.currentTimeMillis());
            pstmt=ct.prepareStatement("insert into Checkin (EventNumber, IdentityNumber, RoomLiving, YearMonthDay,Gorl) values(?,?,?,?,?)");
            pstmt.setInt(1, num);
            pstmt.setString(2, Identity);
            pstmt.setInt(3, RoomLiving);
            pstmt.setTimestamp(4, d);
            pstmt.setString(5,Gorl);
            pstmt.executeUpdate();
            if( ID2!=null && ID2.length()!=0 ){
                num = num + 1;
                pstmt=ct.prepareStatement("insert into Checkin (EventNumber, IdentityNumber, RoomLiving, YearMonthDay,Gorl) values(?,?,?,?,?)");
                pstmt.setInt(1, num);
                pstmt.setString(2, ID2);
                pstmt.setInt(3, RoomLiving);
                pstmt.setTimestamp(4, d);
                pstmt.setString(5,Gorl);
                pstmt.executeUpdate();
            }
            if( ID3!=null && ID3.length()!=0 ){
                num = num + 1;
                pstmt=ct.prepareStatement("insert into Checkin (EventNumber, IdentityNumber, RoomLiving, YearMonthDay,Gorl) values(?,?,?,?,?)");
                pstmt.setInt(1, num);
                pstmt.setString(2, ID3);
                pstmt.setInt(3, RoomLiving);
                pstmt.setTimestamp(4, d);
                pstmt.setString(5,Gorl);
                pstmt.executeUpdate();
            }
            return true;
        }catch(Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteReserve(int RoomLiving){
        try{
            pstmt=ct.prepareStatement("delete from Reserve where RoomNumber=?");
            pstmt.setInt(1, RoomLiving);
            if(pstmt.executeUpdate() > 1)
                return false;
            return true;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateOraddOverall(String ID2, String ID3){
        try{
            java.sql.Date d = new java.sql.Date(System.currentTimeMillis());
            pstmt = ct.prepareStatement("select count(*) as coun from overall where YearMonthDay=?");
            pstmt.setDate(1, d);
            ResultSet rs = pstmt.executeQuery();
            rs.next();
            int count = rs.getInt("coun");
            if(count == 0){
                int numpeople = 1;int roomres = 0; int ownmoney = 0; int profit = 0; int numvip = 0;
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
                pstmt = ct.prepareStatement("select OverallPeople from overall where YearMonthDay=?");
                pstmt.setDate(1, d);
                rs = pstmt.executeQuery();
                rs.next();
                int numpeople = rs.getInt(1) + 1;
                if( ID2!=null && ID2.length()!=0 )
                    numpeople = numpeople + 1;
                if( ID3!=null && ID3.length()!=0 )
                    numpeople = numpeople + 1;
                pstmt = ct.prepareStatement("update overall set OverallPeople=? where YearMonthDay=?");
                pstmt.setInt(1, numpeople);
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