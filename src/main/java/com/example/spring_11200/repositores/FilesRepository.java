package com.example.spring_11200.repositores;

import com.example.spring_11200.models.FileInfo;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FilesRepository extends JpaRepository<FileInfo, Long>{

    FileInfo findByStorageFileName(String fileName);
}
