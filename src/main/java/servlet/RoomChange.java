package servlet;

import db.CheckOutDao;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
public class RoomChange extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        this.doPost(req, resp);
    }


    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("text/json;charset=UTF-8");
        PrintWriter out=resp.getWriter();
        Integer oldroom=Integer.parseInt(req.getParameter("oldroom"));
        Integer newroom=Integer.parseInt(req.getParameter("newroom"));
        System.out.println("changeServlet"+oldroom);
        if(new CheckOutDao().RoomChange(oldroom,newroom)){
            System.out.println("changeroom servlet success!!!");
        }
    }
}
