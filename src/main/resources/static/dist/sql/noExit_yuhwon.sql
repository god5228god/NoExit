SELECT USER
FROM DUAL;




--==============================================================================
-- FUNCTION(함수) 생성
--==============================================================================


-- 1. 























--==============================================================================
-- VIEW 생성
--==============================================================================


-- 1. 활성 파티(비활성파티 제외) 뷰
CREATE OR REPLACE VIEW VW_ACTIVE_PARTY
AS
SELECT P.PARTY_ID, P.USER_ID, P.PARTY_NAME, P.GENDER_ID, P.MESSAGE, P.CREATED_AT
FROM PARTY P
WHERE NOT EXISTS(
                SELECT PD.PARTY_ID
                FROM PARTY_DROP PD
                WHERE P.PARTY_ID = PD.PARTY_ID
                );
                
                
-- 2. 활성 예약 오픈(비활성 예약 오픈 제외) 뷰
CREATE OR REPLACE VIEW VW_ACTIVE_RES_OPEN
AS
SELECT RO.RES_OPEN_ID, RO.ROOM_ID, RO.OPEN_AT, RO.USER_ID, RO.CREATED_AT
FROM RES_OPEN RO
WHERE NOT EXISTS (
    SELECT RD.RES_OPEN_ID 
    FROM RES_DROP RD 
    WHERE RO.RES_OPEN_ID = RD.RES_OPEN_ID
);


-- 3. 예약 가능 목록 뷰







-- 4. 예약 취소 목록 뷰








SELECT *
FROM RES_OPEN;












-- . 예약 목록(예약 중, 예약 취소, 플레이완료)  
-- 지위(파티장, 파티원), 사용자번호, 닉네임, 매칭개설번호, 파티명, 예약테마명, 테마 예약일, 예약된 일자, 예약 상태








-- 예약 상태 조회(예약 중 - 파티장의 경우)


SELECT RES_OPEN_ID
FROM PARTY_ROOM PR 
    JOIN PARTY P
    ON PR.PARTY_ID = P.PARTY_ID
WHERE P.USER_ID = 1;
-- 로그인 한 사용자가 가지고 있는 개설된 파티와 예약테이블을 조회해서 예약 슬롯 조회
-- 


-- 로그인한 사용자가 개설한 파티 중에 비활성화 된 파티는 제외한 매칭개설번호 조회(유효한 파티)
SELECT P.PARTY_ID
FROM PARTY P
WHERE NOT EXISTS(
    SELECT PD.PARTY_ID
    FROM PARTY_DROP PD
    WHERE P.PARTY_ID = PD.PARTY_ID
) AND USER_ID = 1;


-- 그 유효한 파티에서 매칭 예약을 조회해서 예약 오픈 예정번호 얻어내기
SELECT PR.RES_OPEN_ID
FROM PARTY_ROOM PR
    JOIN (
            SELECT P.PARTY_ID
            FROM PARTY P
            WHERE NOT EXISTS(
                SELECT PD.PARTY_ID
                FROM PARTY_DROP PD
                WHERE P.PARTY_ID = PD.PARTY_ID
            ) AND USER_ID = 1
    ) P
    ON PR.PARTY_ID = P.PARTY_ID;


-- 예약오픈 테이블도 예약오픈비활성화테이블(RES_DROP)과 조인으로 비활성화된 예약오픈은 제외한 것과 비교
SELECT RO.RES_OPEN_ID
FROM RES_OPEN RO
WHERE NOT EXISTS(
    SELECT RD.RES_OPEN_ID
    FROM RES_DROP RD
    WHERE RO.RES_OPEN_ID = RD.RES_OPEN_ID
)
ORDER BY RES_OPEN_ID;


-- 위에서 얻어낸 예약오픈예정번호(RES_OPEN_ID)로 RES_OPNE(예약오픈)테이블을 조회해서 존재하는지의 여부 확인




--하나의 예약 오픈 아이디를 넣으면 해당 예약 상태에 따라 숫자를 반환하는 메소드
SELECT FN_RESERVATION_CHECK(1)
FROM DUAL;
-- -1 : 예약 중단(비활성화)
--
--  0 : 예약 완료
--
--  1 : 예약 가능


--
--SELECT COUNT(*) AS COUNT
--FROM RES_OPEN
--WHERE RES_OPEN_ID = (
--                    SELECT RES_OPEN_ID
--                    FROM PARTY_ROOM PR 
--                        JOIN PARTY P
--                        ON PR.PARTY_ID = P.PARTY_ID
--                        JOIN PARTY_DROP PD
--                        ON P.PARTY_ID = PD.PARTY_ID
--                    WHERE P.USER_ID = 1 AND 
--                    );
----==>> 로그인 한 사용자가 가지고 있는 개설된 파티와 예약건을 조회해서 실제 예약 슬롯에 존재하는 지 확인





SELECT *
FROM USER_INFO;


SELECT *
FROM USER_ACCOUNT;
