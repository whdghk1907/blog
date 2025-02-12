
## 🚀 들어가며
GIS 데이터를 다룰 때 **OGC(Open Geospatial Consortium) 표준**을 준수하는 것은 매우 중요합니다.  
그중에서도 **ISO 19111 (Spatial Referencing by Coordinates)** 표준은  
좌표 변환을 수행할 때 필요한 **변환 파라미터(parameter) 및 연산(operation)** 을 정의하고 있습니다.

GISuite 프로젝트에서는 **ISO 19111 표준을 준수하는 파라미터 패키지 (`com.gisuite.parameter`)** 를 개발하였습니다.  
이번 포스팅에서는 GISuite의 파라미터 패키지를 설계하고 구현한 과정을 소개합니다.  

---

## 📂 1️⃣ 파라미터 패키지의 역할
GIS에서 좌표 변환을 수행할 때 **좌표계를 정의하고, 변환 연산을 실행하는 데 필요한 파라미터를 관리**해야 합니다.  
OGC 표준에서는 이러한 변환 연산을 정의하기 위해 **ISO 19111을 규정**하고 있으며,  
GISuite에서는 이를 **Java에서 활용할 수 있도록 파라미터 패키지를 설계**하였습니다.

📌 **GIS 좌표 변환에서 필수적으로 포함되어야 하는 요소**
1. **좌표 변환을 위한 개별 파라미터(ParameterValue)**
2. **파라미터 그룹(ParameterValueGroup)**
3. **좌표 변환 연산(CoordinateOperation)**
4. **수학적 변환(MathTransform)**
5. **변환을 관리하는 팩토리(TransformFactory)**

💡 GISuite의 파라미터 패키지는 **OGC 표준을 준수하는 변환 파라미터 시스템을 Java에서 쉽게 활용할 수 있도록 설계**되었습니다.

---

## 🔧 2️⃣ 파라미터 패키지 설계 및 구현

### **📌 1. 변환 연산의 개별 파라미터 (`ParameterValue.java`)**
```java
package com.gisuite.parameter;

/**
 * ISO 19111 기반의 변환 연산 개별 파라미터.
 */
public class ParameterValue {
    private final String name;
    private final double value;

    public ParameterValue(String name, double value) {
        this.name = name;
        this.value = value;
    }

    public String getName() { return name; }
    public double getValue() { return value; }
}
```

---

### **📌 2. 변환 연산의 파라미터 그룹 (`ParameterValueGroup.java`)**
```java
package com.gisuite.parameter;

import java.util.ArrayList;
import java.util.List;

/**
 * ISO 19111 기반의 변환 연산 파라미터 그룹.
 */
public class ParameterValueGroup {
    private final String groupName;
    private final List<ParameterValue> parameters;

    public ParameterValueGroup(String groupName) {
        this.groupName = groupName;
        this.parameters = new ArrayList<>();
    }

    public void addParameter(ParameterValue parameter) {
        parameters.add(parameter);
    }

    public List<ParameterValue> getParameters() { return parameters; }
}
```

---

### **📌 3. 좌표 변환 연산 (`CoordinateOperation.java`)**
```java
package com.gisuite.parameter;

/**
 * ISO 19111 기반의 좌표 변환 연산.
 */
public class CoordinateOperation {
    private final ParameterValueGroup parameterGroup;

    public CoordinateOperation(ParameterValueGroup parameterGroup) {
        this.parameterGroup = parameterGroup;
    }

    public ParameterValueGroup getParameterGroup() { return parameterGroup; }
}
```

---

### **📌 4. 수학적 변환 연산 (`MathTransform.java`)**
```java
package com.gisuite.parameter;

import java.util.Arrays;

/**
 * ISO 19111 기반의 수학적 변환 연산 (MathTransform).
 * 좌표 변환을 수행하는 수학적 연산을 정의하는 인터페이스.
 */
public interface MathTransform {
    
    /**
     * 단일 좌표를 변환.
     *
     * @param source 좌표 변환 전의 원본 값
     * @return 변환된 좌표 값
     */
    double[] transform(double[] source);

    /**
     * 여러 개의 좌표를 변환.
     *
     * @param sourceArray 변환할 원본 좌표 배열
     * @return 변환된 좌표 배열
     */
    default double[][] transform(double[][] sourceArray) {
        return Arrays.stream(sourceArray)
                     .map(this::transform)
                     .toArray(double[][]::new);
    }
}
```

---

### **📌 5. 변환 연산을 생성하는 팩토리 (`TransformFactory.java`)**
```java
package com.gisuite.parameter;

import java.util.HashMap;
import java.util.Map;

/**
 * ISO 19111 기반의 변환 연산을 생성하는 팩토리.
 */
public class TransformFactory {
    private static final Map<String, MathTransform> TRANSFORM_MAP = new HashMap<>();

    static {
        // 기본적인 변환 정의
        TRANSFORM_MAP.put("scale", new ScaleTransform(2.0));
        TRANSFORM_MAP.put("translate", new TranslateTransform(5.0, -3.0));
    }

    public static MathTransform getTransform(String name) {
        if (!TRANSFORM_MAP.containsKey(name)) {
            throw new IllegalArgumentException("등록되지 않은 변환: " + name);
        }
        return TRANSFORM_MAP.get(name);
    }

    public static void registerTransform(String name, MathTransform transform) {
        TRANSFORM_MAP.put(name, transform);
    }
}
```

---

## 📈 3️⃣ GISuite의 파라미터 패키지가 가져온 개선점
📌 **✅ OGC 표준을 준수하는 변환 파라미터 시스템 구축**  
- ISO 19111을 준수하여 **GIS 좌표 변환을 일관된 구조로 유지**  

📌 **✅ 변환 연산을 모듈화하여 유지보수 용이**  
- `MathTransform` 인터페이스를 활용하여 **다양한 변환 연산을 쉽게 추가 가능**  

📌 **✅ 확장 가능성 증가**  
- 향후 **다양한 좌표 변환 연산(AffineTransform, RotationTransform 등)을 추가 가능**  

---

## 🎯 4️⃣ 결론 및 향후 개선 방향
GISuite의 파라미터 패키지는 **ISO 19111 표준을 충실히 준수하면서도, GIS 좌표 변환 데이터를 Java 환경에서 다룰 수 있도록 설계**되었습니다.  
향후 다음과 같은 기능을 추가하여 더 강력한 GIS 좌표 변환 시스템을 구축할 예정입니다.

📌 **향후 추가할 기능**
6. **OGC 표준 투영 변환 지원** → `GeographicCRS`, `ProjectedCRS` 연계 지원  
7. **고급 변환 연산 추가** → `AffineTransform`, `RotationTransform`, `ShearTransform` 등의 고급 변환 지원  
8. **좌표 변환 WKT(Well-Known Text) 지원** → WKT 포맷을 기반으로 좌표 변환을 직렬화/역직렬화  

GISuite는 **OGC 표준을 기반으로 GIS 데이터를 다루는 최고의 프레임워크**를 목표로 합니다! 🚀  
더 나은 기능을 위해 지속적으로 발전시켜 나가겠습니다. 😊
