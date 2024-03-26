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
	private String memberid;
	private String memberpwd;
	private String membername;
	private String memberaddress;
	private String memberphonenumber;
	private String membergender;

}
