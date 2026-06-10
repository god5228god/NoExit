package com.noexit.app.controller;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;

import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.server.ResponseStatusException;

import com.noexit.app.model.PartyApplyDTO;
import com.noexit.app.model.PartyCommentDTO;
import com.noexit.app.model.PartyCommentDeleteDTO;
import com.noexit.app.model.PartyCrewDTO;
import com.noexit.app.model.PartyDTO;
import com.noexit.app.model.ThemeSlotDTO;
import com.noexit.app.model.User;
import com.noexit.app.service.PartyService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Controller
@RequestMapping("/party/*")
public class Party
{
	private final PartyService service;

	/*
	 * 파티 개설 폼으로 이동
	 */
	@GetMapping("write")
	public String partyWrite(@RequestParam(name = "slotId", defaultValue = "0") long slotId, Model model,
			HttpSession session)
	{
		/*
		 * 유효성 검사 목록
		 *
		 * 로그인한 사용자인가?
		 * 
		 * 존재하는 slotId 인가?
		 * 
		 * 예약가능한 slodId 인가?
		 * 
		 * mode = "write" 전달
		 * 
		 */

		/*
		 * 가져와야 하는 데이터
		 * 
		 * 슬롯 아이디 카페명 테마아이디 테마명 날짜 시간 최소 인원 최대 인원 가격
		 */

		try
		{
			ThemeSlotDTO dto = service.getThemeById(slotId);

			if (session.getAttribute("loginUser") == null || dto == null || dto.getStatus() != 1)
			{
				return "redirect:/theme/list";
			}

			model.addAttribute("dto", dto);
			model.addAttribute("mode", "write");
		} catch (Exception e)
		{
			log.info("partyWrite : ", e);
		}

		return "party/partywrite";
	}

	/*
	 * 파티 insert 액션 처리 PartyDTO 를 파라미터로 받음
	 */
	@PostMapping("write")
	public String partyInsert(PartyDTO dto, HttpSession session)
	{
		// slotId, partyName, genderCondition, partyComment

		/*
		 * 유효성 검사 목록
		 * 
		 * 로그인한 사용자인가?
		 * 
		 * 존재하는 slotId 인가?
		 * 
		 * 예약되지 않은 slodId 인가?
		 * 
		 * 파티명 길이
		 * 
		 * 파티코멘트 길이
		 */

		/*
		 * 가져올 데이터 없음
		 */

		try
		{
			ThemeSlotDTO slot = service.getThemeById(dto.getSlotId());

			// 슬롯 유효성 체크
			if (session.getAttribute("loginUser") == null || slot == null || slot.getStatus() != 1)
			{
				return "rediect:/theme/list";
			}

			User userDto = (User) session.getAttribute("loginUser");

			dto.setUserId(userDto.getUserId());

			// 길이 체크
			if (dto.getPartyComment().length() >= 30 || dto.getPartyName().length() >= 20)
			{
				return "redirect:/theme/list";
			}

			service.partyInsert(dto);
		} 
		catch (Exception e)
		{
			log.info("partyInsert : ", e);
		}

		return "redirect:/party/board/" + dto.getPartyId();
	}

	/*
	 * 파티 리스트로 이동
	 */
	@GetMapping("list")
	public String partyListPage(@RequestParam(name = "schType", defaultValue = "themeName") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd, Model model)
	{
		if (!kwd.isBlank())
		{
			model.addAttribute("schType", schType);
			model.addAttribute("kwd", kwd);
		}

		/*
		 * 여유 되면 필터도 넣어야 하는데 머가 되게 많네?
		 */

		return "party/partylist";
	}

	/*
	 * 파티 리스트 받아오기
	 * 
	 * AJAX 처리
	 */
	@ResponseBody
	@PostMapping("list")
	public List<PartyDTO> partyListData(@RequestParam(name = "schType", defaultValue = "themeName") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd, @RequestParam(name = "lastId") long lastId,
			Model model)
	{
		/*
		 * 유효성 검사 목록
		 * 
		 * 없음
		 */

		/*
		 * 가져와야 하는 데이터
		 * 
		 * 테마 번호 테마 이미지 경로 테마명 날짜 시간 파티명 평균 매너 온도 평균 나이 현재 인원 수
		 */

		Map<String, Object> map = new HashMap<>();
		
		map.put("lastId", lastId);
		
		if (!kwd.isBlank())
		{
			map.put("kwd", kwd);
			map.put("schType", schType);
		}

		List<PartyDTO> list = new ArrayList<>();
		
		try
		{
			list = service.getPartyList(map);
		} 
		catch (Exception e)
		{
			log.info("partyListData :",e);
		}
		
		return list;
	}

