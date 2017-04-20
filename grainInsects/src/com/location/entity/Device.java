package com.location.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;


@SuppressWarnings("serial")
@Entity
@Table(name = "ls_device")
public class Device implements java.io.Serializable{
	private int device_id;
	private String device_mac;
	private String device_code;
	private Date createtime;
	private boolean isvalid;
	
	@Id
	@Column(name="device_id",unique = true, nullable = false)
	public int getDevice_id() {
		return device_id;
	}
	public void setDevice_id(int device_id) {
		this.device_id = device_id;
	}
	@Column(name = "device_mac", unique = true, nullable = false)
	public String getDevice_mac() {
		return device_mac;
	}
	public void setDevice_mac(String device_mac) {
		this.device_mac = device_mac;
	}
	@Column(name = "device_code",unique = true, nullable = false)
	public String getDevice_code() {
		return device_code;
	}
	public void setDevice_code(String device_code) {
		this.device_code = device_code;
	}
	@Column(name="createtime",nullable = false)
	public Date getCreatetime() {
		return createtime;
	}
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	@Column(name="isvalid",nullable = false)
	public boolean getIsvalid() {
		return isvalid;
	}
	public void setIsvalid(boolean isvalid) {
		this.isvalid = isvalid;
	}
}
