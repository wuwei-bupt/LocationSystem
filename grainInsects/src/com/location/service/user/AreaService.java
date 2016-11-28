package com.location.service.user;

import com.grain.service.BaseService;
import com.location.entity.Area;

public interface AreaService extends BaseService<Area, String> {
	Area findByName(String areaName);
}
