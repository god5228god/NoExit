package com.noexit.app.service;

import java.util.List;
import java.util.Map;

import com.noexit.app.model.PartyApplyDTO;
import com.noexit.app.model.PartyCommentDTO;
import com.noexit.app.model.PartyCommentDeleteDTO;
import com.noexit.app.model.PartyCrewDTO;
import com.noexit.app.model.PartyDTO;
import com.noexit.app.model.ThemeSlotDTO;

public interface PartyService
{
	/*
	파티 목록 조회
	파티 정보 조회
	파티 신청 조회
	파티 신청
	
	테마 정보 조회
	
	파티 등록
	
	파티 정보 수정
	파티 해산
	
	파티 댓글 조회
	파티 댓글 작성
	파티 댓글 삭제
	
	파티원 조회
	파티 레디
	파티 탈퇴
	파티 강퇴
	
	파티 신청 조회
	파티 신청 승인
	파티 신청 거절
	*/
	
	List<PartyDTO> getPartyList(Map<String, Object> map);
	PartyDTO getPartyById(long partyId);
	int hasApply(PartyApplyDTO dto);
	int partyApply(PartyApplyDTO dto);
	
	ThemeSlotDTO getThemeById(long themeId);
	
	int partyInsert(PartyDTO dto);
	
	int partyUpdate(PartyDTO dto);
	int partyDelete(long partyId);
	
	List<PartyCommentDTO> getPartyCommentList(Map<String, Object> map);
	List<PartyCommentDeleteDTO> getCommentDeleteList(Map<String, Object> map);
	int partyCommentInsert(PartyCommentDTO dto);
	int partyCommentDelete(long commentId);
	
	List<PartyCrewDTO> getPartyCrewList(long partyId);
	int partyReady(long partyId);
	int partyOut(long applyId);
	int partyKick(long memberId);
	
	List<PartyApplyDTO> getPartyApplyList(long partyId);
	int aprvApply(long applyId);
	int rejectApply(long applyId);
	
}
