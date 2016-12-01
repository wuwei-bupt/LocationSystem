package com.location.dao.Impl.user;


import javax.persistence.FlushModeType;
import javax.persistence.NoResultException;

import org.springframework.stereotype.Repository;

import com.grain.dao.impl.BaseDaoImpl;
import com.location.dao.user.UserInfoDao;
import com.location.entity.UserInfo;

@Repository("userInfoDAOImpl")
public class UserInfoDaoImpl extends BaseDaoImpl<UserInfo,String> implements UserInfoDao {

	@Override
	public UserInfo findByDeviceID(int deviceID) {

		try{
			String jpql = "select userInfo from UserInfo userInfo where lower(userInfo.device_id) = lower(:device_id)";
			return entityManager.createQuery(jpql, UserInfo.class).setFlushMode(FlushModeType.COMMIT).setParameter("device_id", deviceID).getSingleResult();
		}catch(NoResultException e) {
			return null;
		}
	}

	
//	@Override
//	/**@param user_info用户对象
//	 * @param scale 比例尺  毫米数:像素
//	 * 
//	 */
//	public Integer[] locationTransfer(UserInfo user_info,int scale) {
//		// TODO Auto-generated method stub
//		Integer[] location=new Integer[2];
//		location[0]=user_info.getX_millimeter()/scale;
//		location[1]=user_info.getY_millimeter()/scale;
//		return location;
//		
//	}
//	@Override
//	public Map<String, Integer[]> locationsTransfer(Set<UserInfo> sets,
//			int scale) {
//		// TODO Auto-generated method stub
//		Map<String,Integer[]> maps=new HashMap<String,Integer[]>();
//		UserInfo user_info=new UserInfo();
//		Iterator<UserInfo> iterator=sets.iterator();
//		while(iterator.hasNext()){
//			user_info=iterator.next();
//			maps.put(user_info.getUser_id(), locationTransfer(user_info, scale));
//		}
//		return maps;
//	}

}
