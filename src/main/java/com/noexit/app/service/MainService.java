package com.noexit.app.service;

import java.util.List;

import com.noexit.app.model.PopularThemeDTO;
import com.noexit.app.model.RecentPartyDTO;

public interface MainService {
	
	// 인기 테마 리스트
	public List<PopularThemeDTO> popularThemeList();
	
	// 최근 개설 파티 리스트
	public List<RecentPartyDTO> recentPartyList();

}
