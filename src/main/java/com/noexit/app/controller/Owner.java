package com.noexit.app.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.noexit.app.common.AuthUtil;
import com.noexit.app.model.AttendanceListDTO;
import com.noexit.app.model.Manager;
import com.noexit.app.model.Manner;
import com.noexit.app.model.ThemeDTO;
import com.noexit.app.model.User;
import com.noexit.app.service.AttendanceService;
import com.noexit.app.service.CafeService;
import com.noexit.app.service.CommonService;
import com.noexit.app.service.GenreService;
import com.noexit.app.service.ManagerService;
import com.noexit.app.service.ThemeService;
import com.noexit.app.service.UserService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/owner/*")
public class Owner {

	private final CafeService cafeService;
	private final ThemeService themeService;
	private final GenreService genreService;
	private final CommonService commonService;
	private final ManagerService managerService;
	private final UserService userService;
	private final AttendanceService attendanceService;


	@GetMapping("/res/open")
	public String openReserv() {
		return "owner/openRes";
	}

	@GetMapping("/res/list")
	public String resList() {
		return "owner/resList";
	}

	// 테마 관리 (본인 카페 테마 리스트 — 사장만)
	@GetMapping("/theme/manage")
	public String themeManage(HttpSession session, Model model) {

		String redirect = AuthUtil.checkOwner(session);
		if (redirect != null)
			return redirect;

		User loginUser = (User) session.getAttribute("loginUser");
		model.addAttribute("themeList", themeService.selectListByOwnerUserId(loginUser.getUserId()));
		return "theme/themeManage";
	}

	// 테마 등록/수정 폼 (mode=write|update)
	@GetMapping("/theme/write")
	public String writeForm(@RequestParam(name = "mode") String mode,
	                        @RequestParam(name = "roomId", required = false) Long roomId,
	                        HttpSession session, Model model) {

		String redirect = AuthUtil.checkOwner(session);
		if (redirect != null)
			return redirect;

		User loginUser = (User) session.getAttribute("loginUser");
		model.addAttribute("cafeList",   cafeService.selectByUserId(loginUser.getUserId()));
		model.addAttribute("genreList",  genreService.getGenreList());
		model.addAttribute("commonList", commonService.getCommonList());
		model.addAttribute("mode", mode);

		if ("update".equals(mode) && roomId != null) {
			model.addAttribute("dto", themeService.getThemeById(roomId));
		}
		return "theme/themeWriteForm";
	}

	// 테마 등록/수정 처리
	@PostMapping("/theme/write")
	public String write(@RequestParam(name = "mode") String mode,
	                    ThemeDTO dto, HttpSession session, Model model) {

		String redirect = AuthUtil.checkOwner(session);
		if (redirect != null)
			return redirect;

		try {
			if ("update".equals(mode)) {
				themeService.themeUpdate(dto);
			} else {
				themeService.themeInsert(dto);
			}
		} catch (Exception e) {
			log.info("theme write (" + mode + ") : ", e);

			User loginUser = (User) session.getAttribute("loginUser");
			model.addAttribute("errorMessage", "테마 " + ("update".equals(mode) ? "수정" : "등록") + " 중 오류 발생");
			model.addAttribute("cafeList",   cafeService.selectByUserId(loginUser.getUserId()));
			model.addAttribute("genreList",  genreService.getGenreList());
			model.addAttribute("commonList", commonService.getCommonList());
			model.addAttribute("mode", mode);
			return "theme/themeWriteForm";
		}
		return "redirect:/owner/theme/manage";
	}


	// 출석체크
	@GetMapping("/attendance")
	public String attendance(HttpSession session, Model model) {
		String redirect = AuthUtil.checkStaff(session);
		if (redirect != null)
			return redirect;

		User loginUser = (User) session.getAttribute("loginUser");
		String role    = (String) session.getAttribute("role");

		List<AttendanceListDTO> attendList;
		if ("OWNER".equals(role)) {
			attendList = attendanceService.selectListByOwnerUserId(loginUser.getUserId());
		} else {
			attendList = attendanceService.selectListByManagerUserId(loginUser.getUserId());
		}

		model.addAttribute("attendList", attendList);
		return "owner/attendance";
	}

	// 출석/노쇼 처리 (출석체크 페이지에서 호출)
	@PostMapping("/attendance/attend")
	public String attend(AttendanceListDTO dto, HttpSession session) {
		String redirect = AuthUtil.checkStaff(session);
		if (redirect != null)
			return redirect;

		User loginUser = (User) session.getAttribute("loginUser");
		dto.setUserId(loginUser.getUserId());

		try {
			attendanceService.attend(dto);
		} catch (Exception e) {
			log.info("attend : ", e);
		}
		return "redirect:/owner/attendance";
	}

	// 노쇼 처리 (출석체크 페이지에서 호출)
	@PostMapping("/attendance/noshow")
	public String noshow(@RequestParam(name = "userId") Long userId
	                   , HttpSession session
	                   , RedirectAttributes ra) {
		String redirect = AuthUtil.checkStaff(session); 
		if (redirect != null) 
			return redirect;

		try {
			Manner result = attendanceService.noshow(userId);
			ra.addFlashAttribute("resultMessage", "노쇼 처리 완료. 매너온도: " + result.getNewTemp());
		} catch (Exception e) {
			log.info("noshow : ", e);
			ra.addFlashAttribute("resultMessage", "노쇼 처리 실패");
		}
		return "redirect:/owner/attendance";
	}


	// 매니저 목록
	@GetMapping("/manager")
	public String manager(HttpSession session, Model model) {
		String redirect = AuthUtil.checkOwner(session); 
		if (redirect != null) 
		return redirect;

		User loginUser = (User) session.getAttribute("loginUser");
		model.addAttribute("managerList", managerService.selectActiveByOwnerUserId(loginUser.getUserId()));
		return "owner/manager";
	}

	// 매니저 임명 폼
	@GetMapping("/manager/enroll")
	public String managerEnrollForm(HttpSession session, Model model) {
		
		String redirect = AuthUtil.checkOwner(session); if (redirect != null) return redirect;

		User loginUser = (User) session.getAttribute("loginUser");
		model.addAttribute("cafeList", cafeService.selectByUserId(loginUser.getUserId()));
		return "owner/managerEnrollForm";
	}

	// 매니저 임명 처리
	@PostMapping("/manager/enroll")
	public String managerEnroll(@RequestParam(name = "loginId") String loginId
	                          , @RequestParam(name = "cafeId")  Long cafeId
	                          , HttpSession session
	                          , Model model) {
		String redirect = AuthUtil.checkOwner(session); 
		if (redirect != null) 
			return redirect;

		User loginUser = (User) session.getAttribute("loginUser");
		User target = userService.selectByLoginId(loginId);

		if (target == null) {
			model.addAttribute("errorMessage", "해당 아이디의 회원이 없습니다.");
			model.addAttribute("cafeList", cafeService.selectByUserId(loginUser.getUserId()));
			return "owner/managerEnrollForm";
		}

		Manager manager = new Manager();
		manager.setCafeId(cafeId);
		manager.setUserId(target.getUserId());
		try {
			managerService.enroll(manager);
		} catch (Exception e) {
			log.info("managerEnroll : ", e);
		}
		return "redirect:/owner/manager";
	}

	// 매니저 해제
	@PostMapping("/manager/deact")
	public String managerDeact(@RequestParam(name = "cafeId") Long cafeId
	                         , @RequestParam(name = "userId") Long userId
	                         , HttpSession session) {
		String redirect = AuthUtil.checkOwner(session); 
		if (redirect != null) 
			return redirect;

		Manager manager = new Manager();
		manager.setCafeId(cafeId);
		manager.setUserId(userId);
		try {
			managerService.deact(manager);
		} catch (Exception e) {
			log.info("managerDeact : ", e);
		}
		return "redirect:/owner/manager";
	}
}
