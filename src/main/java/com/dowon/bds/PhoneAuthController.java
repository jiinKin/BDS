package com.dowon.bds;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;

import lombok.extern.slf4j.Slf4j;
import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.exception.NurigoMessageNotReceivedException;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.service.DefaultMessageService;

@Slf4j
@RestController
public class PhoneAuthController {
	
	private String randomCode;
    
    @PostMapping("/sendPhoneSMS.do")
    public String sendSMS(@RequestParam String user_phone) {
    	log.info("값 체크 : {}",user_phone);
        Random random = new Random();
        int randomNum = random.nextInt(900000)+100000;
        randomCode = ""+randomNum;
    
     DefaultMessageService messageService =  NurigoApp.INSTANCE.initialize("NCSE64I8LHDGKT6T", "VV0QN0ZOFAFNWXISEHJ9IFM7KFLEBEKR", "https://api.coolsms.co.kr");
	 Message message = new Message();
	 message.setFrom("01092465759");
	 message.setTo(user_phone);
	 message.setText("도원결의 비대면 도서대출 시스템 본인인증 " + randomNum + " 입력해주세요.");
		 try {
		   // send 메소드로 ArrayList<Message> 객체를 넣어도 동작합니다!
		   messageService.send(message);
		 } catch (NurigoMessageNotReceivedException exception) {
		   // 발송에 실패한 메시지 목록을 확인할 수 있습니다!
		   System.out.println(exception.getFailedMessageList());
		   System.out.println(exception.getMessage());
		 } catch (Exception exception) {
		   System.out.println(exception.getMessage());
		 }
	return "success";
    }
    
    @PostMapping(value="/checkSMS.do")
    public String checkSMS(@RequestParam String userInputCode) {
    	log.info(userInputCode);
    	log.info(randomCode);
    	
    	if(userInputCode.equals(randomCode)) {
    		return "success";
    	}else {
    		return "error";
    	}
    	
    }
}