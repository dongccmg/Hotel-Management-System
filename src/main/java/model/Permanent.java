package model;

public class Permanent {
    private String CustomerName;
    private String IdentityNumber;
    private String VipStatus;
    private int OwnMoney;

    public String getCustomerName() {
        return CustomerName;
    }

    public void setCustomerName(String customerName) {
        this.CustomerName = customerName;
    }

    public String getIdentityNumber() {
        return IdentityNumber;
    }

    public void setIdentityNumber(String identityNumber) {
        this.IdentityNumber = identityNumber;
    }

    public String getVipStatus() {
        return VipStatus;
    }

    public void setVipStatus(String vipStatus) {
        this.VipStatus = vipStatus;
    }

    public int getOwnMoney() {
        return OwnMoney;
    }

    public void setOwnMoney(int ownMoney) {
        this.OwnMoney = ownMoney;
    }
}
