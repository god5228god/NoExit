package com.noexit.app.controller;

import com.noexit.app.common.AuthUtil;
import com.noexit.app.model.AttendItemDTO;
import com.noexit.app.model.AttendanceListDTO;
import com.noexit.app.model.User;
import com.noexit.app.service.AttendanceService;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/owner/attendance")
public class OwnerAttendanceController {

    private final AttendanceService attendanceService;

    @GetMapping("") // 출석체크
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

        List<Long> doneList = new ArrayList<>();
        List<AttendanceListDTO> draftList = (List<AttendanceListDTO>) session.getAttribute("attendDraft");
        if (draftList != null) {
            for (AttendanceListDTO dto : draftList) {
                if (!doneList.contains(dto.getReservationId())) {
                    doneList.add(dto.getReservationId());
                }
            }
        }
        model.addAttribute("doneList", doneList);
        model.addAttribute("attendList", attendList);
        return "owner/attendance";
    }

    @GetMapping("/check")
    public String check(@RequestParam(name = "reservationId") Long reservationId,
                        HttpSession session, Model model) {
        String redirect = AuthUtil.checkStaff(session);
        if (redirect != null) return redirect;

        model.addAttribute("reservationId", reservationId);
        model.addAttribute("crewList", attendanceService.selectCrewByReservationId(reservationId));
        return "owner/attendanceCheck";
    }
    



}