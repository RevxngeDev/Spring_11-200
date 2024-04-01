package com.example.spring_11200.services;

import com.example.spring_11200.dto.ServiceDto;
import com.example.spring_11200.dto.ServiceForm;
import com.example.spring_11200.models.Service;
import com.example.spring_11200.repositores.ServiceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class ServiceServiceImpl implements ServiceService {

    @Autowired
    private ServiceRepository serviceRepository;

    @Override
    public ServiceDto addService(ServiceForm serviceForm) {
        Service service = Service.builder()
                .name(serviceForm.getName())
                .cost(serviceForm.getCost())
                .date(serviceForm.getDate())
                .build();
        serviceRepository.save(service);
        return ServiceDto.of(service);
    }

    @Override
    public List<ServiceDto> getAllServices() {
        return ServiceDto.from(serviceRepository.findAll());
    }

    public List<ServiceDto> search(Integer page, Integer size, String query, String sortParameter, String directionParametr) {
        Sort.Direction direction = Sort.Direction.ASC;
        Sort sort = Sort.by(direction, "id");

        if (directionParametr != null) {
            direction = Sort.Direction.fromString(directionParametr);
        }

        if (sortParameter != null) {
            sort = Sort.by(direction, sortParameter);
        }

        if (query == null) {
            query = "empty";
        }

        if (size == null) {
            size = 3;
        }
        PageRequest pageRequest = PageRequest.of(page, size, sort);
        Page<Service> papersPage = serviceRepository.search(query, pageRequest);
        return ServiceDto.from(papersPage.getContent());
    }
}
