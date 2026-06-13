package com.noexit.app.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.noexit.app.mapper.MainMapper;
import com.noexit.app.model.PopularThemeDTO;
import com.noexit.app.model.RecentPartyDTO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class MainServiceImpl implements MainService {

	private final MainMapper mapper;
	@Override
	public List<PopularThemeDTO> popularThemeList() {
		
		List<PopularThemeDTO> result = new ArrayList<>();
		try {
			
			result = mapper.popularThemeList();
			
		} catch (Exception e) {
			log.error("popularThemeList: ", e);
		}
		return result;
	}

	@Override
	public List<RecentPartyDTO> recentPartyList() {
		
		List<RecentPartyDTO> result = new ArrayList<>();
		try {
			
			result = mapper.recentPartyList();
			
		} catch (Exception e) {
			log.error("recentPartyList: ", e);
		}
		return result;
	}

	
}
