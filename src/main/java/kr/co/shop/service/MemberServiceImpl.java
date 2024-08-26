package kr.co.shop.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import kr.co.shop.dto.MemberDTO;
import kr.co.shop.mapper.MemberMapper;

@Service
@Qualifier("ms2")
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberMapper mapper;

	@Override
	public String useridChk(String userid) {
		return mapper.useridChk(userid);
	}

	@Override
	public String memberOk(MemberDTO mdto) {
		mapper.memberOk(mdto);
		return "../login/login";
	}

	@Override
	public String member(HttpSession session) {
		if(session.getAttribute("userid")!=null) {
			return "redirect:../main/index";
		} else {
			return "/member/member";
		}
	}
}
