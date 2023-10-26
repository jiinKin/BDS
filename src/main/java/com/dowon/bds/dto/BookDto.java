package com.dowon.bds.dto;

import java.util.Date;
import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * @author 박하은
 * @since 2023.09.06 도서정보 Dto
 */

@Data
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class BookDto {

	private int book_seq;
	private String book_title;
	private String book_writer;
	private String book_img;
	private String book_isbn;
	private String book_intro;
	private String book_publisher;
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
	private Date book_published_date;
	private String book_published_dateStr;
	private String book_index;
	private String book_summary;
		
	
}
