
## 🛠️ 프로젝트 환경 설정 개요
GISuite 프로젝트의 환경 설정을 구성하는 주요 요소는 다음과 같습니다:

1. **`application.yml`** - 데이터베이스 및 기본 설정 관리
2. **`DatabaseConfig.java`** - PostgreSQL + PostGIS 데이터베이스 설정
3. **`WebConfig.java`** - 정적 리소스 및 CORS 설정
4. **`SwaggerConfig.java`** - API 문서화 설정 (Swagger UI)

---

## 📌 1. `application.yml` 작성 및 주요 설정
Spring Boot 프로젝트의 핵심 설정 파일인 `application.yml`을 작성하여 프로젝트 환경을 정의합니다.

```yaml
server:
  port: 8080

spring:
  datasource:
    url: jdbc:postgresql://localhost:5432/gisuite
    username: gis_user
    password: gis_password
    driver-class-name: org.postgresql.Driver
  jpa:
    database-platform: org.hibernate.spatial.dialect.postgis.PostgisDialect
    hibernate:
      ddl-auto: update
    show-sql: true
    properties:
      hibernate:
        format_sql: true

logging:
  level:
    org:
      springframework: INFO
      hibernate: DEBUG

springdoc:
  api-docs:
    enabled: true
  swagger-ui:
    path: /swagger-ui.html
```

### 🔹 주요 설정 설명
- **`server.port`** → 애플리케이션이 실행될 포트 (`8080`)
- **`spring.datasource`** → PostgreSQL 데이터베이스 연결 정보 설정
- **`spring.jpa`** → Hibernate 및 PostGIS 연동 설정
- **`logging.level`** → Hibernate 및 Spring의 로깅 설정
- **`springdoc`** → Swagger(OpenAPI) 문서화 설정

---

## 📌 2. `DatabaseConfig.java` - PostgreSQL + PostGIS 설정
PostGIS 및 Hibernate Spatial을 활용한 데이터베이스 설정을 진행합니다.

```java
package com.gisuite.config;

import jakarta.persistence.EntityManagerFactory;
import javax.sql.DataSource;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;
import org.springframework.transaction.PlatformTransactionManager;
import java.util.Properties;

@Configuration
@EnableJpaRepositories(basePackages = "com.gisuite.repository")
public class DatabaseConfig {

    @Value("${spring.datasource.url}")
    private String databaseUrl;

    @Value("${spring.datasource.username}")
    private String databaseUsername;

    @Value("${spring.datasource.password}")
    private String databasePassword;

    @Value("${spring.datasource.driver-class-name}")
    private String databaseDriver;

    @Bean
    public DataSource dataSource() {
        return org.springframework.boot.jdbc.DataSourceBuilder.create()
                .url(databaseUrl)
                .username(databaseUsername)
                .password(databasePassword)
                .driverClassName(databaseDriver)
                .build();
    }

    @Bean
    public PlatformTransactionManager transactionManager(EntityManagerFactory emf) {
        return new JpaTransactionManager(emf);
    }
}
```

---

## 📌 3. `WebConfig.java` - 정적 리소스 및 CORS 설정
```java
package com.gisuite.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
@EnableWebMvc
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/static/**")
                .addResourceLocations("classpath:/static/");
    }

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**")
                .allowedOrigins("*")
                .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS")
                .allowedHeaders("*")
                .allowCredentials(true);
    }
}
```

---

## 📌 4. `SwaggerConfig.java` - Swagger API 문서화 설정
Swagger UI를 활용하여 API 문서를 자동으로 생성합니다.

```java
package com.gisuite.config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class SwaggerConfig {

    @Bean
    public OpenAPI customOpenAPI() {
        return new OpenAPI()
                .info(new Info()
                        .title("GISuite API Documentation")
                        .version("1.0")
                        .description("GIS 데이터 관리용 API 문서입니다."));
    }
}
```

---

## 🎯 **마무리 및 다음 단계**
이제 GISuite 프로젝트의 환경 설정이 완료되었습니다.

✅ **다음 단계:** GIS 데이터 처리를 위한 **JPA Entity 및 Repository 설계** 🚀