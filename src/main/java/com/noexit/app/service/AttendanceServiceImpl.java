package com.noexit.app.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.noexit.app.mapper.AttendanceMapper;
import com.noexit.app.model.AttendanceListDTO;
import com.noexit.app.model.AttendCrew;
import com.noexit.app.model.AttendForm;
import com.noexit.app.model.AttendItemDTO;
import com.noexit.app.model.Manner;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class AttendanceServiceImpl implements AttendanceService {

	private final AttendanceMapper mapper;


	@Override
	public List<AttendanceListDTO> selectListByOwnerUserId(Long ownerUserId) {

		List<AttendanceListDTO> list = null;

		try {
			list = mapper.selectListByOwnerUserId(ownerUserId);
		} catch (Exception e) {
			log.info("selectListByOwnerUserId : ", e);
		}

		return list;
	}

	@Override
	public List<AttendanceListDTO> selectListByManagerUserId(Long managerUserId) {

		List<AttendanceListDTO> list = null;

		try {
			list = mapper.selectListByManagerUserId(managerUserId);
		} catch (Exception e) {
			log.info("selectListByManagerUserId : ", e);
		}

		return list;
	}

	@Override
	public List<AttendCrew> selectCrewByReservationId(Long reservationId) {

		List<AttendCrew> list = null;

		try {
			list = mapper.selectCrewByReservationId(reservationId);
		} catch (Exception e) {
			log.info("selectCrewByReservationId : ", e);
		}

		return list;
	}

	@Override
	public void attendAll(List<AttendanceListDTO> list, Long staffUserId) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public boolean isCheckable(Long reservationId) {
		// TODO Auto-generated method stub
		return false;
	}


	// 개별 출석체크 임시저장
	@Override
	public void saveDraft(AttendForm form, HttpSession session) throws Exception {

		try {
			@SuppressWarnings("unchecked")
			List<AttendItemDTO> drafts = (List<AttendItemDTO>) session.getAttribute("attendDraft");
			if (drafts == null) drafts = new ArrayList<>();

			// 같은 예약의 이전 draft 제거
			List<AttendItemDTO> newDrafts = new ArrayList<>();
			for (AttendItemDTO d : drafts) {
				if (!form.getReservationId().equals(d.getReservationId())) {
					newDrafts.add(d);
				}
			}

			// 이번 폼 항목 누적 (미정은 스킵)
			for (int i = 0; i < form.getUserIds().size(); i++) {
				Long statusId = form.getAttendStatusIds().get(i);
				if (statusId == null) continue;

				AttendItemDTO item = new AttendItemDTO();
				item.setReservationId(form.getReservationId());
				item.setUserId(form.getUserIds().get(i));
				item.setAttendStatusId(statusId);
				newDrafts.add(item);
			}

			session.setAttribute("attendDraft", newDrafts);

		} catch (Exception e) {
			log.info("saveDraft : ", e);
			throw e;
		}
	}


	// 최종확인 : ATTENDANCE + ATTENDANCE_DETAIL INSERT
	@Override
	@Transactional(rollbackFor = Exception.class)
	public void finalizeAttendance(HttpSession session, Long staffUserId) throws Exception {

		try {
			@SuppressWarnings("unchecked")
			List<AttendItemDTO> drafts = (List<AttendItemDTO>) session.getAttribute("attendDraft");
			if (drafts == null || drafts.isEmpty()) return;

			// 중복 없는 reservationId 모으기
			List<Long> resIds = new ArrayList<>();
			for (AttendItemDTO d : drafts) {
				if (!resIds.contains(d.getReservationId())) {
					resIds.add(d.getReservationId());
				}
			}

			// 예약별 처리
			for (Long reservationId : resIds) {

				// 스케줄러가 먼저 박은 경우 스킵
				if (mapper.selectAttendanceExists(reservationId) > 0) continue;

				// ATTENDANCE 1행
				AttendItemDTO head = new AttendItemDTO();
				head.setReservationId(reservationId);
				head.setUserId(staffUserId);
				mapper.insertAttendance(head);

				// ATTENDANCE_DETAIL N행
				for (AttendItemDTO it : drafts) {
					if (!reservationId.equals(it.getReservationId())) continue;

					it.setAttendanceId(head.getAttendanceId());
					mapper.insertAttendDetailByUser(it);

					// 노쇼면 매너온도 차감
					if (it.getAttendStatusId() != null && it.getAttendStatusId() == 2L) {
						Manner m = new Manner();
						m.setUserId(it.getUserId());
						mapper.callInsertNoshow(m);
					}
				}
			}

			session.removeAttribute("attendDraft");

		} catch (Exception e) {
			log.info("finalizeAttendance : ", e);
			throw e;
		}
	}

}
