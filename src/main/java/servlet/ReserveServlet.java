package servlet;

import db.Reserve;
import net.sf.json.JSONObject;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class ReserveServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        this.doPost(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("text/json;charset=UTF-8");
        String Identity = req.getParameter("resid");
        String Name = req.getParameter("resname");
        int Room = Integer. parseInt(req.getParameter("roomnum"));
        Reserve re = new Reserve();
        re.reserve(Identity, Name, Room);
        PrintWriter out=resp.getWriter();
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code",0);
        jsonObject.put("msg","");
        jsonObject.put("count",100);
        jsonObject.put("flag",1);
        out.println(jsonObject.toString());
        out.flush();
        out.close();
    }
}
