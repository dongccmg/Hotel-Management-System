package servlet;

import db.CheckIn;
import net.sf.json.JSONObject;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class CheckInServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        this.doPost(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("text/json;charset=UTF-8");
        String room = req.getParameter("roomliving");
        int Room = Integer.valueOf(room).intValue();
        String Identity = req.getParameter("identity");
        String Name = req.getParameter("name");
        String ID2 = req.getParameter("identity2");
        String Name2 = req.getParameter("name2");
        String ID3 = req.getParameter("identity3");
        String Name3 = req.getParameter("name3");
        int Gorl = 1;
        if(req.getParameter("sanke").equals("0"))
            Gorl = 0;
        PrintWriter out=resp.getWriter();
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code",0);
        jsonObject.put("msg","");
        jsonObject.put("count",100);
        CheckIn ci = new CheckIn();
        if(ci.checkIn(Identity, Name, Room, Gorl, ID2, Name2, ID3, Name3)){
            jsonObject.put("flag",1);
        }else{
            jsonObject.put("flag",0);
        }
        out.println(jsonObject.toString());
        out.flush();
        out.close();
    }
}
