package model;

import java.io.Serializable;

public class Now implements Serializable {
    private String IdentityNumber;
    private Integer RoomLiving;

    public String getIdentityNumber() {
        return IdentityNumber;
    }

    public Integer getRoomLiving() {
        return RoomLiving;
    }


    public void setIdentityNumber(String identityNumber) {
        this.IdentityNumber = identityNumber;
    }

    public void setRoomLiving(Integer roomLiving) {
        this.RoomLiving = roomLiving;
    }

}

