
## 📌 개요
GISuite는 **Swagger(OpenAPI)** 를 활용하여 API 문서를 자동 생성하고, 사용자와 개발자가 쉽게 API를 테스트할 수 있도록 합니다.
이 문서에서는 **Swagger 설정 방법, `SwaggerConfig.java` 작성, API UI 활용법**을 설명합니다.

---

## 🏗️ 1. Swagger 설정 및 의존성 추가
Spring Boot 프로젝트에서 Swagger를 사용하려면 `springdoc-openapi-starter-webmvc-ui` 의존성을 추가해야 합니다.

### ✅ **1. `pom.xml`에 Swagger 의존성 추가**
```xml
<dependency>
    <groupId>org.springdoc</groupId>
    <artifactId>springdoc-openapi-starter-webmvc-ui</artifactId>
    <version>2.2.0</version>
</dependency>
```

---

## 📌 2. `SwaggerConfig.java` 작성
Swagger(OpenAPI) 설정을 위해 `SwaggerConfig.java` 파일을 생성합니다.

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

### 🔹 주요 설정
- **`@Configuration`** → Spring Boot에서 설정 클래스로 인식
- **`@Bean customOpenAPI()`** → API 문서의 제목, 버전, 설명을 정의

---

## 📌 3. Swagger UI 사용법
Spring Boot 애플리케이션을 실행한 후 Swagger UI에 접속하여 API를 테스트할 수 있습니다.

### ✅ **Swagger UI 접속 방법**
애플리케이션 실행 후 브라우저에서 다음 URL을 입력합니다:
```
http://localhost:8080/swagger-ui.html
```
Swagger UI가 로드되면, 모든 REST API 엔드포인트를 확인하고 테스트할 수 있습니다.

### ✅ **API 문서 JSON 확인 방법**
Swagger 문서의 JSON 형식 데이터는 다음 URL에서 확인할 수 있습니다:
```
http://localhost:8080/v3/api-docs
```

---

## 📌 4. API 문서화 및 테스트 방법
Swagger UI를 활용하여 GIS API를 테스트하는 방법을 소개합니다.

### ✅ **1. GET API 테스트 (`/api/gis`)**
Swagger UI에서 **`GET /api/gis`** 버튼을 클릭하고 **`Execute`** 버튼을 누르면, 현재 저장된 GIS 데이터를 확인할 수 있습니다.

### ✅ **2. POST API 테스트 (`/api/gis`)**
- **`POST /api/gis`** 엔드포인트를 선택합니다.
- **Request Body**에 GIS 데이터를 입력하고 **Execute** 버튼을 눌러 요청을 실행합니다.
```json
{
  "name": "Test GIS Data",
  "geometry": "POINT(30 10)"
}
```
- 성공적으로 실행되면, 새로운 GIS 데이터가 추가됩니다.

### ✅ **3. DELETE API 테스트 (`/api/gis/{id}`)**
- 특정 ID를 가진 GIS 데이터를 삭제하는 API를 테스트할 수 있습니다.
- **`DELETE /api/gis/{id}`** 경로에 ID 값을 입력한 후 **Execute** 버튼을 눌러 삭제 요청을 보냅니다.

---

## 🎯 **마무리 및 다음 단계**
이제 Swagger(OpenAPI)를 활용하여 **GISuite 프로젝트의 API 문서를 자동 생성하고 테스트할 수 있는 환경을 구축**했습니다.

✅ **다음 단계:** 실제 서비스에서 API 보안 및 인증을 적용하는 방법 🚀
