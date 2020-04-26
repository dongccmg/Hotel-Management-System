package servlet;

import db.GuestRegister;
import model.vip;
import net.sf.json.JSONObject;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class GuestServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        this.doPost(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("text/json;charset=UTF-8");
        String id = req.getParameter("id");
        String name = req.getParameter("name");

        PrintWriter out=resp.getWriter();
        GuestRegister gr = new GuestRegister();
        vip v = gr.register(id, name);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code",0);
        jsonObject.put("msg","");
        jsonObject.put("count",100);
        jsonObject.put("vipnum",v.getVipNumber());
        out.println(jsonObject.toString());
        out.flush();
        out.close();
    }
}
