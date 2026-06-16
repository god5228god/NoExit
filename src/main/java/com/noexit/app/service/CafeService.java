package com.noexit.app.service;

import java.util.List;

import com.noexit.app.model.Cafe;
import com.noexit.app.model.CafeDropReason;

public interface CafeService {
	
	public void enroll(Cafe cafe) throws Exception;
    public List<Cafe> selectByUserId(Long userId);
    public List<CafeDropReason> getDropReasonList();
	public void cafeDrop(Cafe cafe, Long loginUserId) throws Exception;
   
}
