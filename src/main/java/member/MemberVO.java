package member;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@Builder
@NoArgsConstructor
public class MemberVO {
	public MemberVO(String member_id, String member_pwd, String member_name, String member_address,
			String member_phonenumber, String member_gender) {
		super();
		this.member_id = member_id;
		this.member_pwd = member_pwd;
		this.member_name = member_name;
		this.member_address = member_address;
		this.member_phonenumber = member_phonenumber;
		this.member_gender = member_gender;
	}

	private String member_id;
	private String member_pwd;
	private String member_pwd2;
	private String member_name;
	private String member_address;
	private String member_phonenumber;
	private String member_gender;
	private String hobby_name;
	private List<HobbyVO> member_hobbies;
	private List<String> hobbies;
	
	//실행 명령키
	private String action;
	
	public MemberVO(String member_id, String member_pwd, String member_name, String member_address,
			String member_phonenumber, String member_gender, String hobby_name) {
		super();
		this.member_id = member_id;
		this.member_pwd = member_pwd;
		this.member_name = member_name;
		this.member_address = member_address;
		this.member_phonenumber = member_phonenumber;
		this.member_gender = member_gender;
		this.hobby_name = hobby_name;
	}


	public boolean isCheckedHobbyId(String hobby_id) {
		if (member_hobbies != null) return member_hobbies.stream().anyMatch(hobby -> hobby.isEqualHobbyId(hobby_id));
		return false;
	}

}
