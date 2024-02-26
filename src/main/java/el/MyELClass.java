package el;

public class MyELClass {
	
	//주민번호를 인수로 받아 성별을 판단한다. 
    public String getGender(String jumin) {
        String returnStr = "";
        //123456-1234567 형태의 주민번호에서 -(하이픈) 다음의 문자의 
        //인덱스를 찾는다. 
        int beginIdx = jumin.indexOf("-") + 1;
        //성별에 해당하는 문자를 잘라낸다. 
        String genderStr = jumin.substring(beginIdx, beginIdx + 1);
        //비교연산을 위해 정수로 변환한다. 
        int genderInt = Integer.parseInt(genderStr);
        //성별을 판단한다. 
        if (genderInt == 1 || genderInt == 3)
            returnStr = "남자";
        else if (genderInt == 2 || genderInt == 4) 
            returnStr = "여자";
        else
            returnStr = "주민번호 오류입니다.";
        return returnStr;
    }
    
    //매개변수로 전달된 단 만큼의 구구단을 table형태로 반환한다. 
    public static String showGugudan(int limitDan) {
    	/* 문자열의 변경이 많은 경우 StringBuffer클래스를 사용하는것이
    	유리하다. String클래스의 경우 문자열이 변경될때마다 새로운 
    	메모리를 할당하므로 낭비가 심하다. */
        StringBuffer sb = new StringBuffer();
        try {
        	//append()메서드를 통해 문자열을 연결한다. 
            sb.append("<table border='1'>");
            for (int i = 2; i <= limitDan; i++) {
                sb.append("<tr>");
                for (int j = 1; j <= 9; j++) {
                    sb.append("<td>" + i + "*" + j + "=" + (i * j) + "</td>");
                }
                sb.append("</tr>");
            }
            sb.append("</table>");
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        //StringBuffer객체를 String으로 형변환 후 반환한다. 
        return sb.toString();
    }
}
