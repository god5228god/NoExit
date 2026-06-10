package com.noexit.app.controller;


import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.noexit.app.model.Evaluation;
import com.noexit.app.model.MyPage;
import com.noexit.app.model.User;
import com.noexit.app.service.AdminService;
import com.noexit.app.service.EvaluationService;
import com.noexit.app.service.MyPageService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
public class MyPageController {

	// 서비스 주입
	private final MyPageService service;
	private final EvaluationService evalService;

	@GetMapping("/mypage/*")
	public String mypage(HttpSession session, Model model)
	{
		// 세션 검증 
		User loginUser = (User) session.getAttribute("loginUser");
		
		// 세션 만료 시 로그인 페이지 리다이렉트
		if (loginUser == null || session.getAttribute("loginUser") == null)
		{
			return "redirect:/user/login";
		}
		
		
		List<MyPage> recordList = service.getUserRecord(loginUser.getUserId());
		List<MyPage> mutualList = service.getMutualList(loginUser.getUserId());
		List<String> questionList = service.getQuestionList();
		
		
		// 로그인 유저 정보 넘기기
		model.addAttribute("USER", loginUser);
		model.addAttribute("recordList", recordList);
		model.addAttribute("mutualList", mutualList);
		model.addAttribute("questionList", questionList);
		
		// 마이페이지로 리턴
		return "/mypage/record";
	}
	
	@PostMapping("/mypage/evaluation/write")
	@ResponseBody
	public String writeEvaluation(@RequestBody Map<String, Object> data, HttpSession session)
	{
		User loginUser = (User) session.getAttribute("loginUser");
		
		// 세션 만료 시 로그인 페이지 리다이렉트
		if (loginUser == null || session.getAttribute("loginUser") == null)
		{
			return "redirect:/user/login";
		}
		
		// object 타입의 value를 추출해서 Long타입으로 변환
		Long detailId = Long.parseLong(data.get("detailId").toString());
	    Long targetId = Long.parseLong(data.get("targetId").toString());
		
	    // 2개의 컬럼 insert를 위한 객체 2개 생성
	    Evaluation eval1 = new Evaluation();
	    eval1.setDetailId(detailId); eval1.setTargetId(targetId);
	    eval1.setQuestionId(1L); 
	    eval1.setAnswerId(Long.parseLong(data.get("q1Answer").toString()));
	    
	    Evaluation eval2 = new Evaluation();
	    eval2.setDetailId(detailId); eval2.setTargetId(targetId);
	    eval2.setQuestionId(2L); 
	    eval2.setAnswerId(Long.parseLong(data.get("q2Answer").toString()));
	    
	    evalService.insertEvaluation(eval1, eval2);
	    
	    return "success";
	    
	}
		
}
	

