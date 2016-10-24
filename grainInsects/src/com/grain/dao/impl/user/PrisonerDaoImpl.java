package com.grain.dao.impl.user;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.grain.dao.impl.BaseDaoImpl;
import com.grain.dao.user.PrisonerDao;
import com.grain.entity.Prisoner;


@Repository("prisonerDaoImpl")
public class PrisonerDaoImpl extends BaseDaoImpl<Prisoner, String> implements PrisonerDao {

	@Override
	public List<Prisoner> findAll(String table, String param) {
		// TODO Auto-generated method stub
			if(table.equals("realtime")){
			if(param.equals("all")){
				return list("from Prisoner");
			}else{
				System.out.println("Not all prisoners!!!");
			}
		}else{
			System.out.println("Not realtime table!!!");
		}
			return null;
	}

}
