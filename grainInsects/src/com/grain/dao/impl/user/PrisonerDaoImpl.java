package com.grain.dao.impl.user;

import java.util.List;

import org.springframework.stereotype.Repository;
import com.grain.dao.impl.BaseDaoImpl;
import com.grain.dao.user.PrisonerDao;
import com.grain.entity.Prisoner;


@Repository("prisonerDaoImpl")
public class PrisonerDaoImpl extends BaseDaoImpl<Prisoner, String> implements PrisonerDao {

	@Override
	public List<Prisoner> findAll() {
		// TODO Auto-generated method stub
			/*CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
			CriteriaQuery<Prisoner> criteriaQuery = criteriaBuilder.createQuery(Prisoner.class);
			return entityManager.createQuery(criteriaQuery).setFlushMode(FlushModeType.COMMIT).getResultList();*/
			return findAll1();
	}
}
