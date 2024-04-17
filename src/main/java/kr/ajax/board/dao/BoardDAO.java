package kr.ajax.board.dao;

import java.util.List;

import kr.ajax.board.dto.BoardDTO;

public interface BoardDAO {

	List<BoardDTO> list();

	List<String> fileName(String idx);

	int del(String idx);


}
