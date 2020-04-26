package servlet;

import db.*;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;


public class PermanentTable extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        this.doPost(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String id="abc";
        id=req.getParameter("id");
        System.out.println("idd: "+id);
        resp.setContentType("text/json;charset=UTF-8");
        PrintWriter out=resp.getWriter();
        JSONObject jsonObject = new JSONObject();
        JSONArray result = null;

        if(id.equals("无")) {
            PermanentDao pd = new PermanentDao();
            result = JSONArray.fromObject(pd.PerTable());
            jsonObject.put("code", 0);
            jsonObject.put("msg", "");
            jsonObject.put("count", pd.PerTable().size());
            jsonObject.put("data", result);
            out.println(jsonObject.toString());
            out.flush();
            out.close();
        }
        else if(id.equals("有")) {
            PermanentDao pd = new PermanentDao();
            result = JSONArray.fromObject(pd.OwnTable());
            jsonObject.put("code", 0);
            jsonObject.put("msg", "");
            jsonObject.put("count", pd.OwnTable().size());
            jsonObject.put("data", result);
            out.println(jsonObject.toString());
            out.flush();
            out.close();
        }
        else{
            PermanentDao pd = new PermanentDao();
            result = JSONArray.fromObject(pd.PerSearch(id));
            jsonObject.put("code", 0);
            jsonObject.put("msg", "");
            jsonObject.put("count", pd.PerSearch(id).size());
            jsonObject.put("data", result);
            out.println(jsonObject.toString());
            out.flush();
            out.close();
        }
    }
}
