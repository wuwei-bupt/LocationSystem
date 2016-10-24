package com.location.main;

import java.io.UnsupportedEncodingException;
import java.util.Iterator;

import com.google.gson.*;
import com.location.dao.Impl.BaseDAO;
import com.location.entity.User_info;
import com.location.entity.User_info_history;
import com.location.entity.User_name;
import com.location.json.JSON;

public class Server extends Thread {
	
	
	public static void main(String[] args) {
			Server s = new Server();
				s.start();
	}
	
	public void run(){
		while(true){
			try {
				String user_id_list = "http://tz.seekcy.com:8085/WebLocate/LocateResults?user_ids=1918E0000020,1918E0000021,1918E0000022&time_period=5000";
				String json = JSON.getReturnData(user_id_list);
				
				//创建一个Gson对象
				Gson gson = new Gson();
				//创建一个JsonParser
				JsonParser parser = new JsonParser();
				//通过JsonParser对象可以把json格式的字符串解析成一个JsonElement对象
				JsonElement el = parser.parse(json);
				//
				JsonObject jObject = el.getAsJsonObject();
				
				JsonElement jElement = jObject.get("data");
				//把JsonElement对象转换成JsonArray
				JsonArray jsonArray = null;
				
				if(jElement.isJsonArray()){
					jsonArray = jElement.getAsJsonArray();
				}

				//创建一个BaseDao对象，往数据库写入POJO
				BaseDAO<User_info> baseDAO = new BaseDAO<>();
				BaseDAO<User_info_history> baseDAO2 = new BaseDAO<>();
				BaseDAO<User_name> baseDAO3 = new BaseDAO<>();
				
				//遍历JsonArray对象
				User_info_history user_info_history= null;
				User_info user_info = null;
				User_name user_name = new User_name();
				System.out.println(jsonArray.toString());
				Iterator it = jsonArray.iterator();
				while(it.hasNext()){
					
					JsonElement jsonElement = (JsonElement) it.next();
					String str = jsonElement.getAsString();
					
					JsonElement e = parser.parse(str);
					
					//JsonElement转换为JavaBean对象
					user_info = gson.fromJson(e, User_info.class);
					user_info_history = gson.fromJson(e, User_info_history.class);
			
					user_name.setId_card("222222222");
					user_name.setUser_name("guoxinze");
					user_name.setUser_info(user_info);
					
					baseDAO2.create(user_info_history);
					baseDAO.create(user_info);
					baseDAO3.create(user_name);
					System.out.println("username is "+user_name.getUser_name()+"user id is"+user_name.getUser_info().getUser_id());
					//break;
				}
			}catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try{
				Thread.sleep(5000);
			}catch(Exception exception){
				System.out.println(exception);
			}
		}				

	}
		
}

