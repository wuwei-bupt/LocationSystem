package com.grain.dao.impl.user;

import org.springframework.stereotype.Repository;

import com.grain.dao.impl.BaseDaoImpl;
import com.grain.dao.user.DeviceDao;
import com.location.entity.Device;

@Repository("deviceDaoImpl")
public class DeviceDaoImpl extends BaseDaoImpl<Device, String>implements DeviceDao {

}
