package model;

import java.sql.Date;

public class Checkin {
    private int EventNumber;
    private String IdentityNumber;
    private int RoomLiving;
    private Date datetime;
    private String Gorl;

    public void setEventNumber(int EventNumber){ this.EventNumber = EventNumber; }

    public void setIdentityNumber(String IdentityNumber){
        this.IdentityNumber = IdentityNumber;
    }

    public void setRoomLiving(int RoomLiving){
        this.RoomLiving = RoomLiving;
    }

    public void setDatetime(Date datetime){
        this.datetime =  datetime;
    }
    public void setGorl(String Gorl){
        this.Gorl =  Gorl;
    }

    public int getEventNumber() {
        return EventNumber;
    }

    public String getIdentityNumber() {
        return IdentityNumber;
    }

    public int getRoomLiving() {
        return RoomLiving;
    }

    public Date getDateTime() { return datetime; }
    public String getGorl() { return Gorl;}
}
