package kr.co.shop.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface LoginMapper {
	public int loginOk(String userid, String pwd);
}
