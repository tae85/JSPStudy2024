package common;

public class MyClass {

	public static int myFunc(int n1, int n2) {
		int sum = 0;
		for(int i = n1; i <= n2; i++) {
			sum += i;
		}
		return sum;
	}
}
