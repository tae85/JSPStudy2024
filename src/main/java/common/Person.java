package common;

public class Person {
	//멤버변수
	private String name;
	private int age;
	
	//디폴트(기본) 생성자
	public Person() {}	
	
	//인수(인자) 생성자
	public Person(String name, int age) {
		super();
		this.name = name;
		this.age = age;
	}
	
	//getter/setter 메서드
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	
}
