package com.zl.bts;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.cloud.client.circuitbreaker.EnableCircuitBreaker;
import org.springframework.cloud.client.loadbalancer.LoadBalanced;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.Bean;
import org.springframework.jms.annotation.EnableJms;
import org.springframework.web.client.RestTemplate;

import com.netflix.loadbalancer.IRule;
import com.netflix.loadbalancer.RoundRobinRule;

@SpringBootApplication
/*@MapperScan("com.zl.bts.dao")*/
/** 如果是其他的注册中心，那么推荐使用
  @EnableDiscoveryClient
  */
@EnableEurekaClient /*仅用于使用Eureka作为注册中心*/
/*@EnableCaching  //开启redis注解模式
*/@EnableCircuitBreaker //开启Hystrix断路器
/*@EnableJms //启动消息队列 */
/*@EnableScheduling*/ //开启定时间隔投递
public class BankServerApplication {

	public static void main(String[] args) {
		SpringApplication.run(BankServerApplication.class, args);
	}

	@Bean
	@LoadBalanced
	public RestTemplate getRestTemplate() {
		return new RestTemplate();
	}
	@Bean
	public  IRule  ribbon() {
		return new RoundRobinRule();
	}
}