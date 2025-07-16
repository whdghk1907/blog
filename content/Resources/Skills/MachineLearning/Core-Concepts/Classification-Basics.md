# Classification Basics - 분류 기초 개념

## 📖 핵심 개념 정리

### 분류(Classification)

- **정의**: 입력 데이터를 사전에 정의된 클래스나 범주로 분류하는 지도학습 문제
- **목표**: 새로운 데이터가 어떤 범주에 속하는지 예측
- **특징**: 출력 변수가 카테고리형(이산적)

### 지도학습(Supervised Learning)

- **학습 방식**: 레이블이 있는 데이터로 모델 학습
- **과정**: 입력(X) → 모델(f) → 출력(y)
- **평가**: 실제 레이블과 예측 결과 비교

## 🏷️ 분류 문제 유형

### 1. 이진 분류 (Binary Classification)

- **클래스 수**: 2개
- **예시**: 스팸/햄, 양성/음성, 통과/불통과
- **알고리즘**: 로지스틱 회귀, SVM

### 2. 다중 클래스 분류 (Multi-class Classification)

- **클래스 수**: 3개 이상
- **특징**: 상호 배타적 클래스
- **예시**: 붓꽃 종류(3종), 숫자 인식(0-9)

### 3. 다중 레이블 분류 (Multi-label Classification)

- **특징**: 하나의 샘플이 여러 클래스에 속할 수 있음
- **예시**: 뉴스 기사 주제 태깅, 이미지 내 객체 인식

## 🔍 주요 분류 알고리즘

### 선형 분류기

- **로지스틱 회귀**: 선형 결정 경계, 확률 출력
- **선형 SVM**: 최대 마진 분류기
- **퍼셉트론**: 가장 단순한 선형 분류기

### 비선형 분류기

- **결정 트리**: 규칙 기반 분류
- **K-최근접 이웃**: 인스턴스 기반 학습
- **커널 SVM**: 커널 트릭으로 비선형 분류

### 앙상블 방법

- **랜덤 포레스트**: 여러 결정 트리 결합
- **그래디언트 부스팅**: 순차적 학습
- **보팅 분류기**: 다양한 알고리즘 결합

## 📊 성능 평가

### 기본 지표

- **정확도**: (TP + TN) / (TP + TN + FP + FN)
- **정밀도**: TP / (TP + FP)
- **재현율**: TP / (TP + FN)
- **F1-Score**: 2 × (정밀도 × 재현율) / (정밀도 + 재현율)

### 고급 지표

- **ROC-AUC**: 이진 분류 성능 평가
- **정밀도-재현율 곡선**: 불균형 데이터 평가
- **다중 클래스 지표**: 매크로/마이크로 평균

## 🛠️ 실무 고려사항

### 데이터 전처리

- **결측값 처리**: 제거, 대체, 보간
- **범주형 변수 인코딩**: 원핫 인코딩, 레이블 인코딩
- **특성 스케일링**: 표준화, 정규화

### 모델 선택

- **데이터 크기**: 작은 데이터는 SVM, 큰 데이터는 SGD
- **해석 가능성**: 중요하면 결정 트리, 로지스틱 회귀
- **정확도 우선**: 랜덤 포레스트, 그래디언트 부스팅

### 과적합 방지

- **교차 검증**: K-폴드, 계층화 K-폴드
- **정규화**: L1, L2 규제
- **조기 종료**: 검증 손실 모니터링

## 🔗 유용한 참고 자료

### 공식 문서

- [Scikit-learn 분류 가이드](https://scikit-learn.org/stable/supervised_learning.html#supervised-learning)
- [Scikit-learn 예제 갤러리](https://scikit-learn.org/stable/auto_examples/classification/index.html)

### 추천 도서

- "Hands-On Machine Learning" - Aurélien Géron
- "Pattern Recognition and Machine Learning" - Christopher Bishop
- "The Elements of Statistical Learning" - Hastie, Tibshirani, Friedman

### 온라인 리소스

- [Coursera Machine Learning Course](https://www.coursera.org/learn/machine-learning) - Andrew Ng
- [Fast.ai Practical Deep Learning](https://course.fast.ai/)
- [Kaggle Learn](https://www.kaggle.com/learn/intro-to-machine-learning)

## 💡 학습 팁

### 단계별 접근

1. **기본 개념 이해**: 분류, 지도학습, 성능 지표
2. **간단한 예제**: 붓꽃 분류, 타이타닉 생존 예측
3. **알고리즘 비교**: 같은 데이터셋에 다양한 알고리즘 적용
4. **실제 프로젝트**: 캐글 대회 참여

### 실습 환경

- **Python 라이브러리**: scikit-learn, pandas, numpy, matplotlib
- **개발 환경**: Jupyter Notebook, Google Colab
- **데이터셋**: UCI ML Repository, Kaggle Datasets

### 트러블슈팅

- **불균형 데이터**: 샘플링 기법, 가중치 조정
- **과적합**: 교차 검증, 정규화, 조기 종료
- **낮은 성능**: 특성 엔지니어링, 알고리즘 변경, 하이퍼파라미터 튜닝
