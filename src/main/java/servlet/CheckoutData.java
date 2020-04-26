package servlet;

import db.CheckOutDao;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
public class CheckoutData extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        this.doPost(req, resp);
    }


    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("text/json;charset=UTF-8");
        PrintWriter out=resp.getWriter();
        Integer room=Integer.parseInt(req.getParameter("room"));
        String paymen=req.getParameter("paymen");
        Integer ownmoney=Integer.parseInt(req.getParameter("ownmoney"));
        Integer earn=Integer.parseInt(req.getParameter("earn"));
        System.out.println("Stest: "+room+" "+paymen+" "+ownmoney+" "+earn);
        CheckOutDao cod=new CheckOutDao();
        if(cod.CheckoutUpdate(room,paymen,ownmoney)&&cod.OverallUpdate(ownmoney,earn) ){
            System.out.println("checkout servlet success!!!");
        }
    }
}
