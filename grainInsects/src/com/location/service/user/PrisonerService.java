package com.location.service.user;
import java.util.List;

import com.grain.service.BaseService;
import com.location.entity.Prisoner;

public interface PrisonerService extends BaseService<Prisoner, String> {
	
	List<Prisoner> findByParam(String choice);

}
