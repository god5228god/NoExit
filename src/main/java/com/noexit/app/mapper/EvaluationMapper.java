package com.noexit.app.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.noexit.app.model.Evaluation;

@Mapper
public interface EvaluationMapper {
	public void insertEvaluation(Evaluation evaluation);
	int getEvaluationCount(Long detailId);
	void insertMannerHistory(Long writerId);
	
}
