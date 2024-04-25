package com.example.spring_11200.services;

import com.example.spring_11200.models.FileInfo;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

public interface FileStorageService {

    String saveFile(MultipartFile file, String description);
    void writeFileToResponse(String fileName, HttpServletResponse response);
    List<FileInfo> getAllFiles();
    void likeFile(long fileId);
}
