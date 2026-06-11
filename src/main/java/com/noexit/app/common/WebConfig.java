package com.noexit.app.common;

import java.io.File;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;


@Configuration
public class WebConfig implements WebMvcConfigurer {

    
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		
		String uploadPath = new File("uploads").getAbsolutePath();
		//System.out.println("업로드 경로 : " + uploadPath);  
					
		registry.addResourceHandler("/uploads/**")
			    .addResourceLocations("file:///" + uploadPath + "/");
	}
}
