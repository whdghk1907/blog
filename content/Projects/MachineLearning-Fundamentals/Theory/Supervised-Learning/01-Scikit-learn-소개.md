# 01. 사이킷런 소개와 머신러닝 분류 예측 모델 개요

## 📚 사이킷런(Scikit-learn)이란?

### 정의
- Python에서 가장 널리 사용되는 머신러닝 라이브러리
- **간단하고 효율적인 데이터 마이닝 및 분석 도구**
- 모든 사람이 접근 가능하고 다양한 상황에서 재사용 가능
- NumPy, SciPy, matplotlib 위에 구축
- 오픈소스, 상업적 사용 가능 (BSD 라이센스)

### 주요 특징
- **단순성**: 직관적이고 일관된 API
- **효율성**: 최적화된 알고리즘과 빠른 성능
- **포괄성**: 다양한 머신러닝 알고리즘 제공
- **문서화**: 풍부한 문서와 예제 제공

## 🤖 머신러닝 분류 예측 모델 개요

### 분류(Classification)란?
- **지도학습(Supervised Learning)**의 한 유형
- 레이블이 있는 데이터로 모델을 학습
- **카테고리나 클래스**를 예측하는 문제
- 입력 데이터가 어떤 범주에 속하는지 분류

### 분류 vs 회귀
| 분류 (Classification) | 회귀 (Regression) |
|---------------------|------------------|
| 이산적(카테고리) 값 예측 | 연속적(수치) 값 예측 |
| 스팸/햄, 고양이/개 | 주택 가격, 온도 |
| 로지스틱 회귀, SVM | 선형 회귀, 다항식 회귀 |

## 🏷️ 분류 문제의 유형

### 1. 이진 분류 (Binary Classification)
- **2개의 클래스**만 존재
- 예시: 스팸 메일 분류, 의료 진단
- 출력: 참/거짓, 양성/음성

### 2. 다중 클래스 분류 (Multi-class Classification)
- **3개 이상의 클래스** 존재
- 클래스 간 상호 배타적
- 예시: 붓꽃 종류 분류, 숫자 인식

### 3. 다중 레이블 분류 (Multi-label Classification)
- **하나의 입력**에 **여러 레이블** 가능
- 예시: 뉴스 기사의 주제 태깅, 이미지 내 객체 인식

### 4. 불균형 분류 (Imbalanced Classification)
- 클래스 별 데이터 수가 **불균형**
- 예시: 의료 질병 진단, 사기 탐지

## 🔍 사이킷런의 주요 분류 알고리즘

### 1. 로지스틱 회귀 (Logistic Regression)
- **선형 모델**로 이진 분류에 적합
- 확률론적 프레임워크 제공
- 해석하기 쉽고 계산 효율적

### 2. K-최근접 이웃 (K-Nearest Neighbors)
- **인스턴스 기반 학습**
- 훈련 단계 없이 지연 학습
- 간단하지만 계산 비용이 높음

### 3. 서포트 벡터 머신 (Support Vector Machine)
- **최적의 결정 경계** 찾기
- 고차원 데이터에 효과적
- 커널 트릭으로 비선형 분류 가능

### 4. 결정 트리 (Decision Tree)
- **트리 구조**로 의사결정 규칙 표현
- 해석하기 쉽고 시각화 가능
- 과적합 위험 존재

### 5. 랜덤 포레스트 (Random Forest)
- **앙상블 방법**으로 여러 결정 트리 결합
- 과적합 방지 및 높은 정확도
- 특성 중요도 제공

### 6. 나이브 베이즈 (Naive Bayes)
- **베이즈 정리** 기반
- 특성 간 독립성 가정
- 텍스트 분류에 효과적

## 🎯 실무 적용 분야

### 의료 분야
- 질병 진단 및 예측
- 의료 이미지 분석
- 약물 효과 예측

### 금융 분야
- 신용 평가 및 위험 관리
- 사기 탐지 시스템
- 주가 예측

### 기술 분야
- 이메일 스팸 필터링
- 추천 시스템
- 이미지 및 음성 인식

### 마케팅 분야
- 고객 세분화
- 구매 예측
- 광고 타겟팅

## 🔧 사이킷런 기본 워크플로우

### 1. 데이터 준비
```python
from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split

# 데이터 로드
X, y = load_iris(return_X_y=True)

# 훈련/테스트 데이터 분할
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.3, random_state=42
)
```

### 2. 모델 선택 및 훈련
```python
from sklearn.ensemble import RandomForestClassifier

# 모델 생성
model = RandomForestClassifier(n_estimators=100, random_state=42)

# 모델 훈련
model.fit(X_train, y_train)
```

### 3. 예측 및 평가
```python
from sklearn.metrics import accuracy_score, classification_report

# 예측
y_pred = model.predict(X_test)

# 평가
accuracy = accuracy_score(y_test, y_pred)
print(f"정확도: {accuracy:.4f}")
print(classification_report(y_test, y_pred))
```

## 📊 성능 평가 지표

### 기본 지표
- **정확도 (Accuracy)**: 전체 예측 중 정확한 예측 비율
- **정밀도 (Precision)**: 양성 예측 중 실제 양성 비율
- **재현율 (Recall)**: 실제 양성 중 정확히 예측한 비율
- **F1-Score**: 정밀도와 재현율의 조화 평균

### 고급 지표
- **혼동 행렬 (Confusion Matrix)**: 예측 결과의 상세 분석
- **ROC 곡선 및 AUC**: 이진 분류 성능 평가
- **교차 검증 (Cross Validation)**: 모델 일반화 성능 평가

## 🚀 학습 방향

### 단계별 접근
1. **기본 개념 이해**: 분류, 지도학습, 사이킷런 구조
2. **실습 경험**: 간단한 데이터셋으로 모델 구현
3. **알고리즘 비교**: 다양한 분류 알고리즘 성능 비교
4. **성능 최적화**: 하이퍼파라미터 튜닝 및 교차 검증

### 다음 단계 준비
- 각 알고리즘의 상세한 수학적 원리 학습
- 실제 데이터셋을 활용한 프로젝트 수행
- 모델 해석 및 설명 가능한 AI 기법 학습
- MLOps 파이프라인 구축으로 연결 