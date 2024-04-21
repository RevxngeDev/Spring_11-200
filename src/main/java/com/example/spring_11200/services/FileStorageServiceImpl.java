package com.example.spring_11200.services;

import com.example.spring_11200.models.FileInfo;
import com.example.spring_11200.repositores.FilesRepository;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.FileInputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.UUID;

@Component
public class FileStorageServiceImpl implements FileStorageService{
    @Value("${storage.path}")
    private String storagePath;

    @Autowired
    private FilesRepository filesRepository;

    @Override
    public String saveFile(MultipartFile file) {
        String storageName = UUID.randomUUID().toString() + "." +
                FilenameUtils.getExtension(file.getOriginalFilename());



        FileInfo fileInfo =  FileInfo.builder()
                .originalFileName(file.getOriginalFilename())
                .type(file.getContentType())
                .size(file.getSize())
                .storageFileName(storageName)
                .url(storagePath + "\\" + storageName)
                .build();
        try {
            Files.copy(file.getInputStream(), Paths.get(storagePath, storageName));

        } catch (Exception e) {
            throw new RuntimeException("Could not store the file. Error: " + e.getMessage());
        }

        filesRepository.save(fileInfo);
        return fileInfo.getStorageFileName();

    }

    @Override
    public void writeFileToResponse(String fileName, HttpServletResponse response) {
        FileInfo fileInfo = filesRepository.findByStorageFileName(fileName);
        response.setContentType(fileInfo.getType());

        try {
            IOUtils.copy(new FileInputStream(fileInfo.getUrl()), response.getOutputStream());
            response.flushBuffer();
        } catch (Exception e) {
            throw new RuntimeException("Could not read the file. Error: " + e.getMessage());
        }
    }
}
