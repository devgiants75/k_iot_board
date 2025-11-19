package org.example.boardback.controller;

import lombok.RequiredArgsConstructor;
import org.example.boardback.common.apis.BoardApi;
import org.example.boardback.service.impl.BoardFileServiceImpl;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@RestController
@RequestMapping(BoardApi.ROOT)
@RequiredArgsConstructor
public class BoardController {
    private final BoardFileServiceImpl boardFileService;

    @PostMapping(BoardApi.ID_ONLY + "/files")
    public ResponseEntity<?> uploadBoardFiles(
            @PathVariable Long boardId,
            @RequestParam("files") List<MultipartFile> files
    ) {
        boardFileService.uploadBoardFiles(boardId, files);
        return ResponseEntity.ok("업로드 성공");
    }
}
