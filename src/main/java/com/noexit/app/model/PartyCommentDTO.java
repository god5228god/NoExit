package com.noexit.app.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PartyCommentDTO
{
	private long commentId;
	private String name;
	private String partyComment;
	private long userId;
	private boolean delete;
	private String createdAt;
}
