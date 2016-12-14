package com.location.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import oracle.net.aso.p;
@SuppressWarnings("serial")
@Entity
@Table(name = "ls_user_info")
public class UserInfo implements Serializable{
	private int user_id;
	private String user_code;
	private String user_name;
	private double stop_time;
	private double start_time;
	private int device_id;
	private int group_id;
	private int region_id;	
	private String headimage;
	private Date createtime;
	private int state;
	@Id
	@Column(name="user_id",unique=true,nullable=false)
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	@Column(name="user_code",unique=true,nullable=false)
	public String getUser_code() {
		return user_code;
	}
	public void setUser_code(String user_code) {
		this.user_code = user_code;
	}
	@Column(name="user_name")
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	@Column(name="stop_time")
	public double getStop_time() {
		return stop_time;
	}
	public void setStop_time(double stop_time) {
		this.stop_time = stop_time;
	}
	@Column(name="start_time")
	public double getStart_time() {
		return start_time;
	}
	public void setStart_time(double start_time) {
		this.start_time = start_time;
	}
	@Column(name="device_id")
	public int getDevice_id() {
		return device_id;
	}
	public void setDevice_id(int device_id) {
		this.device_id = device_id;
	}
	@Column(name="group_id")
	public int getGroup_id() {
		return group_id;
	}
	public void setGroup_id(int group_id) {
		this.group_id = group_id;
	}
	@Column(name="region_id")
	public int getRegion_id() {
		return region_id;
	}
	public void setRegion_id(int region_id) {
		this.region_id = region_id;
	}
	@Column(name="headimage",nullable=false)
	public String getHeadimage() {
		return headimage;
	}
	public void setHeadimage(String headimage) {
		this.headimage = headimage;
	}
	@Column(name="createtime",nullable=false)
	public Date getCreatetime() {
		return createtime;
	}
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	@Column(name="state",nullable=false)
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	

}
