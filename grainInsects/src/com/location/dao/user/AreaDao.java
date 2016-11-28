package com.location.dao.user;

import com.grain.dao.BaseDao;
import com.location.entity.LsArea;

public interface AreaDao extends BaseDao<LsArea, String> {
public LsArea findByName(String areaName);
}
