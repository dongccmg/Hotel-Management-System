package model;

public class ResInf {
    private int RoomNumber;
    private String IdentityNumber;
    private String customername;

    public void setRoomNumber(int RoomNumber){
        this.RoomNumber = RoomNumber;
    }

    public void setIdentityNumber(String IdentityNumber){ this.IdentityNumber = IdentityNumber; }

    public void setcustomername(String customername){
        this.customername = customername;
    }

    public int getRoomNumber(){
        return  RoomNumber;
    }

    public String getIdentityNumber() {
        return IdentityNumber;
    }

    public String getCustomername() {
        return customername;
    }

}