	/*
	 * 파티 상세 창으로 이동
	 */
	@GetMapping("info/{partyid}")
	public String partyInfo(@PathVariable(name = "partyid") long partyId, Model model, HttpSession session)
	{
		/*
		 * 유효성 검사 목록
		 * 
		 * 존재하는 partId 인가?
		 * 
		 * active 상태인 파티인가?
		 * 
		 * 
		 * 상태 : anonymous / crew / matching / idle
		 * 
		 * 로그인 / 비로그인 비로그인이면 신청 버튼 비활성화 파티원 / 비파티원 파티원이면 신청 버튼 비활성화
		 * 
		 * 신청자 / 비신청자 신청자면 취소 버튼 활성화 비신청자면 신청 버튼 활성화
		 * 
		 * 구분해서 바인딩
		 */

		/*
		 * 가져와야 하는 데이터
		 * 
		 * 파티번호 파티상태 파티명 카페명 테마명 날짜 시간 최소 인원 최대 인원 성별 조건 파티 코멘트
		 * 
		 * 파티원 정보 닉네임 나이 성별 매너온도 포지션(파티장/파티원)
		 */

		try
		{
			PartyDTO dto = Objects.requireNonNull(service.getPartyById(partyId));

			List<PartyCrewDTO> crewList = service.getPartyCrewList(partyId);

			model.addAttribute("dto", dto);
			model.addAttribute("crewList", crewList);

			// 로그인 여부 안했으면 status = guest
			/*
			 * if(session.getAttribute("loginUser") == null) { model.addAttribute("status",
			 * "guest"); }
			 *
			 *
			 * else { User user = (User)session.getAttribute("loginUser");
			 * 
			 * long userId = user.getUserId();
			 * 
			 * 
			 * PartyApplyDTO applyDTO = new PartyApplyDTO(); applyDTO.setUserId(userId);
			 * applyDTO.setPartyId(partyId);
			 * 
			 * // 신청이 있다면 apply if(service.hasApply(applyDTO) > 0) {
			 * model.addAttribute("status", "apply"); }
			 * 
			 * // 파티원이면 crew for(PartyCrewDTO crew : crewList) { if(crew.getCrewId() ==
			 * userId) { model.addAttribute("status", "crew"); break; } }
			 * 
			 * }
			 */

			return "party/partyinfo";
		} catch (NullPointerException e)
		{
			log.error("partyInfo : ", e);
		}

		catch (Exception e)
		{
			log.info("partyInfo : ", e);
		}

		return "redirect:/party/list";
	}

	/*
	 * 파티 보드 창으로 이동
	 */
	@GetMapping("board/{partyid}")
	public String partyBoard(@PathVariable(name = "partyid") long partyId, Model model, HttpSession session)
	{
		/*
		 * 유효성 검사 목록
		 * 
		 * 로그인 했는지? 비로그인이면 로그인창으로
		 * 
		 * 존재하는 파티인가?
		 * 
		 * hidden 상태가 아닌 파티인가?
		 * 
		 * 파티장/파티원 인지? 아니라면 partyList 로
		 * 
		 * 파티장/파티원 구분해서 바인딩
		 * 
		 * 파티 보드 활성화/비활성화 구분
		 */

		/*
		 * 가져와야 하는 데이터 없네? 죄다 AJAX 라서
		 */

		try
		{
			// 로그인 검사
			if(session.getAttribute("loginUser") == null)
			{
				return "redirect:/user/login";
			}
			
			PartyDTO party = service.getPartyById(partyId);
			
			// 존재하는 파티인지 검사 / 파티 상태가 hidden 인지 검사
			if(party == null || party.getPartyStatus().equals("hidden"))
			{
				return "redirect:/party/list";
			}
			
			User user = (User)session.getAttribute("loginUser");
			
			long userId = user.getUserId();
			
			List<PartyCrewDTO> crew = service.getPartyCrewList(partyId);
			
			Optional<PartyCrewDTO> me = crew.stream()
					                        .filter(c->c.getUserId() == userId)
					                        .findFirst();
			
			// 파티장 / 파티원인지 검사
			if(me.isEmpty())
			{
				return "redirect:/party/list";
			}
			
			// 파티장 / 파티원 여부 등록
			model.addAttribute("position", me.get().getPosition());
			
			// 파티 상태 등록
			if(party.getPartyStatus().equals("close"))
			{
				model.addAttribute("status", "close");
			}
			else
			{
				model.addAttribute("status", "open");
			}
			
			model.addAttribute("partyId", partyId);
			model.addAttribute("userId", userId);
			
			return "party/partyboard";
		}
		catch (Exception e)
		{
			log.info("partyBoard : ",e);
		}
		
		return "redirect:/party/list";
	}

