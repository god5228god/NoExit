SELECT USER
FROM DUAL;



--○ 선언부: 외부에서 호출할 인터페이스 정의
CREATE OR REPLACE PACKAGE CRYPTPACK
AS
    -- 암호화 함수
    -- STR:평문(암호화할 문자열)
    -- HASH: 암호화 키(내부적으로 32바이트로 가공)
    FUNCTION ENCRYPT(STR VARCHAR2, HASH VARCHAR2)
    RETURN VARCHAR2;
    
    -- 복호화 함수
    -- XCRYPT: 암호화된 16진수 문자열
    -- HASH: 암호화 시 사용했던 키
    FUNCTION DECRYPT(XCRYPT VARCHAR2, HASH VARCHAR2)
    RETURN VARCHAR2;
    
END CRYPTPACK;
--==>> Package CRYPTPACK이(가) 컴파일되었습니다.



--○ 몸체부: 실제 로직 구현
CREATE OR REPLACE PACKAGE BODY CRYPTPACK
AS
    -- 암호화 알고리즘 정의 설정값
    -- - AES256     : 256비트 대칭키 알고리즘 → 현재 가장 안전한 표준 알고리즘
    -- - CHAIN_CBC  : 블록 암호화 운용 방식 → 이전 블록이 다음 블록에 영햔 → 보안성 강화
    -- - PAD_PKCS5  : 데이터 길이를 블록 단위로 맞추기 위한 패딩 방식 → 자동 처리
    
    V_TYP CONSTANT PLS_INTEGER := DBMS_CRYPTO.ENCRYPT_AES256
                                + DBMS_CRYPTO.CHAIN_CBC
                                + DBMS_CRYPTO.PAD_PKCS5;
    
    -- 함수 정의 : 암호화
    FUNCTION ENCRYPT(STR VARCHAR2, HASH VARCHAR2)
    RETURN VARCHAR2
    IS
        V_RAW       RAW(2000);       -- 문자열을 이진 데이터로 변환할 변수
        V_KEY_RAW   RAW(32);         -- AES256을 위한 32바이트 키 변수
        V_ENCRYPTED RAW(2000);       -- 암호화된 결과값
    BEGIN
        -- 평문을 RAW 타입으로 변환 → 한글 깨짐 방지를 위해 AL32UTF8 지정
        V_RAW := UTL_I18N.STRING_TO_RAW(STR, 'AL32UTF8');
        
        -- 키 값 설정 → AES256이므로 32바이트로 길이 맞춤 구성
        -- → 이 과정에서 길이가 부족할 경우 '#'으로 채워서 32자리 구성
        V_KEY_RAW := UTL_RAW.CAST_TO_RAW(RPAD(HASH, 32, '#'));
        
        -- 암호화 수행
        V_ENCRYPTED := DBMS_CRYPTO.ENCRYPT(
            SRC => V_RAW,
            TYP => V_TYP,
            KEY => V_KEY_RAW
        );
        
        -- 결과값(RAW)를 DB에 저장할 수 있는 16진수 문자열로 변환해서 반환
        RETURN RAWTOHEX(V_ENCRYPTED);
    END;
    
    
    
    -- 함수 정의 : 복호화
    FUNCTION DECRYPT(XCRYPT VARCHAR2, HASH VARCHAR2)
    RETURN VARCHAR2
    IS
        V_DECRYPTED_RAW RAW(2000);      -- 복호화된 이진 데이터
        V_KEY_RAW       RAW(32);        -- 암호화와 같은 32바이트 키
    BEGIN
        -- 키 값 설정 → 암호화를 수행할 때와 동일하게 32바이트 가공
        V_KEY_RAW := UTL_RAW.CAST_TO_RAW(RPAD(HASH, 32, '#'));
        
        -- 복호화 수행 → 16진수 문자열을 다시 RAW로 변환하여 입력
        V_DECRYPTED_RAW := DBMS_CRYPTO.DECRYPT(
            SRC => HEXTORAW(XCRYPT),
            TYP => V_TYP,
            KEY => V_KEY_RAW
            
        );
        
        -- 복호화된 RAW 데이터를 다시 사람이 읽을 수 있는 문자열로 변환
        -- → 이 과정에서도 앞에서와 마찬가지로 문자셋을 AL32UTF8 로 지정하여
        --    한글 깨짐 방지 처리
        RETURN UTL_I18N.RAW_TO_CHAR(V_DECRYPTED_RAW, 'AL32UTF8');
        
        -- 예외 처리
        EXCEPTION 
            WHEN OTHERS THEN
                RETURN 'DECRYPT_ERROR';
                -- 복호화 실패 시(즉, 키가 틀렸거나 데이터가 오염되었을 때)
                -- → 에러 메시지 반환 → NULL 처리하는 것도 가능
    END;
    
END CRYPTPACK;



