package kr.ajax.board.service;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ajax.board.dao.BoardDAO;
import kr.ajax.board.dto.BoardDTO;

@Service
public class BoardService {
	Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired BoardDAO dao;
	
	public String file_root = "/Users/jeounghun/upload/";

	public List<BoardDTO> list() {
		
		return dao.list();
	}

	public int del(ArrayList<String> delList) {
		
		int cnt = 0;
		for (String idx : delList) {
			List<String> list = dao.fileName(idx);
			cnt += dao.del(idx);
			delFile(list);
		}
		
		return cnt;
	}

	private void delFile(List<String> list) {
		for (String name : list) {
			File file = new File(file_root + name);
			if (file.exists()) {
				file.delete();
			}					
		}
	}

	
}
