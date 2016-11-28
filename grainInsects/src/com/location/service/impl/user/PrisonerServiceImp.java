package com.location.service.impl.user;

import java.util.List;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.grain.service.impl.BaseServiceImpl;
import com.location.dao.user.PrisonerDao;
import com.location.entity.Prisoner;
import com.location.service.user.PrisonerService;

@Service("prisonerServiceImpl")
public class PrisonerServiceImp extends BaseServiceImpl<Prisoner, String> implements PrisonerService {
	
	@Resource(name = "prisonerDaoImpl")
	private PrisonerDao prisonerDao;
	

	@Override
	public List<Prisoner> findByParam(String choice) {
		// TODO Auto-generated method stub
		if(choice.equals("all")){
			return prisonerDao.findAll();
		}else{
			return null;
		}
	}
}