	/*
	 * 파티 신청 insert 액션 처리
	 */
	@PostMapping("apply/{partyid}")
	public String partyApplyInsert(@PathVariable(name = "partyid") long partyId,
			@RequestParam(name = "applyComment") String applyComment, HttpSession session)
	{
		/*
		 * 유효성 검사 목록
		 * 
		 * 로그인 했는지? 비로그인이라면 로그인창으로
		 * 
		 * 존재하는 파티인가?
		 * 
		 * open 상태인 파티인가?
		 * 
		 * 이미 신청내역이 있는지? 있다면 파티정보창으로
		 * 
		 * 코멘트 길이 제한
		 */

		/*
		 * 파티 신청 insert 이후 마이 페이지 파티 내역으로
		 */

		try
		{
			PartyApplyDTO dto = new PartyApplyDTO();

			User user = (User) Objects.requireNonNull(session.getAttribute("loginUser"));
			long userId = user.getUserId();
			dto.setUserId(userId);
			dto.setApplyComment(applyComment);
			dto.setPartyId(partyId);

			PartyDTO party = service.getPartyById(partyId);

			if (party == null || !party.getPartyStatus().equals("open"))
			{
				return "redirect:/party/list";
			}

			List<PartyCrewDTO> crewList = service.getPartyCrewList(partyId);

			// 신청 내역이 있는지 확인
			if (service.hasApply(dto) > 0)
			{
				return "redirect:/party/list";
			}

			service.partyApply(dto);

			return "redirect:/party/info/" + partyId;

		} catch (Exception e)
		{
			log.info("partyApplyInsert : ", e);
		}

		return "redirect:/mypage/myparty";
	}

	/*
	 * 파티 정보 수정 폼 이동
	 */
	@GetMapping("update/{partyid}")
	public String partyUpdate(@PathVariable(name = "partyid") long partyId, Model model)
	{
		/*
		 * 유효성 검사 목록
		 * 
		 * 로그인 했는가?
		 * 
		 * 존재하는 파티인가?
		 * 
		 * active/close 상태인 파티인가?
		 * 
		 * 파티장인가?
		 * 
		 * mode="update" 전달
		 * 
		 * 파티 정보 바인딩해서 전달
		 */

		/*
		 * 받아와야 하는 데이터
		 * 
		 * 카페명 테마명 날짜 시간 최소 인원 수 최대 인원 수 가격 파티명 성별 조건 파티코멘트
		 */

		return "party/partywrite";
	}

	/*
	 * 파티 해산 메소드 해산 이후 파티 리스트로 이동
	 */
	@GetMapping("delete/{partyid}")
	public String partyDelete(@PathVariable(name = "partyid") long partyId)
	{
		/*
		 * 유효성 검사 목록
		 * 
		 * 로그인 했는가?
		 * 
		 * 존재하는 파티 인가?
		 * 
		 * active/close 상태인 파티 인가?
		 * 
		 * 파티장인가?
		 * 
		 * 파티 해산 이후 리스트로 리다이렉트
		 */

		/*
		 * 받아올 데이터 없음
		 */

		return "redirect:/party/list";
	}

