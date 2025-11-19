package org.example.boardback.service.impl;

import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.example.boardback.entity.board.Board;
import org.example.boardback.entity.file.BoardFile;
import org.example.boardback.entity.file.FileInfo;
import org.example.boardback.repository.board.BoardRepository;
import org.example.boardback.repository.file.BoardFileRepository;
import org.example.boardback.repository.file.FileInfoRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Service
@RequiredArgsConstructor
public class BoardFileServiceImpl {
    private final FileServiceImpl fileService;
    private final BoardFileRepository boardFileRepository;
    private final FileInfoRepository fileInfoRepository;
    private final BoardRepository boardRepository;

    private final int MAX_ATTACH = 5;

    @Transactional
    public void uploadBoardFiles(Long boardId, List<MultipartFile> files) {

        Board board = boardRepository.findById(boardId)
                .orElseThrow(() -> new EntityNotFoundException("Board not found with id: " + boardId));

        if (files.size() > MAX_ATTACH) throw new IllegalArgumentException("최대 " + MAX_ATTACH + "개까지 업로드 가능");

        int order = 0;

        for (MultipartFile mf : files) {
            FileInfo info = fileService.saveBoardFile(boardId, mf);

            BoardFile boardFile = BoardFile.of(board, info, order++);

            boardFileRepository.save(boardFile);
        }
    }
}
