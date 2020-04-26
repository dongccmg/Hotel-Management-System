package model;

public class RoomandDeposit {
    private int RoomNumber;
    private String RoomType;
    private String Telephone;
    private int RoomPrice;
    private String Status;
    private int depositprice;

    public void setRoomNumber(int RoomNumber){
        this.RoomNumber = RoomNumber;
    }

    public void setRoomType(String RoomType){ this.RoomType = RoomType; }

    public void setTelephone(String Telephone){
        this.Telephone = Telephone;
    }

    public void setRoomPrice(int RoomPrice){
        this.RoomPrice = RoomPrice;
    }

    public void setStatus(String Status){
        this.Status = Status;
    }

    public void setdepositprice(int depositprice){
        this.depositprice = depositprice;
    }

    public int getRoomNumber(){
        return  RoomNumber;
    }

    public String getRoomType() {
        return RoomType;
    }

    public String getTelephone() {
        return Telephone;
    }

    public int getRoomPrice(){
        return RoomPrice;
    }

    public String getStatus(){
        return Status;
    }

    public int getdepositprice(){ return depositprice; }
}
