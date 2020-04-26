package servlet;

import db.*;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;


public class RoomTableServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        this.doPost(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String roomstatus=req.getParameter("roomstatus");
        resp.setContentType("text/json;charset=UTF-8");
        PrintWriter out=resp.getWriter();
        JSONObject jsonObject = new JSONObject();
        JSONArray result = null;
        CheckOutDao co = new CheckOutDao();
        result = JSONArray.fromObject( co.RoomTable(roomstatus));
        jsonObject.put("code",0);
        jsonObject.put("msg","");
        jsonObject.put("count",co.RoomTable(roomstatus).size());
        jsonObject.put("data",result);
        out.println(jsonObject.toString());
        out.flush();
        out.close();
    }
}
