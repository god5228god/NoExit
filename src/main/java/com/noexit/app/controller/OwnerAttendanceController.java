package com.noexit.app.controller;

import com.noexit.app.common.AuthUtil;
import com.noexit.app.model.AttendCrew;
import com.noexit.app.model.AttendForm;
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

        // 완성 : 모든 파티원 체크 끝
        // 진행중 : 일부만 체크
        List<Long> doneList = new ArrayList<>();
        List<Long> partialList = new ArrayList<>();

        @SuppressWarnings("unchecked")
        List<AttendItemDTO> draftList = (List<AttendItemDTO>) session.getAttribute("attendDraft");
        if (draftList != null) {

            // 중복 없는 reservationId 가져오기
            List<Long> resIds = new ArrayList<>();
            for (AttendItemDTO d : draftList) {
                if (!resIds.contains(d.getReservationId())) {
                    resIds.add(d.getReservationId());
                }
            }

            // 예약별로 draft 개수와 TOTAL_MEMBER 비교
            for (Long rid : resIds) {
                int draftCount = 0;
                for (AttendItemDTO d : draftList) {
                    if (rid.equals(d.getReservationId())) draftCount++;
                }

                int total = 0;
                for (AttendanceListDTO a : attendList) {
                    if (rid.equals(a.getReservationId())) {
                        total = a.getTotalMember();
                        break;
                    }
                }
                if (draftCount >= total) {
                    doneList.add(rid);
                } else {
                    partialList.add(rid);
                }
            }
        }
        model.addAttribute("doneList", doneList);
        model.addAttribute("partialList", partialList);
        model.addAttribute("attendList", attendList);
        return "owner/attendance";
    }

    @GetMapping("/check")
    public String check(@RequestParam(name = "reservationId") Long reservationId,
                        HttpSession session, Model model) {
        String redirect = AuthUtil.checkStaff(session);
        if (redirect != null) 
        	return redirect;
        
        List<AttendCrew> crewList = attendanceService.selectCrewByReservationId(reservationId);

        // 이전 선택값 복원
        @SuppressWarnings("unchecked")
        List<AttendItemDTO> drafts = (List<AttendItemDTO>) session.getAttribute("attendDraft");
        if (drafts != null && crewList != null) {
            for (AttendCrew c : crewList) {
                for (AttendItemDTO d : drafts) {
                    if (reservationId.equals(d.getReservationId())
                        && c.getUserId().equals(d.getUserId())) {
                        c.setAttendStatusId(d.getAttendStatusId());
                        break;
                    }
                }
            }
        }

        model.addAttribute("reservationId", reservationId);
        model.addAttribute("crewList", crewList);
        return "owner/attendanceCheck";
    }

    // 개별 출석체크 임시저장 (세션 누적)
    @PostMapping("/saveDraft")
    public String saveDraft(AttendForm form, HttpSession session) {
        String redirect = AuthUtil.checkStaff(session);
        if (redirect != null) return redirect;

        try {
            attendanceService.saveDraft(form, session);
        } catch (Exception e) {
            log.info("saveDraft : ", e);
        }
        return "redirect:/owner/attendance";
    }

    // 최종확인 : ATTENDANCE + ATTENDANCE_DETAIL INSERT
    @PostMapping("/finalize")
    public String finalizeAttend(HttpSession session) {
        String redirect = AuthUtil.checkStaff(session);
        if (redirect != null) return redirect;

        try {
            User loginUser = (User) session.getAttribute("loginUser");
            attendanceService.finalizeAttendance(session, loginUser.getUserId());
        } catch (Exception e) {
            log.info("finalize : ", e);
        }
        return "redirect:/owner/attendance";
    }

}