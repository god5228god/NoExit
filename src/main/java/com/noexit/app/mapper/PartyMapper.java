package com.noexit.app.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.noexit.app.model.Cafe;
import com.noexit.app.model.MyPartyDTO;
import com.noexit.app.model.PartyApplyDTO;
import com.noexit.app.model.PartyCommentDTO;
import com.noexit.app.model.PartyCommentDeleteDTO;
import com.noexit.app.model.PartyCrewDTO;
import com.noexit.app.model.PartyDTO;
import com.noexit.app.model.ThemeDTO;
import com.noexit.app.model.ThemeSlotDTO;

@Mapper
public interface PartyMapper
{
	List<PartyDTO> getPartyList(Map<String, Object> map);
	PartyDTO getPartyById(long partyId);
	int hasApply(PartyApplyDTO dto);
	int partyApply(PartyApplyDTO dto);
	
	ThemeSlotDTO getThemeSlotById(long themeId);
	
	int partyInsert(PartyDTO dto);
	
	int partyUpdate(PartyDTO dto);
	int partyDelete(long partyId);
	
	List<PartyCommentDTO> getPartyCommentList(Map<String, Object> map);
	List<PartyCommentDeleteDTO> getCommentDeleteList(Map<String, Object> map); 
	int partyCommentInsert(PartyCommentDTO dto);
	int partyCommentDelete(long commentId);
	PartyCommentDTO getCommentById(long commentId);
	
	List<PartyCrewDTO> getPartyCrewList(long partyId);
	int partyReady(long applyId);
	int partyOut(long applyId);
	int partyKick(long applyId);
	PartyCrewDTO getPartyCrewById(long crewId);
	
	List<PartyApplyDTO> getPartyApplyList(long partyId);
	int aprvApply(long applyId);
	int rejectApply(long applyId);
	PartyApplyDTO getPartyApplyById(long applyId);
	int isSameGender(Map<String, Object> map);
	Integer getUserAge(long userId);
	
	List<MyPartyDTO> getMyPartyApplyList(long userId);
	List<MyPartyDTO> getMyPartyList(long userId);
	List<MyPartyDTO> getMyPartyKickList(long userId);
	
	List<Cafe> getCafeList();
	List<ThemeDTO> getThemeList(long cafeId);
	List<ThemeSlotDTO> getSlotList(long themeId);
	List<ThemeSlotDTO> getTimeList(long slotId);
	int partyRoomUpdate(Map<String, Object> map);
	int hasReservation(Map<String, Object> map);
}
