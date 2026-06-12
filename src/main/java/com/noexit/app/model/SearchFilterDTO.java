package com.noexit.app.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SearchFilterDTO
{
	private Integer minPrice;
	private Integer maxPrice;
	private Integer minLevel;
	private Integer maxLevel;
	private Integer minHorror;
	private Integer maxHorror;
	private String minDate;
	private String maxDate;
	private String minTime;
	private String maxTime;
}

