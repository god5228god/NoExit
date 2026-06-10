package com.noexit.app.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.noexit.app.mapper.EvaluationMapper;
import com.noexit.app.model.Evaluation;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
@Transactional		// 하나라도  실패하면 롤백시킴
public class EvaluationServiceImpl implements EvaluationService {

	private final EvaluationMapper mapper;
	
	
	@Override
	public void insertEvaluation(Evaluation evaluation1, Evaluation evaluation2)
	{
			// 두 질문을 한번에 처리하기 위함
			mapper.insertEvaluation(evaluation1);
			mapper.insertEvaluation(evaluation2);
			
			Long detailId = evaluation1.getDetailId();
			
			int evalCount = mapper.getEvaluationCount(detailId);
		    
			// 3명 배수 처리
		    if (evalCount > 0 && evalCount % 6 == 0) {
		        log.info("매너온도 증가 로직 실행");
		        
		        mapper.insertMannerHistory(detailId);
		    }
	
	
	}
}
