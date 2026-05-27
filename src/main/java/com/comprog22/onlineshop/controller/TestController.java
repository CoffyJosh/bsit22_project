package com.comprog22.onlineshop.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.comprog22.onlineshop.entities.Student;
import com.comprog22.onlineshop.entities.User;
import com.comprog22.onlineshop.repository.StudentRepo;
import com.comprog22.onlineshop.services.UserService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;



@RestController
@RequestMapping("/s")
public class TestController {

    @Autowired
    private UserService userService;
    
    @GetMapping("/helloWorld")
    public String getMethodName() {
        return "Hello World my Niggas!";
    }

    @GetMapping("/testing/hello")
    public String helloPage(@RequestParam(name = "name") String name){
        return "Hello " + name;
    }

    @GetMapping("/testing/getUser")
    public User getUser(@RequestParam(name = "email") String email) {
        return userService.getUserInfoByEmail(email).orElseThrow();
    }

    @Autowired
	private StudentRepo studentRepository;
    
    @GetMapping("/getStudents")
	public @ResponseBody Iterable<Student> getStudents() {
		return studentRepository.findAll();
	}

    @PostMapping("/addStudent")
    public Student postMethodName(@RequestBody Student student) {
        Student s = new Student();
        s.setName(student.getName());
        s.setAge(student.getAge());
        s.setCourse(student.getCourse());
        
        return studentRepository.save(s);
    } 

    @GetMapping("/getStudentById")
    public Student getMethodName(@RequestParam Long id) {
        return studentRepository.getStudentById(id);
    }
    
}
    
