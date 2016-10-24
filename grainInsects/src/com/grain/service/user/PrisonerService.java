package com.grain.service.user;
import java.util.List;

import com.grain.entity.Prisoner;
import com.grain.service.BaseService;

public interface PrisonerService extends BaseService<Prisoner, String> {
	
	List<Prisoner> findByParam(String table, String choice);

}
