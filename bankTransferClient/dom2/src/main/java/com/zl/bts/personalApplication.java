package com.zl.bts;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.cloud.client.circuitbreaker.EnableCircuitBreaker;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;

@SpringBootApplication
@MapperScan("com.zl.bts.dao")
/** 如果是其他的注册中心，那么推荐使用
  @EnableDiscoveryClient
  */
@EnableEurekaClient /*仅用于使用Eureka作为注册中心*/
@EnableCaching  //开启redis注解模式
@EnableCircuitBreaker //开启Hystrix断路器
public class personalApplication {

	public static void main(String[] args) {
		SpringApplication.run(personalApplication.class, args);
	}

}