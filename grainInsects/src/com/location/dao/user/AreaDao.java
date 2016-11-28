package com.location.dao.user;

import com.grain.dao.BaseDao;
import com.location.entity.Area;

public interface AreaDao extends BaseDao<Area, String> {
public Area findByName(String areaName);
}
