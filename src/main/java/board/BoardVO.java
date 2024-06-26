package board;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@Builder
@NoArgsConstructor
public class BoardVO {
	private int bno;
	private String btitle;
	private String bcontent;
	private String member_id;
	private String bdate;
	private int bcount;
	private String bwriter;
}
