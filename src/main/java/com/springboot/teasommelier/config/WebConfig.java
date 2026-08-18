package com.springboot.teasommelier.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

// 대량주문 관리자 부분 (회원이 첨부파일 넣으면) 이미지 보이게 하기위해 작성함 
@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/images/inquiry/**")
                .addResourceLocations("file:///C:/teasommelier/src/main/resources/static/images/inquiry/");
    }
}
