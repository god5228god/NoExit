package com.noexit.app.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.noexit.app.model.Genre;

@Mapper
public interface GenreMapper {

	public List<Genre> getGenreList();

}
