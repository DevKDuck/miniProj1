package member;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@Builder
@NoArgsConstructor
public class HobbyVO {
	private String hobby_id;
	private String hobby_name;
	
	public boolean isEqualHobbyId(String hobby_id) {
		return this.hobby_id.equals(hobby_id);
	}
}
