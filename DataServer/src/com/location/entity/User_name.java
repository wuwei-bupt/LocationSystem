package com.location.entity;


@SuppressWarnings("serial")
public class User_name implements java.io.Serializable {
	
	private String id_card;
	private String user_name;
	private User_info user_info;
	public User_name() {
		//super();
		// TODO Auto-generated constructor stub
	}
	public String getId_card() {
		return id_card;
	}
	public void setId_card(String id_card) {
		this.id_card = id_card;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public User_info getUser_info() {
		return user_info;
	}
	public void setUser_info(User_info user_info) {
		this.user_info = user_info;
	}
	
	
}
