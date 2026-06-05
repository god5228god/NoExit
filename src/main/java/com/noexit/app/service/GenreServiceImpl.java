package com.noexit.app.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.noexit.app.mapper.GenreMapper;
import com.noexit.app.model.Genre;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class GenreServiceImpl implements GenreService {

	private final GenreMapper genreMapper;

	@Override
	public List<Genre> getGenreList() {
		List<Genre> list = null;
		try {
			list = genreMapper.getGenreList();
		} catch (Exception e) {
			log.info("getGenreList : ", e);
		}
		return list;
	}

}
