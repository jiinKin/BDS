package com.dowon.bds.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.AsyncHandlerInterceptor;

import lombok.extern.slf4j.Slf4j;


/**
 * 
 * @author 박하은
 * @since 2023.09.06
 * 로그인 Session 확인 Interceptor
 * 로그인 상태에서만 호출되는 페이지를 interceptor
 *
 */

@Slf4j
public class LoginCheckInterceptor implements AsyncHandlerInterceptor {

//	@Override
//		public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
//				throws Exception {
//		log.info("LoginCheckInterceptor preHandle 로그인Session확인 후 존재하면 true, 아니면 false,로그아웃");
//		if(request.getSession().getAttribute(/*"로그인정보"*/) == null){
//			log.info("LoginCheckInterceptor preHandle 로그인Session확인-로그인 정보 없음");
//			response.sendRedirect(/*"로그아웃컨트롤러"*/);
//			return false;
//		}
//		return true;
//		}
}
