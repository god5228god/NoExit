package com.noexit.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class User {

	private Long userId;
	private String loginId, nickname, name, email, phone, gender, birthDate, password;

}