	/*
	 * 댓글 insert 액션 처리 AJAX 처리
	 */
	@ResponseBody
	@PostMapping("comment/insert")
	public Map<String, Object> commentInsert(@RequestParam(name = "partyId") long partyId,
			@RequestParam(name = "partyComment") String partyComment
			, HttpSession session)
	{
		/*
		 * 유효성 검사 목록
		 * 
		 * 로그인 했는가?
		 * 
		 * 존재하는 파티 인가?
		 * 
		 * close 상태가 아닌 파티인가?
		 * 
		 * 파티장/파티원 인가?
		 */

		/*
		 * 받아올 데이터 없음
		 */
		
		Map<String, Object> result = new HashMap<>();
		result.put("status", false);
		
		User user = (User)session.getAttribute("loginUser");
		
		// 로그인 검사
		if(user == null)
		{
			throw new ResponseStatusException(HttpStatus.UNAUTHORIZED);
		}

		long userId = user.getUserId();
		
		PartyDTO party = service.getPartyById(partyId);
		
		// 파티 존재 / 파티 상태 검사
		if(party == null || "close".equals(party.getPartyStatus()))
		{
			throw new ResponseStatusException(HttpStatus.NOT_FOUND);
		}
		
		List<PartyCrewDTO> crewList = service.getPartyCrewList(partyId);
		
		Optional<PartyCrewDTO> crew = crewList.stream().filter(c->c.getUserId() == userId).findFirst();
		
		// 파티장 / 파티원 검사
		if(crew.isEmpty())
		{
			throw new ResponseStatusException(HttpStatus.FORBIDDEN);
		}
		
		PartyCommentDTO comment = new PartyCommentDTO();
		comment.setPartyId(partyId);
		comment.setUserId(userId);
		
		try
		{
			comment.setPartyComment(partyComment);
			
			// 댓글 insert 액션
			int num = service.partyCommentInsert(comment);
				
			if(num > 0)
			{
				result.put("status", true);
			}
		}
		catch (Exception e)
		{
			log.info("commentInsert : ",e);
		}

		return result;
	}

	/*
	 * 댓글 삭제 메소드 AJAX 처리
	 */
	@ResponseBody
	@PostMapping("comment/delete/{commentid}")
	public Map<String, Object> commentDelete(@PathVariable(name = "commentid") long commentId, HttpSession session)
	{
		/*
		 * 유효성 검사 목록
		 * 
		 * 로그인 했는가?
		 * 
		 * 댓글이 존재하는가?
		 * 
		 * 댓글이 삭제되지 않았는가?
		 * 
		 * 댓글 작성자인가?
		 */

		/*
		 * 받아올 데이터 없음
		 */

		Map<String, Object> result = new HashMap<>();
		
		result.put("status", false);
		
		User user = (User)session.getAttribute("loginUser");
		
		// 로그인 확인
		if(user == null)
		{
			 throw new ResponseStatusException(HttpStatus.UNAUTHORIZED);
		}
		
		try
		{
			PartyCommentDTO comment = service.getCommentById(commentId);
			
			// 댓글 존재 및 삭제 여부 확인
			if(comment == null)
			{
				throw new ResponseStatusException(HttpStatus.NOT_FOUND);
			}
			
			// 작성자 확인
			if(user.getUserId() != comment.getUserId())
			{
				throw new ResponseStatusException(HttpStatus.FORBIDDEN);
			}
				
			if(service.partyCommentDelete(commentId) > 0)
			{
				result.put("status", true);
			}
		} 
		catch (ResponseStatusException e)
		{
			log.info("commentDelete : ",e);
			throw e;
		}
		catch (Exception e)
		{
			log.info("commentDelete : ",e);
		}
		
		return result;
	}

	/*
	 * 레디 액션 처리 AJAX 처리
	 */
	@PostMapping("ready/{partyid}")
	public String setReady()
	{
		/*
		 * 유효성 검사 목록
		 * 
		 * 로그인 했는가?
		 * 
		 * 존재하는 파티 인가?
		 * 
		 * 레디를 하지 않은 상태인가?
		 * 
		 * active/close 상태인 파티 인가?
		 * 
		 * 파티원 인가?
		 */

		/*
		 * 받아올 데이터 없음
		 */

		return "";
	}

	/*
	 * 파티 강퇴 액션 처리 AJAX 처리
	 */
	@ResponseBody
	@PostMapping("kick/{crewid}")
	public Map<String, Object> crewKick(@PathVariable(name = "crewid") long crewId, HttpSession session)
	{
		/*
		 * 유효성 검사 목록
		 * 
		 * 로그인 했는가?
		 * 
		 * 존재하는 멤버 id 인가?
		 * 
		 * active/close 상태인 파티인가?
		 * 
		 * 현재 파티원인가?
		 * 
		 * 파티장인가?
		 */

		/*
		 * 받아올 데이터 없음
		 */

		Map<String, Object> map = new HashMap<>();
		map.put("status", false);
		
		try
		{
			User user = (User)session.getAttribute("loginUser");
			
			// 로그인 확인
			if(user == null)
			{
				throw new ResponseStatusException(HttpStatus.UNAUTHORIZED);
			}
			
			
			
		}
		catch(ResponseStatusException e)
		{
			log.info("crewKick : ",e);
			throw e;
		}
		catch (Exception e)
		{
			log.info("crewKick : ",e);
		}
		
		return map;
	}

