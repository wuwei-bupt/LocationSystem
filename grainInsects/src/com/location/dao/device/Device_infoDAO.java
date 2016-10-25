package com.location.dao.device;

import java.util.Map;
import java.util.Set;

import com.location.dao.BaseDAO;
import com.location.entity.Device_info;

public interface Device_infoDAO extends BaseDAO<Device_info>{
	Integer[] locationTransfer(Device_info user_info,int scale);
	Map<String, Integer[]> locationsTransfer(Set<Device_info> sets,int scale);
}
