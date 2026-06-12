package com.noexit.app.interceptor;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.noexit.app.model.User;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Component
public class LoginInterceptor implements HandlerInterceptor  {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session =  request.getSession();
		User loginUser = (User) session.getAttribute("loginUser");
		
		// 로그인 체크
		if(loginUser == null || loginUser.getUserId()==null) {
			// 로그인 페이지로 이동
			response.sendRedirect("/user/login");
			// 컨트롤러로 진입하지 않음
			return false;
		}
		
		// 세션이 있으면 컨트롤러로 진입 통과
		return true;
	}


	
}
