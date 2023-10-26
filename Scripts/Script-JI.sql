-- 배송테이블 생성
CREATE TABLE TB_DELIVERY(
   DELIVERY_SEQ NUMBER PRIMARY KEY,
   USER_SEQ NUMBER REFERENCES TB_USER(USER_SEQ),
   DELIVERY_NAME VARCHAR2(30) NOT NULL,
   DELIVERY_PHONE VARCHAR2(30) NOT NULL,
   POSTCODE VARCHAR2(10) NOT NULL,
   ADDRESS VARCHAR2(100) NOT NULL,
   DETADDR VARCHAR2(100),
   EXTADDR VARCHAR2(100),
   DELIVERY_NUM NUMBER
);

CREATE SEQUENCE SQ_TB_BOOK START WITH 1600 INCREMENT BY 1;


CREATE SEQUENCE SQ_USER START WITH 60 INCREMENT BY 1;
--DROP TABLE TB_DELIVERY;
--DROP TABLE TB_PAY;

----결제테이블 생성
CREATE TABLE TB_PAY(
    PAY_SEQ NUMBER PRIMARY KEY,
    PAY_IMD VARCHAR2(50),
    USER_SEQ NUMBER REFERENCES TB_USER(USER_SEQ),
    PAY_PAYMENT NUMBER NOT NULL,
    PAY_DATE DATE NOT NULL,
    PAY_POINT NUMBER,
    PAY_SUMPOINT NUMBER
);


-- 컬럼추가
ALTER TABLE TB_PAY
ADD (PAY_POINT NUMBER,
     PAY_SUMPOINT NUMBER);



--결제 인서트 테스트
INSERT INTO BOOK.TB_PAY (PAY_SEQ, PAY_IMD, USER_SEQ, PAY_PAYMENT, PAY_DATE, PAY_POINT, PAY_SUMPOINT)
SELECT 600000001, 'imd_98029849820', 53, 5000, SYSDATE, 0.01 * 5000, (SELECT SUM(PAY_POINT) FROM BOOK.TB_PAY WHERE USER_SEQ = 53)
FROM DUAL;
COMMIT;

--유저포인트 합계 테스트
 SELECT SUM(PAY_POINT) AS TOTAL_POINT
	    FROM TB_PAY
	    WHERE USER_SEQ = 53
	    GROUP BY USER_SEQ
	    HAVING SUM(PAY_POINT) >= 0;


-- 유저와 배송테이블 조인
SELECT *
FROM TB_DELIVERY D
JOIN TB_USER U ON D.USER_SEQ = U.USER_SEQ;

--두 테이블 조인 확인
SELECT D.*, U.*
FROM TB_DELIVERY D
LEFT JOIN TB_USER U ON D.USER_SEQ = U.USER_SEQ
WHERE U.USER_SEQ IS NOT NULL;


--유저의 맨 마지막 주소
 SELECT D.DELIVERY_SEQ, D.USER_SEQ, D.DELIVERY_NAME, D.DELIVERY_PHONE, D.POSTCODE, D.ADDRESS, D.DETADDR, D.EXTADDR, D.DELIVERY_NUM
    FROM TB_DELIVERY D
    LEFT JOIN TB_USER U ON D.USER_SEQ = U.USER_SEQ
    WHERE D.USER_SEQ = 1
    ORDER BY D.DELIVERY_SEQ  DESC  
    FETCH FIRST 1 ROW ONLY;
    
    
--송장번호 업데이트
UPDATE TB_DELIVERY 
SET DELIVERY_NUM = '5645489756'
WHERE DELIVERY_SEQ = '600020';


--전회원 결제내역
SELECT PAY_SEQ, PAY_IMD, USER_SEQ, PAY_PAYMENT, PAY_DATE
FROM BOOK.TB_PAY;

-- 유저의 결제내역
SELECT P.PAY_SEQ, P.PAY_IMD, P.USER_SEQ, P.PAY_PAYMENT, P.PAY_DATE
FROM TB_PAY P
INNER JOIN TB_USER U ON P.USER_SEQ = U.USER_SEQ
WHERE U.USER_SEQ =53
ORDER BY P.PAY_SEQ DESC;

