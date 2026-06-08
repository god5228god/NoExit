package com.noexit.app.controller;

import com.noexit.app.common.AuthUtil;
import com.noexit.app.model.AttendanceListDTO;
import com.noexit.app.model.User;
import com.noexit.app.service.AttendanceService;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/owner/attendance")
public class OwnerAttendanceController {

    private final AttendanceService attendanceService;

    @GetMapping
    public String attendance(HttpSession session, Model model) {
        String redirect = AuthUtil.checkStaff(session);
        if (redirect != null) return redirect;

        User loginUser = (User) session.getAttribute("loginUser");
        String role = (String) session.getAttribute("role");

        List<AttendanceListDTO> attendList = null;
        
        if ("OWNER".equals(role)) {
            attendList = attendanceService.selectListByOwnerUserId(loginUser.getUserId());
        } else {
            attendList = attendanceService.selectListByManagerUserId(loginUser.getUserId());
        }

        model.addAttribute("attendList", attendList);
        return "owner/attendance";
    }

    @PostMapping("/attend")
    public String attend(AttendanceListDTO dto, HttpSession session) {
        String redirect = AuthUtil.checkStaff(session);
        if (redirect != null) return redirect;

        User loginUser = (User) session.getAttribute("loginUser");
        dto.setUserId(loginUser.getUserId());

        try {
            attendanceService.attend(dto);
        } catch (Exception e) {
            log.info("attend : ", e);
        }
        return "redirect:/owner/attendance";
    }
}