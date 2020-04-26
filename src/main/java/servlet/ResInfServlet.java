package servlet;


import db.CheckIn;
import model.ResInf;
import net.sf.json.JSONObject;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;


public class ResInfServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        this.doPost(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("text/json;charset=UTF-8");
        String st = req.getParameter("par");
        int roomnum = Integer.valueOf(st).intValue();
        PrintWriter out=resp.getWriter();
        CheckIn ci = new CheckIn();
        ResInf resinf = ci.ReserveInformation(roomnum);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code",0);
        jsonObject.put("msg","");
        jsonObject.put("count",100);
        jsonObject.put("id",resinf.getIdentityNumber());
        jsonObject.put("name",resinf.getCustomername());
        out.println(jsonObject.toString());
        out.flush();
        out.close();
    }
}
