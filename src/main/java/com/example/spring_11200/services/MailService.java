package com.example.spring_11200.services;

public interface MailService {

    void sendEmailForConfirm(String email, String code);
}
