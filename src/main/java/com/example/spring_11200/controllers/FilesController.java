package com.example.spring_11200.controllers;

import com.example.spring_11200.models.FileInfo;
import com.example.spring_11200.services.FileStorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Controller
public class FilesController {

     @Autowired
     private FileStorageService fileStorageService;

    @GetMapping("/files/upload")
    public String getFilesUploadedPage() {
        return "file_upload_page";
    }

    @PostMapping("/files")
    public ResponseEntity<String> fileUpload(@RequestParam("file")MultipartFile file, @RequestParam("description") String description){
        String filePath = fileStorageService.saveFile(file, description);
        return ResponseEntity.ok()
                .body(filePath);
    }

    @GetMapping("/files/{file-name:.+}")
    public void getFile(@PathVariable("file-name") String fileName, HttpServletResponse response){
        fileStorageService.writeFileToResponse(fileName, response);

    }
    @GetMapping("/files/all")
    public ResponseEntity<List<FileInfo>> getAllFiles() {
        List<FileInfo> files = fileStorageService.getAllFiles();
        return ResponseEntity.ok(files);
    }
    @PostMapping("/files/like/{file-id}")
    public ResponseEntity<String> likeFile(@PathVariable("file-id") Long fileId) {
        fileStorageService.likeFile(fileId);
        return ResponseEntity.ok().body("Liked");
    }
    @GetMapping("/files/listFiles")
    public String getListFilesPage(Model model) {
        List<FileInfo> files = fileStorageService.getAllFiles();
        model.addAttribute("files", files);
        return "listFiles"; // Devolver el nombre de la página HTML
    }
}
