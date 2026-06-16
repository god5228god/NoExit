package com.noexit.app.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.noexit.app.model.PopularThemeDTO;
import com.noexit.app.model.RecentPartyDTO;

@Mapper
public interface MainMapper {
	
	// 인기 테마 리스트
	public List<PopularThemeDTO> popularThemeList();
	
	// 최근 개설 파티 리스트
	public List<RecentPartyDTO> recentPartyList();

}
