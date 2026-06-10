package com.noexit.app.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PartyCommentDTO
{
	private long commentId;
	private String nickName;
	private String partyComment;
	private long partyId;
	private long userId;
	private boolean delete;
	private String createdAt;
}
