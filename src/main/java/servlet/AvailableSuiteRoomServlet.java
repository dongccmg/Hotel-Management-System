package servlet;

import db.CheckIn;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;


public class AvailableSuiteRoomServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        this.doPost(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("text/json;charset=UTF-8");
        PrintWriter out=resp.getWriter();
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code",0);
        jsonObject.put("msg","");
        jsonObject.put("count",100);
        JSONArray result = null;
        CheckIn ci = new CheckIn();
        result = JSONArray.fromObject( ci.availableRoom("豪华套房"));
        jsonObject.put("data",result);
        out.println(jsonObject.toString());
        out.flush();
        out.close();
    }
}