-- 배송테이블 생성
CREATE TABLE TB_DELIVERY(
   DELIVERY_SEQ NUMBER PRIMARY KEY,
   USER_SEQ NUMBER REFERENCES TB_USER(USER_SEQ),
   RENT_SEQ NUMBER REFERENCES TB_BOOK_RENT(RENT_SEQ),
   DELIVERY_NAME VARCHAR2(30) NOT NULL,
   DELIVERY_PHONE VARCHAR2(30) NOT NULL,
   POSTCODE VARCHAR2(10) NOT NULL,
   ADDRESS VARCHAR2(100) NOT NULL,
   DETADDR VARCHAR2(100),
   EXTADDR VARCHAR2(100),
   DELIVERY_NUM NUMBER
);

CREATE SEQUENCE SQ_DELIVERY START WITH 1 INCREMENT BY 1;

DROP TABLE TB_DELIVERY;

ALTER TABLE TB_DELIVERY
ADD rent_seq NUMBER;


SELECT *
FROM TB_DELIVERY d
INNER JOIN TB_BOOK_RENT r
ON d.RENT_SEQ = r.RENT_SEQ;

-- 렌트 테이블의 맨 마지막 user_seq의 상태만 변경
   UPDATE TB_BOOK_RENT
    SET RENT_STATUS = 'B'
    WHERE USER_SEQ = 53
    AND RENT_SEQ = (
        SELECT MAX(RENT_SEQ)
        FROM TB_BOOK_RENT
        WHERE USER_SEQ = 53
    );



--두 개의 쿼리를 하나의 트랜잭션으로 실행
DECLARE
  v_user_seq NUMBER := 53; -- 사용자의 USER_SEQ 값
  v_delivery_name VARCHAR2(255) := '1'; -- 배송지 이름
  v_delivery_phone VARCHAR2(20) := '1'; -- 배송지 전화번호
  v_postcode VARCHAR2(10) := '1'; -- 우편번호
  v_address VARCHAR2(255) := '1'; -- 주소
  v_detaddr VARCHAR2(255) := '1'; -- 상세주소
  v_extaddr VARCHAR2(255) := '1'; -- 확장주소
BEGIN
  -- 첫 번째 쿼리: 배송지 주소 입력
  INSERT INTO TB_DELIVERY
  (DELIVERY_SEQ, USER_SEQ, DELIVERY_NAME, DELIVERY_PHONE, POSTCODE, ADDRESS, DETADDR, EXTADDR, DELIVERY_NUM)
  VALUES(SQ_DELIVERY.NEXTVAL, v_user_seq, v_delivery_name, v_delivery_phone, v_postcode, v_address, v_detaddr, v_extaddr, NULL);
  -- 두 번째 쿼리: 대출 상태 업데이트
  UPDATE TB_BOOK_RENT
  SET RENT_STATUS = 'A'
  WHERE USER_SEQ = v_user_seq;
  COMMIT; -- 트랜잭션 커밋
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK; -- 예외 발생 시 롤백
    RAISE;    -- 예외를 다시 던지거나 처리
END;



-- ★★★★★★FAQ
--관리자아이디 생성
INSERT INTO TB_USER (USER_SEQ, USER_EMAIL, USER_PASSWORD, USER_NAME, USER_PHONE, USER_BIRTH, USER_AUTH, USER_DELFLAG, JOINDATE, USER_GENDER)
VALUES (55, 'admin1@admin.com', 'asd123', '관리자', '010-7555-7864', '2005-07-14', 'A', 'N', '2022-07-18', 'F');