	/*
	 * 파티 탈퇴 액션 처리
	 * 
	 * 파티원 delete 파티신청 delete
	 * 
	 * AJAX 처리
	 */
	@PostMapping("out/{applyid}")
	public String crewOut(@PathVariable(name = "applyid") long applyId)
	{
		/*
		 * 유효성 검사 목록
		 * 
		 * 로그인 했는가?
		 * 
		 * 존재하는 신청 id 인가?
		 * 
		 * active/close 상태인 파티인가?
		 * 
		 * 현재 파티원인가?
		 * 
		 * 자기자신인가?
		 */

		/*
		 * 받아올 데이터 없음
		 */

		return "";
	}

	/*
	 * 파티 신청 승인 액션 처리
	 * 
	 * 파티원 insert
	 * 
	 * AJAX 처리
	 */
	@ResponseBody
	@PostMapping("aprvapply/{applyid}")
	public Map<String, Object> aprvApply(@PathVariable(name = "applyid") long applyId, HttpSession session)
	{
		/*
		 * 유효성 검사 목록
		 * 
		 * 로그인 했는가?
		 * 
		 * 존재하는 신청 id 인가?
		 * 
		 * open 상태인 파티인가?
		 * 
		 * 현재 파티원이 아닌가?
		 * 
		 * 파티장인가?
		 */

		/*
		 * 받아올 데이터 없음
		 */
		
		Map<String, Object> map = new HashMap<>();
		map.put("status", false);
		
		try
		{
			User user = (User)session.getAttribute("loginUser");
			
			// 로그인 확인
			if(user == null)
			{
				throw new ResponseStatusException(HttpStatus.UNAUTHORIZED);
			}
			
			PartyApplyDTO apply = service.getPartyApplyById(applyId);
			
			// 존재하는 신청 id 확인
			if(apply == null )
			{
				throw new ResponseStatusException(HttpStatus.NOT_FOUND);
			}
			
			PartyDTO party = service.getPartyById(apply.getPartyId());
			
			// 존재하는 파티 / 파티 상태 확인
			if(party == null || !"open".equals(party.getPartyStatus()))
			{
				throw new ResponseStatusException(HttpStatus.NOT_FOUND);
			}
			
			List<PartyCrewDTO> crewList = service.getPartyCrewList(apply.getPartyId());
			
			// 현재 파티장 / 파티원 여부 확인
			if(crewList.stream().anyMatch(c->c.getUserId() == apply.getUserId()))
			{
				throw new ResponseStatusException(HttpStatus.FORBIDDEN);
			}
			
			// 내가 파티장 인지 확인
			Optional<PartyCrewDTO> crew = crewList.stream().filter(c->"HOST".equals(c.getPosition())).findFirst(); 
			
			if(crew.get().getUserId() != user.getUserId())
			{
				throw new ResponseStatusException(HttpStatus.FORBIDDEN);
			}
			
			if(service.aprvApply(applyId) > 0)
			{
				map.put("status", true);
			}
		}
		catch(ResponseStatusException e)
		{
			log.info("aprvApply : ",e);
			throw e;
		}
		catch (Exception e)
		{
			log.info("aprvApply : ",e);
		}
		
		return map;
	}

