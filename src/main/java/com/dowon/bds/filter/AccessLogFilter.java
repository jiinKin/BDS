package com.dowon.bds.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class AccessLogFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		log.debug("Access로그 필터를 통한 WAS에 접속한 정보를 확인한다");
		
		HttpServletRequest req = (HttpServletRequest)request;
		
		String remoteAddr = req.getRemoteAddr();
		String uri = req.getRequestURI();
		//commons-lang3이나 guava 라이브러리를 사용하여 isBlank는 null판단, isEmpty는 길이만 판단
		String querystString = (req.getQueryString() == null)?"":req.getQueryString();
		
		String referer = StringUtils.defaultString(req.getHeader("Referer"),"-");
		String userAgent = StringUtils.defaultString(req.getHeader("User-Agent"),"-");
		
		log.debug("요청된 주소 : {}", remoteAddr.concat(":").concat(uri).concat("?").concat(querystString));
		log.debug("유입경로 : {}", referer);
		log.debug("유입소프트웨어정보 : {}", userAgent);
				
				
				
		chain.doFilter(req, response);

	}

}
