package dev.srivatsan.eureka_client;

import com.netflix.appinfo.InstanceInfo;
import com.netflix.discovery.EurekaClient;
import com.netflix.discovery.shared.Application;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.concurrent.TimeUnit;

@Slf4j
@Service
public class EurekaInstanceService {

    @Value("${spring.application.name}")
    private String appName;

    private final EurekaClient eurekaClient;

    public EurekaInstanceService(EurekaClient eurekaClient) {
        this.eurekaClient = eurekaClient;
    }

    @Async
    public void getActiveInstance() throws InterruptedException {
        log.info("Starting :: LiveInstanceService :: getActiveInstance for appName - {}", appName);

        while (true) {
            Application application = eurekaClient.getApplication(appName);
            if (application != null) {
                List<InstanceInfo> instances = application.getInstances();
                log.info("Total Applications Registered with AppName - '{}' - '{}'", appName, instances.size());

                instances.forEach(System.out::println);

            } else {
                log.info("No Applications Registered! AppName - '{}'", appName);
            }

            TimeUnit.SECONDS.sleep(10);
        }

    }

}