	/*
	 * 파티 신청 거절 액션 처리
	 * 
	 * apply delete
	 * 
	 * AJAX 처리
	 */
	@ResponseBody
	@PostMapping("rejectapply/{applyid}")
	public Map<String, Object> rejectApply(@PathVariable(name = "applyid") long applyId, HttpSession session)
	{
		/*
		 * 유효성 검사 목록
		 * 
		 * 로그인 했는가?
		 * 
		 * 존재하는 신청 id 인가?
		 * 
		 * 
		 * 현재 파티원이 아닌가?
		 * 
		 * 파티장인가?
		 */

		/*
		 * 받아올 데이터 없음
		 */

		Map<String, Object> map = new HashMap<>();
		map.put("status", false);
		
		try
		{
			User user = (User)session.getAttribute("loginUser");
			
			// 로그인 확인
			if(user == null)
			{
				throw new ResponseStatusException(HttpStatus.UNAUTHORIZED);
			}
			
			PartyApplyDTO apply = service.getPartyApplyById(applyId);
			
			// 존재하는 신청 id 확인
			if(apply == null )
			{
				throw new ResponseStatusException(HttpStatus.NOT_FOUND);
			}
			
			PartyDTO party = service.getPartyById(apply.getPartyId());
			
			// 존재하는 파티 확인
			if(party == null)
			{
				throw new ResponseStatusException(HttpStatus.NOT_FOUND);
			}
			
			List<PartyCrewDTO> crewList = service.getPartyCrewList(apply.getPartyId());
			
			// 현재 파티장 / 파티원 여부 확인
			if(crewList.stream().anyMatch(c->c.getUserId() == apply.getUserId()))
			{
				throw new ResponseStatusException(HttpStatus.FORBIDDEN);
			}
			
			// 내가 파티장 인지 확인
			Optional<PartyCrewDTO> crew = crewList.stream().filter(c->"HOST".equals(c.getPosition())).findFirst(); 
			
			if(crew.get().getUserId() != user.getUserId())
			{
				throw new ResponseStatusException(HttpStatus.FORBIDDEN);
			}
			
			if(service.rejectApply(applyId) > 0)
			{
				map.put("status", true);
			}
		}
		catch(ResponseStatusException e)
		{
			log.info("rejectApply : ",e);
			throw e;
		}
		catch (Exception e)
		{
			log.info("rejectApply : ",e);
		}
		
		return map;
	}

	/*
	 * 파티 정보를 바인딩해서 전달하는 메소드 ㅈㄴ 바쁜 메소드
	 * 
	 * AJAX 처리
	 */
	@ResponseBody
	@PostMapping("data/{partyid}")
	public Map<String, Object> partyData(@PathVariable(name = "partyid") long partyId
										,@RequestParam(name="lastCommentId", defaultValue = "0") long lastCommentId
										,@RequestParam(name="lastDeleteCommentId", defaultValue = "0") long lastDeleteCommentId
										,HttpSession session)
	{
		/*
		 * 유효성 검사 목록
		 * 
		 * 로그인 했는가?
		 * 
		 * 존재하는 파티인가?
		 * 
		 * 파티 상태가 hidden 이 아닌가?
		 * 
		 * 파티장/파티원 인가?
		 */

		/*
		 * 받아올 데이터
		 * 
		 * 
		 * 파티 정보
		 * 
		 * 슬롯 상태 : 가능 / 불가능
		 * 
		 * 파티 상태 파티명 카페명 테마명 날짜 시간 최소인원 최대인원 성별조건 파티코멘트
		 * 
		 * 
		 * 파티원 정보
		 * 
		 * 닉네임 나이 성별 매너온도 레디상태 포지션 상태
		 * 
		 * 
		 * 파티 댓글 정보
		 * 
		 * 댓글 번호 작성자 작성 내용 삭제 유무
		 * 
		 * 
		 * 파티 신청
		 * 
		 * 닉네임 나이 성별 매너온도 신청 코멘트
		 * 
		 * 
		 * 
		 */
		
		User user = (User)session.getAttribute("loginUser");
		
		// 로그인 검사
		if(user == null)
		{
			 throw new ResponseStatusException(HttpStatus.UNAUTHORIZED);
		}
		
		long userId = user.getUserId();
		
		PartyDTO party = service.getPartyById(partyId);
		
		// 파티 존재 검사 / 파티 상태 검사
		if(party == null || "hidden".equals(party.getPartyStatus()))
		{
			throw new ResponseStatusException(HttpStatus.NOT_FOUND);
		}
		
		List<PartyCrewDTO> crewList = service.getPartyCrewList(partyId);
		
		Optional<PartyCrewDTO> crew = crewList.stream().filter(c->c.getUserId() == userId).findFirst();
		
		// 파티장 / 파티원 검사
		if(crew.isEmpty())
		{
			throw new ResponseStatusException(HttpStatus.FORBIDDEN);
		}
		
		List<PartyApplyDTO> applyList = service.getPartyApplyList(partyId);
		
		Map<String, Object> commentMap = new HashMap<>();
		
		commentMap.put("partyId", partyId);
		commentMap.put("lastCommentId", lastCommentId);
		commentMap.put("lastDeleteCommentId", lastDeleteCommentId);
		
		List<PartyCommentDTO> commentList = service.getPartyCommentList(commentMap);
		
		List<PartyCommentDeleteDTO> commentDeleteList = service.getCommentDeleteList(commentMap);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("partyInfo", party);
		map.put("crewList", crewList);
		map.put("applyList", applyList);
		map.put("commentList", commentList);
		map.put("commentDeleteList", commentDeleteList);
		
		return map;
	}
}
