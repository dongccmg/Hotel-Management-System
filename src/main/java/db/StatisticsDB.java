package db;


import model.Statistics;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.TimeZone;

public class StatisticsDB {
    private static final Object UTC= TimeZone.getTimeZone("UTC");
    Connection ct;
    PreparedStatement pstmt;
    String url;
    String user;
    String password;

    public StatisticsDB(){
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

    /**public boolean AddStatisticsDB(Statistics st){
        try{
            pstmt=ct.prepareStatement("insert into checkin (IdentityNumber, RoomLiving, Date) values(?,?,?)");
            pstmt.setString(1, st.getIdentityNumber());

            pstmt.executeUpdate();
            return true;
        }catch(Exception e){
            e.printStackTrace();
            return false;
        }
    }**/

    public List<Statistics> statisticsList (String sql) throws SQLException {
        try{
            List<Statistics> list = new ArrayList<>();
            pstmt=ct.prepareStatement(sql);
            ResultSet rs=pstmt.executeQuery();
            while(rs.next()){
                Statistics st=new Statistics();
                st.setDate(new java.util.Date(rs.getDate(1).getTime()));
                st.setGuestnum(rs.getInt(2));
                st.setReservedroom(rs.getInt(3));
                st.setCredit(rs.getInt(4));
                st.setProfit(rs.getInt(5));
                st.setAddguest(rs.getInt(6));
                list.add(st);
            }
            return list;
        }catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }
}