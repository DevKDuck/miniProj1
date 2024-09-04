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
	
	private String action;

	public BoardVO(int bno, String btitle, String bcontent, String member_id, String bdate, int bcount,
			String bwriter) {
		super();
		this.bno = bno;
		this.btitle = btitle;
		this.bcontent = bcontent;
		this.member_id = member_id;
		this.bdate = bdate;
		this.bcount = bcount;
		this.bwriter = bwriter;
	}

	public BoardVO(int bno, String btitle, String bcontent, String bwriter) {
		super();
		this.bno = bno;
		this.btitle = btitle;
		this.bcontent = bcontent;
		this.bwriter = bwriter;
	}
	
	
	
}
