package com.grain.dao.impl.user;

import javax.persistence.FlushModeType;
import javax.persistence.NoResultException;

import org.springframework.stereotype.Repository;

import com.grain.dao.impl.BaseDaoImpl;
import com.grain.dao.user.DeviceDao;
import com.location.entity.Area;
import com.location.entity.Device;

@Repository("deviceDaoImpl")
public class DeviceDaoImpl extends BaseDaoImpl<Device, String>implements DeviceDao {

	@Override
	public Device findByName(String device_code) {
		if(device_code==null){
			return null;
		}
		try {
			String jpql = "select device from Device device where lower(device.devce_code) = lower(:device_code)";
			return entityManager.createQuery(jpql, Device.class).setFlushMode(FlushModeType.COMMIT).setParameter("device_code", device_code).getSingleResult();
		} catch (NoResultException e) {
			return null;
		}
	}

}
