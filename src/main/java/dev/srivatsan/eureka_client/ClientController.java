package dev.srivatsan.eureka_client;

import com.netflix.appinfo.InstanceInfo;
import com.netflix.discovery.EurekaClient;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Lazy;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
public class ClientController {

    private final EurekaClient eurekaClient;

    public ClientController(@Lazy EurekaClient eurekaClient) {
        this.eurekaClient = eurekaClient;
    }

    @GetMapping("ping")
    public ResponseEntity<String> getPingDetails() {
        InstanceInfo info = eurekaClient.getApplicationInfoManager().getInfo();
        String currentAppDetails = info.toString();
        return ResponseEntity.ok(currentAppDetails);
    }

}
