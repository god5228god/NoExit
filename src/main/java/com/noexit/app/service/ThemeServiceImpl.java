package com.noexit.app.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.TreeMap;
import java.util.UUID;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.noexit.app.mapper.ThemeMapper;
import com.noexit.app.model.Cafe;
import com.noexit.app.model.SearchFilterDTO;
import com.noexit.app.model.ThemeDTO;
import com.noexit.app.model.ThemeDropReason;
import com.noexit.app.model.ThemeReviewDTO;
import com.noexit.app.model.ThemeSlotDTO;

import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ThemeServiceImpl implements ThemeService {

	private final ThemeMapper themeMapper;

	private String uploadPath;

	@PostConstruct
	public void init() {
		this.uploadPath = new File("src/main/resources/static/dist/images").getAbsolutePath();

		File file = new File(uploadPath);
		if (!file.exists()) {
			file.mkdirs();
		}
	}

	@Override
	public int themeInsert(ThemeDTO dto) throws Exception {
		int result = 0;
		try {
			String saveFilename = saveThemeImage(dto);
			if (saveFilename != null) {
				dto.setImagePath(saveFilename);
			}
			result = themeMapper.themeInsert(dto);
		} catch (Exception e) {
			log.info("themeInsert : ", e);
			throw e;
		}
		return result;
	}

	@Override
	public ThemeDTO getThemeById(long themeId) {
		ThemeDTO dto = null;
		try {
			dto = themeMapper.getThemeById(themeId);
		} catch (Exception e) {
			log.info("getThemeById : ", e);
		}
		return dto;
	}

	@Override
	public int themeUpdate(ThemeDTO dto) throws Exception {
		int result = 0;
		try {
			String saveFilename = saveThemeImage(dto);
			if (saveFilename != null) {
				dto.setImagePath(saveFilename);
			} else {
				ThemeDTO old = themeMapper.getThemeById(dto.getThemeId());
				dto.setImagePath(old.getImagePath());
			}
			result = themeMapper.themeUpdate(dto);
		} catch (Exception e) {
			log.info("themeUpdate : ", e);
			throw e;
		}
		return result;
	}

	// 테마 리스트 조회 (페이징 포함)
	@Override
	public List<ThemeDTO> selectListByOwnerUserId(Map<String, Object> map) {
		List<ThemeDTO> list = null;
		try {
			list = themeMapper.selectListByOwnerUserId(map);
		} catch (Exception e) {
			log.info("selectListByOwnerUserId : ", e);
		}
		return list;
	}

	// 테마 갯수 확인
	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = themeMapper.dataCount(map);
		} catch (Exception e) {
			log.info("dataCount : ", e);
		}
		return result;
	}


	private String saveThemeImage(ThemeDTO dto) throws Exception {
		List<MultipartFile> files = dto.getThemeImageFile();
		if (files == null || files.isEmpty()) {
			return null;
		}

		MultipartFile mf = files.get(0);
		if (mf == null || mf.isEmpty()) {
			return null;
		}

		String originalFilename = mf.getOriginalFilename();
		String extension = "";
		int dot = originalFilename.lastIndexOf(".");
		if (dot > -1) {
			extension = originalFilename.substring(dot);
		}

		UUID uuid = UUID.randomUUID();
		long uniqueNumber = Math.abs(uuid.getMostSignificantBits());
		String saveFilename = System.currentTimeMillis() + String.valueOf(uniqueNumber) + extension;

		File dir = new File(uploadPath);
		if (!dir.exists()) {
			dir.mkdirs();
		}

		mf.transferTo(new File(uploadPath + File.separator + saveFilename));
		return saveFilename;
	}

	@Override 
	public List<Cafe> getCafeList(long userId)
	{ 
		return null;
	}
	
	
	
	@Override 
	public List<ThemeDTO> getThemeList(Map<String, Object> map, SearchFilterDTO filter) 
	{ 
		// map 에 들어있는 데이터
		// schType, kwd, lastId
		
		List<ThemeDTO> result = null;
		
		try
		{
			if(filter.getMinPrice() != null)
				map.put("minPrice", filter.getMinPrice());
			if(filter.getMaxPrice() != null)
				map.put("maxPrice", filter.getMaxPrice());
			if(filter.getMinLevel() != null)
				map.put("minLevel", filter.getMinLevel());
			if(filter.getMaxLevel() != null)
				map.put("maxLevel", filter.getMaxLevel());
			if(filter.getMinHorror() != null)
				map.put("minHorror", filter.getMinHorror());
			if(filter.getMaxHorror() != null)
				map.put("maxHorror", filter.getMaxHorror());
			
			result = themeMapper.getThemeList(map);
		} 
		catch (Exception e)
		{
			log.info("getThemeList : ",e);
		}
		
		return result;
	}
	
	@Override
	public ThemeDTO getThemeInfoById(long themeId)
	{
		ThemeDTO dto = null;
		
		try
		{
			dto = themeMapper.getThemeInfoById(themeId);
		} 
		catch (Exception e)
		{
			log.info("getThemeInfoById : ",e);
		}
		
		return dto;
	}
	
	@Override 
	public Map<String,List<ThemeSlotDTO>> getThemeSlot(long themeId)
	{
		List<ThemeSlotDTO> result = null;
		
		Map<String,List<ThemeSlotDTO>> list = new HashMap<>();
		
		try
		{
			result = Objects.requireNonNull(themeMapper.getThemeSlot(themeId));
			
			
			//list = result.stream().collect(Collectors.groupingBy(ThemeSlotDTO::getResDate));
			
			list = result.stream().collect(Collectors.groupingBy(
			        ThemeSlotDTO::getResDate,
			        TreeMap::new,
			        Collectors.toList()));
		}
		catch(NullPointerException e)
		{
			log.info("getThemeSlot Null : ",e);
		}
		
		catch (Exception e)
		{
			log.info("getThemeSlot : ",e);
		}
		
		return list;
	}
	
	@Override 
	public List<ThemeReviewDTO> getThemeReview(long themeId)
	{ 
		List<ThemeReviewDTO> result = null;
		
		try
		{
			result = themeMapper.getThemeReview(themeId);
		} 
		catch (Exception e)
		{
			log.info("getThemeReview : ",e);
		}
		
		return result;
	}
	
	@Override
	public ThemeReviewDTO getTotalReview(long themeId)
	{
		ThemeReviewDTO result = null;
		
		try
		{
			result = themeMapper.getTotalReview(themeId);
		} 
		catch (Exception e)
		{
			log.info("getTotalReview : ",e);
		}
		
		return result;
	}
	
	@Override
	public List<ThemeDropReason> getDropReasonList() {
		List<ThemeDropReason> list = null;
		try {
			list = themeMapper.selectDropReasonList();
		} catch (Exception e) {
			log.info("getDropReasonList : ", e);
		}
		return list;
	}
	
	@Override
	public void themeDrop(Long themeId, Long dropReasonId, Long ownerUserId) throws Exception {
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("themeId", themeId);
			map.put("dropReasonId", dropReasonId);
			map.put("ownerUserId", ownerUserId);
			
			themeMapper.insertRoomDrop(map);
			
		} catch (Exception e) {
			log.info("themeDrop : ", e);
			throw e;
		}
	}
	
}
