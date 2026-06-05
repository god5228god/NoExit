package com.noexit.app.service;

import java.io.File;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.noexit.app.mapper.ThemeMapper;
import com.noexit.app.model.Cafe;
import com.noexit.app.model.ThemeDTO;
import com.noexit.app.model.ThemeReviewDTO;
import com.noexit.app.model.ThemeSlotDTO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ThemeServiceImpl implements ThemeService {

	private final ThemeMapper themeMapper;

	private final String uploadPath = "C:/escapeRoom/uploads/theme";

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
		return null;
	}

	@Override
	public int themeUpdate(ThemeDTO dto) {
		return 0;
	}

	@Override
	public int themeDelete(long themeId) {
		return 0;
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

	// 팀원 영역
	@Override public void getGenreList() { }
	@Override public List<Cafe> getCafeList(long userId) { return null; }
	@Override public List<ThemeDTO> getThemeList(Map<String, Object> map) { return null; }
	@Override public Map<String, List<ThemeSlotDTO>> getThemeSlot(long themeId) { return null; }
	@Override public List<ThemeReviewDTO> getThemeReview(long themeId) { return null; }
}
