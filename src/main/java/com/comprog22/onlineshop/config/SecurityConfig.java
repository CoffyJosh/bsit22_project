package com.comprog22.onlineshop.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {

        http.csrf(csrf -> csrf.disable())
            .authorizeHttpRequests(auth -> auth
                .requestMatchers(
                    "/",
                    "/api/**",
                    "/browse/**",
                    "/index",
                    
                    "/login",
                    "/register",
                    "/account-recovery/**",
                    "/admin/**",

                    "/checkout/**",
                    "/game/**",
                    "/package/**",
                    "/uploads/**",
                    
                    "/s/**",
                    "/css/**",
                    "/images/**",
                    "/js/**",

                    "/error",
                    "/testing/**")
                .permitAll()
                .anyRequest().authenticated())
            .formLogin(form -> form
                .loginPage("/login")
                .loginProcessingUrl("/login")
                .successHandler((request, response, authentication) -> {
                    if ("true".equals(request.getHeader("HX-Request"))) {
                        response.setHeader("HX-Redirect", "/");
                        response.setStatus(200);
                    } else {
                        response.sendRedirect("/");
                    }
                })
                .failureHandler((request, response, exception) -> {
                    if ("true".equals(request.getHeader("HX-Request"))) {
                        response.setHeader("HX-Redirect", "/login?error");
                        response.setStatus(200);
                    } else {
                        response.sendRedirect("/login?error");
                    }
                })
                .permitAll())
            .logout(logout -> logout
                .logoutUrl("/logout")
                .logoutSuccessUrl("/login?logout")
                .permitAll());

        return http.build();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

}
