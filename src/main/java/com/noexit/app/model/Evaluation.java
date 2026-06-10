package com.noexit.app.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Evaluation {
	private Long evalId;					// 상호평가ID
	private Long writerId;					// 평가자 ID
    private Long detailId;    				// 출석체크 FK ID
    private Long targetId;    				// 상호평가 대상ID
    private Long questionId;  				// 질문
    private Long answerId;					// 답변
}
