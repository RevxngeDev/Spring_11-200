package com.example.spring_11200.services;

import com.example.spring_11200.dto.ServiceDto;
import com.example.spring_11200.dto.ServiceForm;

import java.util.List;

public interface ServiceService {

    ServiceDto addService(ServiceForm serviceForm);

    List<ServiceDto> getAllServices();

    List<ServiceDto> search(Integer page, Integer size, String query, String sortParametr, String direction);
}
