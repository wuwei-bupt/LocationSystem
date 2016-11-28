package com.location.dao.Impl.user;

import javax.persistence.FlushModeType;
import javax.persistence.NoResultException;

import org.springframework.stereotype.Repository;

import com.grain.dao.impl.BaseDaoImpl;
import com.location.dao.user.DeviceInfoDao;
import com.location.entity.DeviceInfo;
@Repository("deviceInfoDaoImpl")

public class DeviceInfoDaoImpl extends BaseDaoImpl<DeviceInfo, String> implements DeviceInfoDao {

	@Override
	public DeviceInfo findByName(String device_mac) {
		if(device_mac == null){
			return null;
		}
		try {
			String jpql = "select deviceInfo from DeviceInfo deviceInfo where lower(deviceInfo.device_mac) = lower(:device_mac)";
			return entityManager.createQuery(jpql,DeviceInfo.class).setFlushMode(FlushModeType.COMMIT).setParameter("device_mac", device_mac).getSingleResult();
		} catch (NoResultException e) {
			return null;
		}
	}
}