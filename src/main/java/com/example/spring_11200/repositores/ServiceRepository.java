package com.example.spring_11200.repositores;

import com.example.spring_11200.models.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface ServiceRepository extends JpaRepository<Service, Long> {

    @Query("select service from Service service where (:q = 'empty' or UPPER(service.name) like UPPER(concat('%', :q, '%')))")
    Page<Service> search(@Param("q") String q, Pageable pageable);
}
