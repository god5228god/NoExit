package com.noexit.app.model;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ThemeSlotDTO
{
	private long slotId;
	private String resDate;
	private String resTime;

	private LocalDateTime startAt;
	private LocalDateTime endAt;
	
	private long themeId;
	private long cafeId;
	private String cafeName;
	private String themeName;
	private int minPlayers;
	private int maxPlayers;
	private int price;
	private int status;
	private int adult;
}
