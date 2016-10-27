package com.location.entity;


@SuppressWarnings("serial")
public class Device_info_history implements java.io.Serializable{
	//private String accuracy;
	private String build_id;
	private Integer error_code;
	private Integer floor_id;
	//private String info;
	private String nearest_tag_id;
	private Double timestamp_millisecond;
	private String user_id;
	private Integer x_millimeter;
	private Integer y_millimeter;
	//private Integer compass;
	private Boolean alarm;
	private String region_id;
	private String group_id;
	public Device_info_history() {
		//super();
		// TODO Auto-generated constructor stub
	}
	public String getBuild_id() {
		return build_id;
	}
	public void setBuild_id(String build_id) {
		this.build_id = build_id;
	}
	public Integer getError_code() {
		return error_code;
	}
	public void setError_code(Integer error_code) {
		this.error_code = error_code;
	}
	public Integer getFloor_id() {
		return floor_id;
	}
	public void setFloor_id(Integer floor_id) {
		this.floor_id = floor_id;
	}
	public String getNearest_tag_id() {
		return nearest_tag_id;
	}
	public void setNearest_tag_id(String nearest_tag_id) {
		this.nearest_tag_id = nearest_tag_id;
	}
	public Double getTimestamp_millisecond() {
		return timestamp_millisecond;
	}
	public void setTimestamp_millisecond(Double timestamp_millisecond) {
		this.timestamp_millisecond = timestamp_millisecond;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public Integer getX_millimeter() {
		return x_millimeter;
	}
	public void setX_millimeter(Integer x_millimeter) {
		this.x_millimeter = x_millimeter;
	}
	public Integer getY_millimeter() {
		return y_millimeter;
	}
	public void setY_millimeter(Integer y_millimeter) {
		this.y_millimeter = y_millimeter;
	}
	public Boolean getAlarm() {
		return alarm;
	}
	public void setAlarm(Boolean alarm) {
		this.alarm = alarm;
	}
	public String getRegion_id() {
		return region_id;
	}
	public void setRegion_id(String region_id) {
		this.region_id = region_id;
	}
	public String getGroup_id() {
		return group_id;
	}
	public void setGroup_id(String group_id) {
		this.group_id = group_id;
	}
	
	
}
