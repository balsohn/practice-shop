package kr.co.shop;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

@Service
public class MyScheduler {

	// fixedRate, fixedDelay, cron
	@Scheduled(fixedRate = 1000)
	public void test() {
		
	}
}
