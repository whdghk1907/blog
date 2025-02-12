# 📌 GISuite: OGC 표준을 따르는 어노테이션 패키지 개발 과정

## 🚀 들어가며
GIS 데이터를 다룰 때, **OGC(Open Geospatial Consortium) 표준**을 준수하는 것은 매우 중요합니다.  
GISuite 프로젝트에서는 OGC 표준을 기반으로 GIS 애플리케이션을 개발하며,  
이번 포스팅에서는 **어노테이션 패키지(`com.gisuite.annotation`)를 개발한 과정**을 공유합니다.

이 패키지는 **OGC 표준의 UML 모델을 Java 어노테이션으로 매핑**하는 역할을 하며,  
ISO 19115, ISO 19111 등의 표준을 준수하는 다양한 GIS 관련 엔티티와 연계됩니다.

---

## 📂 1️⃣ 어노테이션 패키지의 역할
OGC 표준에서는 **GIS 데이터를 표현하는 UML 모델**을 정의하고 있으며,  
이 모델을 Java 코드에서 직접 활용할 수 있도록 **어노테이션을 적용하는 것이 핵심 목표**였습니다.

📌 **어노테이션 패키지가 해결해야 할 문제**
1. **OGC 표준 UML 모델을 Java 코드에서 명확하게 표현**
2. **OGC에서 정의된 필수 및 선택적 요소 구분**
3. **런타임에서 어노테이션을 활용하여 메타데이터를 추출할 수 있도록 지원**

💡 이를 위해 GISuite에서는 **두 가지 어노테이션을 제공**하도록 설계했습니다.
- `@UML` : OGC UML 모델을 Java 코드에 적용
- `Obligation` : 속성의 필수 여부를 정의

---

## 🔧 2️⃣ 어노테이션 패키지 설계 및 구현
### **📌 UML 어노테이션 정의 (`UML.java`)**
먼저 OGC UML 모델을 Java에서 표현하기 위한 **`@UML` 어노테이션**을 정의합니다.

```java
package com.gisuite.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * OGC UML 모델을 Java 코드에서 표현하기 위한 어노테이션.
 */
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.TYPE, ElementType.METHOD, ElementType.FIELD})
public @interface UML {
    String identifier();   // UML 모델에서 정의된 식별자
    String specification(); // 적용된 OGC 표준 명칭
    Obligation obligation() default Obligation.MANDATORY; // 기본적으로 필수
}
```

### **📌 필수 속성 정의 (`Obligation.java`)**
어노테이션을 적용할 때, 해당 속성이 **필수인지 선택적인지**를 명확히 구분해야 합니다.  
이를 위해 `Obligation` 열거형(Enum)을 정의합니다.

```java
package com.gisuite.annotation;

/**
 * OGC 표준에서 사용되는 의무 수준(Obligation Level) 열거형.
 */
public enum Obligation {
    MANDATORY, // 필수 요소
    OPTIONAL,  // 선택 요소
    CONDITIONAL // 특정 조건에서 필수
}
```

---

## 🏗️ 3️⃣ 어노테이션 적용 예제
이제 개발한 어노테이션을 **OGC 표준을 따르는 클래스에 적용**할 차례입니다.

### **📌 예제 1: 좌표 참조 시스템에 어노테이션 적용**
```java
package com.gisuite.referencing;

import com.gisuite.annotation.UML;
import com.gisuite.annotation.Obligation;

/**
 * ISO 19111 기반의 좌표 참조 시스템 (CRS).
 */
@UML(identifier = "SC_CoordinateReferenceSystem", specification = "ISO_19111")
public class CoordinateReferenceSystem {
    
    @UML(identifier = "name", specification = "ISO_19111", obligation = Obligation.MANDATORY)
    private final String name;

    @UML(identifier = "datum", specification = "ISO_19111", obligation = Obligation.MANDATORY)
    private final Datum datum;

    public CoordinateReferenceSystem(String name, Datum datum) {
        this.name = name;
        this.datum = datum;
    }

    public String getName() { return name; }
    public Datum getDatum() { return datum; }
}
```

### **📌 예제 2: 런타임에서 어노테이션 정보 추출**
어노테이션을 활용하면 **런타임에서 OGC 표준 메타데이터를 추출**할 수도 있습니다.

```java
package com.gisuite.util;

import com.gisuite.annotation.UML;
import com.gisuite.referencing.CoordinateReferenceSystem;
import java.lang.reflect.Field;

public class UMLMetadataExtractor {
    public static void main(String[] args) throws Exception {
        Class<?> clazz = CoordinateReferenceSystem.class;

        // 클래스 레벨 UML 어노테이션 정보 출력
        UML classAnnotation = clazz.getAnnotation(UML.class);
        System.out.println("Class UML Identifier: " + classAnnotation.identifier());
        System.out.println("Specification: " + classAnnotation.specification());

        // 필드의 UML 어노테이션 정보 출력
        for (Field field : clazz.getDeclaredFields()) {
            UML fieldAnnotation = field.getAnnotation(UML.class);
            if (fieldAnnotation != null) {
                System.out.println("\nField: " + field.getName());
                System.out.println("UML Identifier: " + fieldAnnotation.identifier());
                System.out.println("Specification: " + fieldAnnotation.specification());
                System.out.println("Obligation: " + fieldAnnotation.obligation());
            }
        }
    }
}
```

---

## 📈 4️⃣ GISuite의 어노테이션 패키지가 가져온 개선점
📌 **✅ OGC 표준을 준수하는 명확한 문서화**  
- UML 어노테이션을 적용하여 **표준 모델과 코드 간의 일관성을 유지**할 수 있음.

📌 **✅ 런타임에서 메타데이터 추출 가능**  
- 리플렉션을 활용하면 **ISO 19111 표준을 기반으로 동적으로 메타데이터를 조회**할 수 있음.

📌 **✅ 유지보수 및 확장성 향상**  
- 개발자가 표준을 따를 수 있도록 **자동화된 문서화 및 검증 시스템**으로 확장 가능.

---

## 🎯 5️⃣ 결론 및 향후 개선 방향
GISuite의 어노테이션 패키지는 OGC 표준을 충실히 준수하면서도,  
**코드 내에서 GIS 엔티티를 문서화하고, 런타임에서 메타데이터를 활용할 수 있도록 지원하는 역할**을 수행합니다.  

📌 **향후 추가할 기능**
4. **Javadoc 생성기**: UML 어노테이션 정보를 자동으로 API 문서화할 수 있는 기능 추가
5. **어노테이션 기반 데이터 검증**: 어노테이션을 활용하여 GIS 데이터를 검증하는 시스템 구현

GISuite는 **OGC 표준을 기반으로 GIS 데이터를 다루는 최고의 프레임워크**를 목표로 합니다! 🚀  
더 나은 기능을 위해 지속적으로 발전시켜 나가겠습니다. 😊
