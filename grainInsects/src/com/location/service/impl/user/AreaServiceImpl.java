package com.location.service.impl.user;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.grain.service.impl.BaseServiceImpl;
import com.location.dao.user.AreaDao;
import com.location.entity.Area;
import com.location.service.user.AreaService;
@Service("areaServiceImpl")
public class AreaServiceImpl extends BaseServiceImpl<Area, String> implements AreaService {

	@Resource(name="areaDaoImpl")
	private AreaDao areadao;
	@Resource(name="areaDaoImpl")
	public void setBaseDao(AreaDao areaDao) {
		super.setBaseDao(areaDao);
	}
	@Override
	@Transactional(readOnly = true)
	public Area findByName(String areaName) {
		// TODO Auto-generated method stub
		return areadao.findByName(areaName);
	}

}
