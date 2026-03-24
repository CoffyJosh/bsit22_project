package com.comprog22.onlineshop.controller;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import org.springframework.web.bind.annotation.GetMapping;
import com.comprog22.onlineshop.model.Student;


@RestController
public class TestController {

    @PostMapping("/addStudent")
    public String addStudent(@RequestBody Student student) {
        return String.format("INFORMATION TEST:\nName: %s\nAge: %d\nCourse: %s\n", student.getName(), student.getAge(), student.getCourse());
    }

    @GetMapping("/helloWorld")
    public String getMethodName() {
        return "Hello World my Niggas!";
    }
}
    
