package com.noexit.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.noexit.app.mapper.PartyMapper;
import com.noexit.app.model.PartyApplyDTO;
import com.noexit.app.model.PartyCommentDTO;
import com.noexit.app.model.PartyCommentDeleteDTO;
import com.noexit.app.model.PartyCrewDTO;
import com.noexit.app.model.PartyDTO;
import com.noexit.app.model.ThemeSlotDTO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class PartyServiceImpl implements PartyService
{
	private final PartyMapper mapper;
	
	@Override
	public List<PartyDTO> getPartyList(Map<String, Object> map)
	{
		List<PartyDTO> list = null;
		
		try
		{
			list = mapper.getPartyList(map);
		} 
		catch (Exception e)
		{
			log.info("getPartyList : ",e);
		}
		
		return list;
	}

	@Override
	public PartyDTO getPartyById(long partyId)
	{
		PartyDTO dto = null;
		
		try
		{
			dto = mapper.getPartyById(partyId);
		} 
		catch (Exception e)
		{
			log.info("getPartyById : ",e);
		}

		return dto;
	}

	@Override
	public int hasApply(PartyApplyDTO dto)
	{
		int count = 0;
		
		try
		{
			count = mapper.hasApply(dto);
		}
		catch (Exception e)
		{
			log.info("hasApply : ",e);
		}
		
		return count;
	}
	
	@Override
	public int partyApply(PartyApplyDTO dto)
	{
		int result = 0;
		
		try
		{
			result = mapper.partyApply(dto);
		} 
		catch (Exception e)
		{
			log.info("partyApply : ",e);
		}
		
		return result;
	}

	@Override
	public ThemeSlotDTO getThemeById(long themeId)
	{
		ThemeSlotDTO dto = null;
		
		try
		{
			dto = mapper.getThemeById(themeId);
		} 
		catch (Exception e)
		{
			log.info("getThemeById :",e);
		}
		
		return dto;
	}

	@Override
	public int partyInsert(PartyDTO dto)
	{
		int result = 0;
		
		try
		{
			result = mapper.partyInsert(dto);
		}
		catch (Exception e)
		{
			log.info("partyInsert : ",e);
		}
		
		return result;
	}

	@Override
	public int partyUpdate(PartyDTO dto)
	{
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int partyDelete(long partyId)
	{
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<PartyCommentDTO> getPartyCommentList(Map<String, Object> map)
	{
		List<PartyCommentDTO> list = null;
		
		try
		{
			list = mapper.getPartyCommentList(map);
		} 
		catch (Exception e)
		{
			log.info("getPartyCommentList : ",e);
		}
		
		return list;
	}
	
	@Override
	public List<PartyCommentDeleteDTO> getCommentDeleteList(Map<String, Object> map)
	{
		List<PartyCommentDeleteDTO> list = null;
		
		try
		{
			list = mapper.getCommentDeleteList(map);
		} 
		catch (Exception e)
		{
			log.info("getCommentDeleteList : ",e);
		}
		
		return list;
	}
	
	@Override
	public int partyCommentInsert(PartyCommentDTO dto)
	{
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int partyCommentDelete(long commentId)
	{
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<PartyCrewDTO> getPartyCrewList(long partyId)
	{
		List<PartyCrewDTO> list = null;
		
		try
		{
			list = mapper.getPartyCrewList(partyId);
		} 
		catch (Exception e)
		{
			log.info("getPartyCrewList : ",e);
		}
		
		return list;
	}

	@Override
	public int partyReady(long partyId)
	{
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int partyOut(long applyId)
	{
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int partyKick(long memberId)
	{
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<PartyApplyDTO> getPartyApplyList(long partyId)
	{
		List<PartyApplyDTO> list = null;
		
		try
		{
			list = mapper.getPartyApplyList(partyId);
		}
		catch (Exception e)
		{
			log.info("getPartyApplyList : ",e);
		}
		
		return list;
	}

	@Override
	public int aprvApply(long applyId)
	{
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int rejectApply(long applyId)
	{
		// TODO Auto-generated method stub
		return 0;
	}

}
