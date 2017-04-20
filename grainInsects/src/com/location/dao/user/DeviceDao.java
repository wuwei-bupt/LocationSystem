package com.location.dao.user;

import com.grain.dao.BaseDao;
import com.location.entity.Device;

public interface DeviceDao extends BaseDao<Device, String> {
public Device findByName(String deviceCode);
}
