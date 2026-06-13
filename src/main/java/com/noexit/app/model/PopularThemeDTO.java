package com.noexit.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class PopularThemeDTO {
	
	private String cafeName;
	private Long roomId;
	private String roomName;
	private String genreName;
	private String roomImg;
	private int isAdult;
	private Double avgGrade;
	private String createdAt;
	
}
