package com.location.dao.Impl.user;


import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import com.location.dao.Impl.BaseDAOImpl;
import com.location.dao.user.User_infoDAO;
import com.location.entity.User_info;

public class User_infoDAOImpl extends BaseDAOImpl<User_info> implements User_infoDAO {

	
	@Override
	/**@param user_info用户对象
	 * @param scale 比例尺  毫米数:像素
	 * 
	 */
	public Integer[] locationTransfer(User_info user_info,int scale) {
		// TODO Auto-generated method stub
		Integer[] location=new Integer[2];
		location[0]=user_info.getX_millimeter()/scale;
		location[1]=user_info.getY_millimeter()/scale;
		return location;
		
	}
	@Override
	public Map<String, Integer[]> locationsTransfer(Set<User_info> sets,
			int scale) {
		// TODO Auto-generated method stub
		Map<String,Integer[]> maps=new HashMap<String,Integer[]>();
		User_info user_info=new User_info();
		Iterator<User_info> iterator=sets.iterator();
		while(iterator.hasNext()){
			user_info=iterator.next();
			maps.put(user_info.getUser_id(), locationTransfer(user_info, scale));
		}
		return maps;
	}

}
