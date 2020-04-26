package servlet;

import db.*;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.processors.JsDateJsonBeanProcessor;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;


public class RoomSearchServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        this.doPost(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("text/json;charset=UTF-8");
        String searchroom=req.getParameter("searchroom").trim();
        String roomstatus=req.getParameter("roomstatus");
        System.out.println(searchroom);
        PrintWriter out=resp.getWriter();
        JSONObject jsonObject = new JSONObject();
        JSONArray result= null;
        if(searchroom.length()==0){
            System.out.println("searchroom"+searchroom);
            ArrayList al=new ArrayList();
            result = JSONArray.fromObject(al);
            jsonObject.put("code",0);
            jsonObject.put("msg","");
            jsonObject.put("count",0);
            jsonObject.put("data",result);
            out.println(jsonObject.toString());
            out.flush();
            out.close();
        }
        else {
            CheckOutDao ci = new CheckOutDao();
            result = JSONArray.fromObject(ci.SearchRoom(Integer.parseInt(searchroom), roomstatus));
            jsonObject.put("code", 0);
            jsonObject.put("msg", "");
            jsonObject.put("count", ci.SearchRoom(Integer.parseInt(searchroom), roomstatus).size());
            jsonObject.put("data", result);
            out.println(jsonObject.toString());
            out.flush();
            out.close();
        }
    }
}
