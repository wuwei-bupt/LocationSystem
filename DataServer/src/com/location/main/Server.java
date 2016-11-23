package com.location.main;

import java.io.UnsupportedEncodingException;
import java.util.Iterator;
import com.google.gson.*;
import com.location.dao.Impl.BaseDAO;
import com.location.entity.User_info;
import com.location.json.JSON;
import com.location.entity.Device_info_history;

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
				
				//鍒涘缓涓�涓狦son瀵硅薄
				Gson gson = new Gson();
				//鍒涘缓涓�涓狫sonParser
				JsonParser parser = new JsonParser();
				//閫氳繃JsonParser瀵硅薄鍙互鎶妀son鏍煎紡鐨勫瓧绗︿覆瑙ｆ瀽鎴愪竴涓狫sonElement瀵硅薄
				JsonElement el = parser.parse(json);
				//
				JsonObject jObject = el.getAsJsonObject();
				
				JsonElement jElement = jObject.get("data");
				//鎶奐sonElement瀵硅薄杞崲鎴怞sonArray
				JsonArray jsonArray = null;
				
				if(jElement.isJsonArray()){
					jsonArray = jElement.getAsJsonArray();
				}

				//鍒涘缓涓�涓狟aseDao瀵硅薄锛屽線鏁版嵁搴撳啓鍏OJO
				BaseDAO<User_info> baseDAO = new BaseDAO<>();
				BaseDAO<Device_info_history> baseDAO2 = new BaseDAO<>();
				//BaseDAO<User_name> baseDAO3 = new BaseDAO<>();
				
				//閬嶅巻JsonArray瀵硅薄
				Device_info_history user_info_history= null;
				User_info user_info = null;
				//User_name user_name = new User_name();
				System.out.println(jsonArray.toString());
				Iterator it = jsonArray.iterator();
				while(it.hasNext()){
					
					JsonElement jsonElement = (JsonElement) it.next();
					String str = jsonElement.getAsString();
					
					JsonElement e = parser.parse(str);
					
					//JsonElement杞崲涓篔avaBean瀵硅薄
					user_info = gson.fromJson(e, User_info.class);
					user_info_history = gson.fromJson(e, Device_info_history.class);
		
					//user_name.setId_card("222222222");
					//user_name.setUser_name("guoxinze");
					//user_name.setUser_info(user_info);
					
					baseDAO2.create(user_info_history);
					baseDAO.create(user_info);
					//baseDAO3.create(user_name);
					//System.out.println("username is "+user_name.getUser_name()+"user id is"+user_name.getUser_info().getUser_id());
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
