package com.grain.service.impl.user;

import org.springframework.stereotype.Service;

import com.grain.service.BaseService;
import com.grain.service.impl.BaseServiceImpl;
import com.location.entity.Device;

@Service("deviceServiceImpl")
public class DeviceServiceImpl extends BaseServiceImpl<Device, String> implements BaseService<Device, String> {
}
