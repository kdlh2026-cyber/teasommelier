package com.springboot.teasommelier.auth;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import jakarta.servlet.DispatcherType;

@Configuration
public class WebSecurityConfig {
	
	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception{
		http.csrf((csrf) -> csrf.disable()) // CSRF 보호 비활성화
			.cors((cors) -> cors.disable()) // CORS 비활성화
			.authorizeHttpRequests(request -> request
					.dispatcherTypeMatchers(DispatcherType.FORWARD).permitAll() // 내부 포워드 요청 허용
					.requestMatchers("/","/main","/loginForm","/ShipaddrWrite","/MemberWrite","/passwordCheck").permitAll() // 루트(/)는 모두 허용
					.requestMatchers("/css/**","/js/**","/images/**","/error").permitAll() // 정적(static)리소스 모두 허용
					.requestMatchers("/guest/**").permitAll() // guest 폴더는 모두 허용(게스트 페이지)
					.requestMatchers("/member/**", "/member/mypage/**").hasAnyRole("USER","ADMIN") // member 폴더는 USER, ADMIN만 허용(회원페이지)
					.requestMatchers("/admin/**","/AdminMDelete").hasAnyRole("ADMIN") // admin 폴더는 ADMIN만 허용(관리자 페이지)
					.requestMatchers("/cart", "/cartList", "/insertCart", "/deleteCarts", "/clearCart").permitAll()
					.requestMatchers("/orderWrite", "/updateCartQty", "/orderSubmit", "/orderConfirm", "/orderWriteDirect").permitAll()
					.anyRequest().authenticated() //나머지 모두 인증이 필요	
			);
		
		//로그인
		http.formLogin((formLogin) -> formLogin
				.loginPage("/loginForm")
				.loginProcessingUrl("/j_spring_security_check")
				.failureUrl("/loginError") //로그인 실패했을때 페이지
				.defaultSuccessUrl("/") //로그인햇을때
				.usernameParameter("m_id")
				.passwordParameter("m_passwd")
				.permitAll()
		);
		//로그아웃
		http.logout((logout) -> logout
				.logoutUrl("/logout")
				.logoutSuccessUrl("/") //로그아웃이 성공하면
				.permitAll()
		);
		return http.build();
	}
	@Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}