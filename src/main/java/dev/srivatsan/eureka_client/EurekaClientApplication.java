package dev.srivatsan.eureka_client;

import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

@EnableDiscoveryClient
@SpringBootApplication
public abstract class EurekaClientApplication implements CommandLineRunner {

    private final EurekaInstanceService eurekaInstanceService;

    public EurekaClientApplication(EurekaInstanceService eurekaInstanceService) {
        this.eurekaInstanceService = eurekaInstanceService;
    }

    public static void main(String[] args) {
        SpringApplication.run(EurekaClientApplication.class, args);
    }

    @Override
    public void run(String... args) throws Exception {
        eurekaInstanceService.getActiveInstance();
    }

}
