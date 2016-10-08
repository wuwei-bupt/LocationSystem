package com.location.main;

import java.io.UnsupportedEncodingException;
import java.util.Iterator;


import com.google.gson.*;
import com.location.dao.Impl.BaseDAO;
import com.location.entity.User_info;
import com.location.json.JSON;

public class Server {
	
	
	public static void main(String[] args) {
		try {
			String user_id_list = "http://tz.seekcy.com:8085/WebLocate/LocateResults?user_ids=1918E0000020,1918E0000021,1918E0000022&time_period=5000";
			String json = JSON.getReturnData(user_id_list);
			System.out.println(json);
			
			
//			json = "[{\"accuracy\":4.0,\"build_id\":\"26000\",\"error_code\":0,\"floor_id\":4,\"info\":\"\",\"nearest_tag_id\":\"0\",\"timestamp_millisecond\":1459137333190.0,\"user_id\":\"84EB185C9F5A\",\"x_millimeter\":44937,\"y_millimeter\":24413,\"compass\":300,\"alarm\":false},"
//					+ "{\"accuracy\":4.0,\"build_id\":\"26000\",\"error_code\":0,\"floor_id\":4,\"info\":\"\",\"nearest_tag_id\":\"0\",\"timestamp_millisecond\":1459137333190.0,\"user_id\":\"84EB185C9F5B\",\"x_millimeter\":44937,\"y_millimeter\":24413,\"compass\":300,\"alarm\":false}]";
			
			
			
			//创建一个Gson对象
			Gson gson = new Gson();
			//创建一个JsonParser
			JsonParser parser = new JsonParser();
			//通过JsonParser对象可以把json格式的字符串解析成一个JsonElement对象
			JsonElement el = parser.parse(json);
			//
			JsonObject jObject = el.getAsJsonObject();
			
//			String jString = jObject.get("data").toString();
//			System.out.println(jString);
			JsonElement jElement = jObject.get("data");
			//把JsonElement对象转换成JsonArray
			JsonArray jsonArray = null;
			
			if(jElement.isJsonArray()){
				System.out.println("yes");
				jsonArray = jElement.getAsJsonArray();
			}

			//创建一个BaseDao对象，往数据库写入POJO
			BaseDAO<User_info> baseDAO = new BaseDAO<>();
			
			//遍历JsonArray对象
			User_info user_info = null;
			System.out.println(jsonArray.toString());
			Iterator it = jsonArray.iterator();
			while(it.hasNext()){
				JsonElement jsonElement = (JsonElement) it.next();
				String str = jsonElement.getAsString();
				System.out.println(str);
				
				JsonElement e = parser.parse(str);
				
				//JsonElement转换为JavaBean对象
				user_info = gson.fromJson(e, User_info.class);
				baseDAO.create(user_info);
				System.out.println(user_info.getUser_id()+" === "+user_info.getTimestamp_millisecond());
			}
			
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}

