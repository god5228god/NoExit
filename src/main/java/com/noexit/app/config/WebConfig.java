package com.noexit.app.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.noexit.app.interceptor.LoginInterceptor;

import lombok.RequiredArgsConstructor;

@Configuration
@RequiredArgsConstructor
public class WebConfig implements WebMvcConfigurer {

	private final LoginInterceptor loginInterceptor;

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		
		registry.addInterceptor(loginInterceptor)
				.addPathPatterns("/owner/**","/mypage/**", "/reservations/**")	// 인터셉터 적용 경로
				.excludePathPatterns("/"); // 인터셉터 제외 경로
		
		WebMvcConfigurer.super.addInterceptors(registry);
	}
	
	
	
	
}
