package com.location.dao.Impl.device;


import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import com.location.dao.Impl.BaseDAOImpl;
import com.location.dao.device.Device_infoDAO;
import com.location.entity.Device_info;

public class Device_infoDAOImpl extends BaseDAOImpl<Device_info> implements Device_infoDAO {

	
	@Override
	/**@param user_info用户对象
	 * @param scale 比例尺  毫米数:像素
	 * 
	 */
	public Integer[] locationTransfer(Device_info device_info,int scale) {
		// TODO Auto-generated method stub
		Integer[] location=new Integer[2];
		location[0]=device_info.getX_millimeter()/scale;
		location[1]=device_info.getY_millimeter()/scale;
		return location;
		
	}
	@Override
	public Map<String, Integer[]> locationsTransfer(Set<Device_info> sets,
			int scale) {
		// TODO Auto-generated method stub
		Map<String,Integer[]> maps=new HashMap<String,Integer[]>();
		Device_info device_info=new Device_info();
		Iterator<Device_info> iterator=sets.iterator();
		while(iterator.hasNext()){
			device_info=iterator.next();
			maps.put(device_info.getDevice_id(), locationTransfer(device_info, scale));
		}
		return maps;
	}

}
