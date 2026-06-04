package com.noexit.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Admin {
	
	//ADMIN_ACCOUNT
    private Long adminId;
    private String loginId;
    private String password;
    
    //ADMIN_INFO
    private Long adminInfoId;
    private String name;
    private String phone;
    
    // ADMIN_HISTORY
    private String startDate;
    private String endDate;

}
