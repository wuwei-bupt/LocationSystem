package com.grain.dao.user;

import java.util.List;

import com.grain.dao.BaseDao;
import com.grain.entity.Prisoner;

public interface PrisonerDao extends BaseDao<Prisoner, String> {
		public List<Prisoner> findAll(String table, String param);
}
