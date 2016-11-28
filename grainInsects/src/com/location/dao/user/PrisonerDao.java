package com.location.dao.user;

import java.util.List;

import com.grain.dao.BaseDao;
import com.location.entity.Prisoner;

public interface PrisonerDao extends BaseDao<Prisoner, String> {
		public List<Prisoner> findAll();
}
