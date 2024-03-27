package member;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@Builder
@NoArgsConstructor
public class MemberVO {
	private String member_id;
	private String member_pwd;
	private String member_name;
	private String member_address;
	private String member_phonenumber;
	private String member_gender;
	

	//실행 명령키
	private String action;
	
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




}