--FAQ 자주묻는 질문 생성
INSERT INTO BOOK.TB_FAQ_BOARD
(FAQ_SEQ, USER_SEQ, FAQ_CATEGORY, FAQ_TITLE, FAQ_CONTENT, FAQ_DELFLAG)
VALUES(SQ_FAQ_BOARD.NEXTVAL, 55,'도서이용일반', 'Q.도서 예약은 어떻게 하나요?', 'A. 예약버튼: 홈페이지 온라인 예약(00:00~24:00), 
예약 잔여분 및 취소분에 한해 당일 예약 가능 (00:00 ~ 24:00)
예약취소: 배송요청 당일까지 취소 가능', 'N');

INSERT INTO BOOK.TB_FAQ_BOARD
(FAQ_SEQ, USER_SEQ, FAQ_CATEGORY, FAQ_TITLE, FAQ_CONTENT, FAQ_DELFLAG)
VALUES(SQ_FAQ_BOARD.NEXTVAL, 55,'도서이용일반', 'Q.도서관 이용을 처음하려고 합니다. 어떤 절차로 이용해야 하나요?', 'A. 회원 등록(이용자 등록은 인터넷으로 하실 수 있습니다.) 및 회원번호를 발급받으신 후, 로그인하시고 이용하시면 됩니다.
또한 도서관 소장 자료는 도서관 내에서만 이용하실 수인 책을 가지고 공부할 수 있는 일반열람실은 운영하지 않습니다.', 'N');

INSERT INTO BOOK.TB_FAQ_BOARD
(FAQ_SEQ, USER_SEQ, FAQ_CATEGORY, FAQ_TITLE, FAQ_CONTENT, FAQ_DELFLAG)
VALUES(SQ_FAQ_BOARD.NEXTVAL, 55,'도서이용일반', 'Q.대출을 하려면 꼭 회원가입을 해야하나요?', 'A. 2005년 12월 1일부터 이용증을 발급 받아야 도서관 출입이 가능하며,
도서관 서비스(자료예약 및 신청, 디지털도서관 좌석 예약, 우편복사신청 등)를 제공받을 수 있습니다.
이용증을 발급 받기 위해서는 우선 회원가입을 해야 합니다', 'N');

INSERT INTO BOOK.TB_FAQ_BOARD
(FAQ_SEQ, USER_SEQ, FAQ_CATEGORY, FAQ_TITLE, FAQ_CONTENT, FAQ_DELFLAG)
VALUES(SQ_FAQ_BOARD.NEXTVAL, 55,'비치희망도서자료신청', 'Q.희망도서 신청은 어떻게 하나요?', 'A. 자료검색에서 찾고자 하는 자료가 검색결과에 없을 경우 “자유게시판” 클릭을 통해 신청하실 수 있습니다. 로그인 후 신청하시고자 하는 자료명, 저자명, 출판사 등을 입력하시면 됩니다.', 'N');

INSERT INTO BOOK.TB_FAQ_BOARD
(FAQ_SEQ, USER_SEQ, FAQ_CATEGORY, FAQ_TITLE, FAQ_CONTENT, FAQ_DELFLAG)
VALUES(SQ_FAQ_BOARD.NEXTVAL, 55,'회원가입관련', 'Q.본인확인이 되지 않는데 어떻게 해야 하나요?', 'A.개정 정보통신망법 제23조에 따라 회원 가입시에는 주민등록번호를 수집하지 않습니다.
I-PIN인증 또는 휴대폰 인증 중 하나를 선택하여 회원가입을 진행해야 합니다.
인증이 되지 않을 경우 각 고객센터로 문의하시기 바랍니다.
- KCB아이핀 고객센터
ㆍ연락처: 02-708-1000, cs_okname@koreacb.com
- 한국모바일인증(주) 고객센터
ㆍ연락처: 1644-1863, webmaster@kmcert.com
ㆍ운영시간: 월~금, 09:30~18:30', 'N');

INSERT INTO BOOK.TB_FAQ_BOARD
(FAQ_SEQ, USER_SEQ, FAQ_CATEGORY, FAQ_TITLE, FAQ_CONTENT, FAQ_DELFLAG)
VALUES(SQ_FAQ_BOARD.NEXTVAL, 55,'회원가입관련', 'Q.본인확인이 되지 않는데 어떻게 해야 하나요?', 'A. □ 온라인에서 무분별하게 수집·보유 중인 개인정보에 유효기간을 두어 오남용을 최소화한다는 취지로 만들어진 것으로 일정기간 이용하지 않는 회원의 개인정보를 파기 또는 별도 분리 보관하는 등 조치를 하여야 합니다.
□「개인정보 보호법」제21조 제1항, 제3항 및 「 계발의 민족 홈페이지 개인정보처리방침」에 의거하여 2년 이상  계발의 민족을 이용하지 않은 회원의 계정을 휴면 전환하고, 해당 회원의 개인정보를 파기 또는 분리 보관 조치합니다.
□ 휴면 전환 대상
2년 이상 계발의 민족 홈페이지 또는 모바일 서비스에 로그인하지 않았거나 도서관 방문 이용 실적이 없는 회원
※「개인정보 보호법」 제21조(개인정보의 파기)
① 개인정보처리자는 보유기간의 경과, 개인정보의 처리 목적 달성 등 그 개인정보가 불필요하게 되었을 때에는 지체 없이 그 개인정보를 파기하여야 한다.
③ 개인정보처리자가 제1항 단서에 따라 개인정보를 파기하지 아니하고 보존하여야 하는 경우에는 해당 개인정보 또는 개인정보파일을 다른 개인정보와 분리하여서 저장·관리하여야 한다.
「홈페이지 개인정보처리방침」개인정보의 수집 및 보유
 계발의 민족 통합회원 : 마지막 이용일로부터 5년', 'N');



INSERT INTO BOOK.TB_FAQ_BOARD
(FAQ_SEQ, USER_SEQ, FAQ_CATEGORY, FAQ_TITLE, FAQ_CONTENT, FAQ_DELFLAG)
VALUES(SQ_FAQ_BOARD.NEXTVAL, 55,'회원가입관련', 'Q.회원탈퇴는 어떻게 하나요?', 'A.국립중앙도서관 홈페이지 로그인 => ‘회원정보수정’ => ‘회원탈퇴’ 메뉴 클릭', 'N');

INSERT INTO BOOK.TB_FAQ_BOARD
(FAQ_SEQ, USER_SEQ, FAQ_CATEGORY, FAQ_TITLE, FAQ_CONTENT, FAQ_DELFLAG)
VALUES(SQ_FAQ_BOARD.NEXTVAL, 55,'자료검색및대출', 'Q.도서 검색은 어떻게 하나요?', 'A.홈페이지 검색창에 자료 제목, 저자명, 발행자 등을 입력해 소장자료를 검색합니다.', 'N');

INSERT INTO BOOK.TB_FAQ_BOARD
(FAQ_SEQ, USER_SEQ, FAQ_CATEGORY, FAQ_TITLE, FAQ_CONTENT, FAQ_DELFLAG)
VALUES(SQ_FAQ_BOARD.NEXTVAL, 55,'자료검색및대출', 'Q.도서 배송신청은 어떻게 하나요?', 'A. 홈페이지 대출신청 이후 주소지를 입력하고 배송비를 지불하면 대출이 실행됩니다.', 'N');
INSERT INTO BOOK.TB_FAQ_BOARD
(FAQ_SEQ, USER_SEQ, FAQ_CATEGORY, FAQ_TITLE, FAQ_CONTENT, FAQ_DELFLAG)
VALUES(SQ_FAQ_BOARD.NEXTVAL, 55,'자료검색및대출', 'Q.도서 배송신청은 어떻게 하나요?', 'A. 홈페이지 대출신청 이후 주소지를 입력하고 배송비를 지불하면 대출이 실행됩니다.', 'N');


--새글등록
SELECT SQ_FAQ_BOARD.NEXTVAL FROM DUAL;

--전체FAQ조회
SELECT FAQ_SEQ, USER_SEQ, FAQ_CATEGORY, FAQ_TITLE, FAQ_CONTENT, FAQ_DELFLAG
FROM BOOK.TB_FAQ_BOARD;

--FAQ 게시글 삭제
UPDATE BOOK.TB_FAQ_BOARD SET FAQ_DELFLAG='Y'
WHERE FAQ_DELFLAG='N'
AND FAQ_SEQ='10';


--게시글 수정
UPDATE BOOK.TB_FAQ_BOARD SET FAQ_CONTENT='A. 답변내용 수정중'
WHERE FAQ_SEQ='10';

--목록별 FAQ조회
SELECT FAQ_SEQ, USER_SEQ, FAQ_CATEGORY, FAQ_TITLE, FAQ_CONTENT, FAQ_DELFLAG
		FROM BOOK.TB_FAQ_BOARD
		WHERE FAQ_CATEGORY ='자료검색및대출';

		
--6개 내용 메인에 출력
	SELECT FAQ_SEQ, USER_SEQ, FAQ_CATEGORY, FAQ_TITLE, FAQ_CONTENT, FAQ_DELFLAG
	FROM (
	    SELECT FAQ_SEQ, USER_SEQ, FAQ_CATEGORY, FAQ_TITLE, FAQ_CONTENT, FAQ_DELFLAG,
	           ROW_NUMBER() OVER (ORDER BY FAQ_SEQ DESC) AS RNUM
	    FROM BOOK.TB_FAQ_BOARD
	    WHERE FAQ_DELFLAG = 'N'
	) FAQ
	WHERE RNUM <= 6;
