package com.noexit.app.model;

import java.util.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Cafe {

	private Long cafeId;
	private Long userId;
	private String brNo;
	private String cafeName;
	private String phone;
	private String postalCode;
	private String address;
	private String addressDetail;
	private Date createdAt;

}
