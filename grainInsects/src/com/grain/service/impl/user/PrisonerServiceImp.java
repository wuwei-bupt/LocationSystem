package com.grain.service.impl.user;

import java.util.List;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.grain.dao.user.PrisonerDao;
import com.grain.entity.Prisoner;
import com.grain.service.impl.BaseServiceImpl;
import com.grain.service.user.PrisonerService;

@Service("prisonerServiceImpl")
public class PrisonerServiceImp extends BaseServiceImpl<Prisoner, String> implements PrisonerService {
	
	@Resource(name = "prisonerDaoImpl")
	private PrisonerDao prisonerDao;
	

	@Override
	public List<Prisoner> findByParam(String choice) {
		// TODO Auto-generated method stub
		if(choice == "all"){
			return prisonerDao.findAll();
		}else{
			return null;
		}
	}
}
