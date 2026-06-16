package com.noexit.app.controller;

import com.noexit.app.common.AuthUtil;
import com.noexit.app.common.PaginateUtil;
import com.noexit.app.model.ThemeDTO;
import com.noexit.app.model.User;
import com.noexit.app.service.CafeService;
import com.noexit.app.service.CommonService;
import com.noexit.app.service.GenreService;
import com.noexit.app.service.ThemeService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/owner/theme")
public class OwnerThemeController {

    private final ThemeService themeService;
    private final CafeService cafeService;
    private final GenreService genreService;
    private final CommonService commonService;
    private final PaginateUtil paginateUtil;

    @GetMapping("/manage")
    public String themeManage(@RequestParam(name = "page", defaultValue = "1") int currentPage
                            , HttpSession session, HttpServletRequest req, Model model) {
        String redirect = AuthUtil.checkOwner(session);
        if (redirect != null)
        	return redirect;

        User loginUser = (User) session.getAttribute("loginUser");

        try {
            int size = 5; // 한 화면에 보여주는 테마 수
            
            Map<String, Object> map = new HashMap<>();      
            map.put("ownerUserId", loginUser.getUserId());

            // 데이터 개수 파악
            int dataCount = themeService.dataCount(map);
            String listUrl = req.getContextPath() + "/owner/theme/manage";
          
            // 페이지 번호 보정
            currentPage = paginateUtil.preparePage(currentPage, size, dataCount, map, listUrl, model);

            // 리스트 가져오기
            List<ThemeDTO> themeList = themeService.selectListByOwnerUserId(map);
            model.addAttribute("themeList", themeList);
            model.addAttribute("reasonList", themeService.getDropReasonList());

        } catch (Exception e) {
            log.info("themeManage : ", e);
        }

        return "theme/themeManage";
    }
    
    @PostMapping("/drop")
    public String themeDrop(@RequestParam("themeId") Long themeId
                          , @RequestParam("dropReasonId") Long dropReasonId
                          , HttpSession session) {
    	
    	String redirect = AuthUtil.checkOwner(session);   	 	
    	if (redirect != null) 
    		return redirect;

    	User loginUser = (User) session.getAttribute("loginUser");
    	try {
    		themeService.themeDrop(themeId, dropReasonId, loginUser.getUserId());
    	} catch (Exception e) {
    		log.info("themeDrop : ", e);
    	}
    	return "redirect:/owner/theme/manage";
    }

    @GetMapping("/write")
    public String writeForm(@RequestParam("mode") String mode
                          , @RequestParam(name = "roomId", required = false) Long roomId
                          , HttpSession session, Model model) {
        String redirect = AuthUtil.checkOwner(session);
        if (redirect != null) 
        	return redirect;

        User loginUser = (User) session.getAttribute("loginUser");
        
        model.addAttribute("cafeList", cafeService.selectByUserId(loginUser.getUserId()));
        model.addAttribute("genreList", genreService.getGenreList());
        model.addAttribute("commonList", commonService.getCommonList());
        model.addAttribute("mode", mode);

        if ("update".equals(mode) && roomId != null) {
            model.addAttribute("dto", themeService.getThemeById(roomId));
        }
        return "theme/themeWriteForm";
    }

    @PostMapping("/write")
    public String write(@RequestParam("mode") String mode
                      , ThemeDTO dto, HttpSession session, Model model) {
        String redirect = AuthUtil.checkOwner(session);
        if (redirect != null) 
        	return redirect;
        try {
            if ("update".equals(mode)) 
            	themeService.themeUpdate(dto);
            else 
            	themeService.themeInsert(dto);
        } catch (Exception e) {
            log.info("theme write (" + mode + ") : ", e);

            User loginUser = (User) session.getAttribute("loginUser");
            model.addAttribute("errorMessage", "테마 " + ("update".equals(mode) ? "수정" : "등록") + " 중 오류 발생");
            model.addAttribute("cafeList", cafeService.selectByUserId(loginUser.getUserId()));
            model.addAttribute("genreList", genreService.getGenreList());
            model.addAttribute("commonList", commonService.getCommonList());
            model.addAttribute("mode", mode);
            return "theme/themeWriteForm";
        }
        return "redirect:/owner/theme/manage";
    }
}