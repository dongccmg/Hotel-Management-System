package servlet;


import db.AllInfoDao;
import model.AllInfo;
import net.sf.json.JSONObject;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;


public class InfoServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        this.doPost(req, resp);
    }


    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        System.out.println("6666666");
        resp.setContentType("application/json;charset=UTF-8");
        req.setCharacterEncoding("gb2312");
        resp.setContentType("gb2312");
        String room=req.getParameter("room");
        AllInfo al=new AllInfo();
        AllInfoDao aldao=new AllInfoDao();
        al= aldao.showinfo(Integer.parseInt(room));
        PrintWriter out=resp.getWriter();
        //for(int i=0;i<al.ids.size();i++){
          //  System.out.println("infotest: "+al.ids.get(i));
        //}
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("ids",al.ids);
        jsonObject.put("gorl",al.gorl);
        jsonObject.put("vip",al.vip);
        jsonObject.put("price",al.price);
        jsonObject.put("checkintime",al.checkintime);
        System.out.println("test:"+jsonObject.toString());
        out.write(jsonObject.toString());

        out.flush();
        out.close();
        //req.getRequestDispatcher("b.jsp?").forward(request,resp);

        //out.println(price+"\t"+id+"\t"+gorl+"\t"+vip);
                /*if(room.equals("201"))  {
            System.out.println("good");
            price=900;
        }
        else
            System.out.println("bad");
        //System.out.println("info:"+req.getParameter("room"));
        System.out.println("price:"+req.getParameter("price"));
        System.out.println("email:"+req.getParameter("email"));
        String gorl="是";
        String id="111";
        String vip="999";
                 */

    }
}
