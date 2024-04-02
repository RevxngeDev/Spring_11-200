package com.example.spring_11200.controllers;

import com.example.spring_11200.dto.ServiceDto;
import com.example.spring_11200.dto.ServiceForm;
import com.example.spring_11200.services.ServiceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ServiceController {
    @Autowired
    private ServiceService serviceService;

    @PostMapping("/services")
    @ResponseBody
    public ResponseEntity<ServiceDto> addService(@RequestBody ServiceForm serviceForm){
        return ResponseEntity.ok(serviceService.addService(serviceForm));
    }

    @GetMapping("/service")
    public String getAllServices(Model model, @RequestParam(value = "page", defaultValue = "0") int page, @RequestParam(value = "size", defaultValue = "3") int size){
        Page<ServiceDto> services = serviceService.getAllServices(page, size);
        model.addAttribute("servicesList", services.getContent());
        return "service";
    }

    @GetMapping("/allservices")
    @ResponseBody
    public ResponseEntity<Page<ServiceDto>> getAllServices(@RequestParam(value = "page", defaultValue = "0") int page, @RequestParam(value = "size", defaultValue = "3") int size){
        return ResponseEntity.ok(serviceService.getAllServices(page, size));
    }

    @GetMapping("/paper/service/search")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> search(@RequestParam("size") Integer size,
                                                      @RequestParam("page") Integer page,
                                                      @RequestParam(value = "q", required = false) String query,
                                                      @RequestParam(value = "sort", required = false) String sort,
                                                      @RequestParam(value = "direction", required = false) String direction) {
        Page<ServiceDto> servicePage = serviceService.search(page, size, query, sort, direction);

        Map<String, Object> response = new HashMap<>();
        response.put("content", servicePage.getContent());
        response.put("totalPages", servicePage.getTotalPages());
        response.put("totalElements", servicePage.getTotalElements());
        response.put("currentPage", servicePage.getNumber());

        return ResponseEntity.ok(response);
    }
}
