package com.noexit.app.controller;

import com.noexit.app.common.AuthUtil;
import com.noexit.app.model.Manager;
import com.noexit.app.model.User;
import com.noexit.app.service.CafeService;
import com.noexit.app.service.ManagerService;
import com.noexit.app.service.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/owner/manager")
public class OwnerManagerController {

    private final ManagerService managerService;
    private final UserService userService;
    private final CafeService cafeService;

    @GetMapping // 매니저 관리
    public String manager(HttpSession session, Model model) {
        String redirect = AuthUtil.checkOwner(session);
        if (redirect != null) 
        return redirect;

        User loginUser = (User)session.getAttribute("loginUser");
        model.addAttribute("managerList", managerService.selectActiveByOwnerUserId(loginUser.getUserId()));
        return "owner/manager";
    }

    @GetMapping("/enroll")
    public String managerEnrollForm(HttpSession session, Model model) {
        String redirect = AuthUtil.checkOwner(session);
        if (redirect != null)
        	return redirect;

        User loginUser = (User) session.getAttribute("loginUser");
        model.addAttribute("cafeList", cafeService.selectByUserId(loginUser.getUserId()));
        return "owner/managerEnrollForm";
    }

    @PostMapping("/enroll")
    public String managerEnroll(@RequestParam("loginId") String loginId,
                                @RequestParam("cafeId")  Long cafeId,
                                HttpSession session, Model model) {
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

    @PostMapping("/deact")
    public String managerDeact(@RequestParam("cafeId") Long cafeId
                              , @RequestParam("userId") Long userId
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