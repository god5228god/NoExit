package com.noexit.app.service;

import java.util.List;

import com.noexit.app.model.Cafe;

public interface CafeService {
	
	public void enroll(Cafe cafe) throws Exception;
    public List<Cafe> selectByUserId(Long userId);
   
}
