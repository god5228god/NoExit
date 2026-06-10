package com.noexit.app.service;

import java.nio.charset.StandardCharsets;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ClassPathResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import com.noexit.app.model.CancelMailDTO;

import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class MailService {

	// spring-boot-starter-mail 의존성 추가하면 자동으로 빈 등록 해 줌
	// 메일 발송 담당 
	private final JavaMailSender mailSender;
		
	// application.yml에 있는 값을 꺼내서 필드에 주입 
	@Value("${spring.mail.username}")
	private String fromEmail;
	
	
	// 메일 비동기 처리
	@Async
	public void sendCancelMail(CancelMailDTO dto) {
		
		try {
			
			// cancelMail.html에 구성해 둔 이름들 치환
			String content = loadTemplate("mail/cancelMail.html")
					.replace("{NAME}", dto.getName())
					.replace("{PARTY_NAME}", dto.getPartyName())
					.replace("{ROOM_NAME}", dto.getRoomName())
					.replace("{OPEN_AT}", dto.getOpenAt());
			
			// 빈 메일 객체 생성
			MimeMessage message = mailSender.createMimeMessage();
			
			// 수신자/제목/내용 세팅 도우미
			MimeMessageHelper helper = new MimeMessageHelper(message, false, "UTF-8");
			
			helper.setFrom(fromEmail, "NoExit");
			helper.setTo(dto.getEmail());
			//helper.setTo("god5228god@naver.com");
			helper.setSubject("[NoExit] 예약이 취소되었습니다.");
			helper.setText(content, true);	//-- true: HTML
			
			// 담아 놓은 내용 실제 전송
			mailSender.send(message);
			
		} catch (Exception e) {
			log.error("sendCancelMail: ",e);
		}
		
	}
	
	// resources/mail/cancelMail.html 파일을 읽어서 문자열로 변환해서 반환하는 메소드
	private String loadTemplate(String path) throws Exception{
		
		// src/main/resources/기준으로 파일 읽기
		ClassPathResource resource = new ClassPathResource(path);
		return new String(resource.getInputStream().readAllBytes(), StandardCharsets.UTF_8);
	}
	
	@Async
	public void sendUserIdMail(String email, String userId)
	{
	    try
	    {
	        MimeMessage message = mailSender.createMimeMessage();

	        MimeMessageHelper helper =
	                new MimeMessageHelper(message, false, "UTF-8");

	        helper.setFrom(fromEmail, "NoExit");
	        helper.setTo(email);

	        helper.setSubject("[NoExit] 아이디 찾기 결과");

	        helper.setText(
	                "<h3>회원님의 아이디입니다.</h3>"
	                + "<p><b>" + userId + "</b></p>", true);

	        mailSender.send(message);
	    }
	    catch (Exception e)
	    {
	        log.error("sendUserIdMail", e);
	    }
	}


	// 비밀번호 찾기 인증번호 메일
	public void sendAuthCodeMail(String email, String authCode) {

		try {
			MimeMessage message = mailSender.createMimeMessage();

			MimeMessageHelper helper =
					new MimeMessageHelper(message, false, "UTF-8");

			helper.setFrom(fromEmail, "NoExit");
			helper.setTo(email);

			helper.setSubject("[NoExit] 비밀번호 찾기 인증번호");

			helper.setText(
					"<h3>인증번호를 입력해주세요.</h3>"
					+ "<p><b>" + authCode + "</b></p>", true);

			mailSender.send(message);

		} catch (Exception e) {
			log.error("sendAuthCodeMail", e);
		}
	}


}
