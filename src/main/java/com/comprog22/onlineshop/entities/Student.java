package com.comprog22.onlineshop.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "student")
public class Student {

    @Id 
    @GeneratedValue(strategy=GenerationType.AUTO)
    @Column(name = "student_id")
    private Long stud_id;

    @Column(name = "student_name")
    private String stud_name;

    @Column(name = "student_age")
    private Long age;

    @Column(name = "student_course")
    private String course;
    public Long getId() {
        return stud_id;
    }
    public void setId(Long stud_id) {
        this.stud_id = stud_id;
    }
    public String getName() {
        return stud_name;
    }
    public void setName(String stud_name) {
        this.stud_name = stud_name;
    }
    public Long getAge() {
        return age;
    }
    public void setAge(Long age) {
        this.age = age;
    }
    public String getCourse() {
        return course;
    }
    public void setCourse(String course) {
        this.course = course;
    }
}
