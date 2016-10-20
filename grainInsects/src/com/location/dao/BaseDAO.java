package com.location.dao;

import java.io.Serializable;
import java.util.List;

public interface BaseDAO<T> {
	void create(T object);
	void update(T object);
	void delete(T object);
	T find(Class<? extends T> clazz, Serializable id);
	List<T> list(String hql);
}
