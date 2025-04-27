package com.WatchX.model;

public class UserModel {
    private int userNo;
    private String firstName;
    private String lastName;
    private String userName;
    private String email;
    private String contactNumber;
    private String address;
    private String password;
    
    public UserModel() {
    }
    public UserModel(String userName, String password) {
        this.userName = userName;
        this.password = password;
    }

	public UserModel(int userNo, String firstName, String lastName, String userName, String email, String contactNumber,
			String address, String password) {
		super();
		this.userNo = userNo;
		this.firstName = firstName;
		this.lastName = lastName;
		this.userName = userName;
		this.email = email;
		this.contactNumber = contactNumber;
		this.address = address;
		this.password = password;
	}
    
	 public UserModel(String firstName, String lastName, String userName, String email, 
             String contactNumber, String address, String password) {
		this.firstName = firstName;
		this.lastName = lastName;
		this.userName = userName;
		this.email = email;
		this.contactNumber = contactNumber;
		this.address = address;
		this.password = password;
}
	 public UserModel(int userNo, String firstName, String lastName, String email, String contactNumber) {
	        this.userNo = userNo;
	        this.firstName = firstName;
	        this.lastName = lastName;
	        this.email = email;
	        this.contactNumber = contactNumber;
	    }
	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getContactNumber() {
		return contactNumber;
	}
	public void setContactNumber(String contactNumber) {
		this.contactNumber = contactNumber;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}

}