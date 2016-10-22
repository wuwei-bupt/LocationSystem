package com.location.dao.user;

import java.util.Map;
import java.util.Set;

import com.location.dao.BaseDAO;
import com.location.entity.User_info;

public interface User_infoDAO extends BaseDAO<User_info>{
	Integer[] locationTransfer(User_info user_info,int scale);
	Map<String, Integer[]> locationsTransfer(Set<User_info> sets,int scale);
}
