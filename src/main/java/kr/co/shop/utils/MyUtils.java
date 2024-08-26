package kr.co.shop.utils;

import java.time.LocalDate;
import java.time.format.TextStyle;
import java.util.Locale;

public class MyUtils {

	public static String getYoil(LocalDate xday) {
		String yoil=xday.getDayOfWeek().getDisplayName(TextStyle.SHORT, Locale.KOREAN);
		
		return yoil;
	}
}
