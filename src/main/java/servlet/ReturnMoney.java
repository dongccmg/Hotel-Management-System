package servlet;

import db.PermanentDao;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ReturnMoney extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        this.doPost(req, resp);
    }


    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("text/json;charset=UTF-8");
        String id=req.getParameter("id");
        Integer own=Integer.parseInt(req.getParameter("own"));
        Integer back=Integer.parseInt(req.getParameter("back"));
        System.out.println("changeServlet: "+id+own+back);
        PermanentDao pd=new PermanentDao();
        if(pd.PerUpdate(id,own,back)&&pd.OverallUpdate(back)){
            System.out.println("returnmoney servlet success!!!");
        }
    }
}
