---
source_type: "article"
source_url: "https://docs.tosspayments.com/blog/everything-about-basic-bearer-auth"
title: "Basic 인증과 Bearer 인증의 모든 것 | 토스페이먼츠 개발자센터"
author:
published:
captured: 2026-04-13
description: "비밀번호로 이메일 계정의 권한을 확인하는 것 처럼, HTTP 인증으로 서버에 접근하는 클라이언트의 권한을 확인해요."
tags:
  - "clippings"
  - "article"
reason: "HTTP 통신·인증/인가(OAuth 포함)는 중요하면서 복잡한 개념이라 정리 필요"
ingest_mode: "learn"
status: "raw"
---
# Basic 인증과 Bearer 인증의 모든 것 | 토스페이먼츠 개발자센터

> 비밀번호로 이메일 계정의 권한을 확인하는 것 처럼, HTTP 인증으로 서버에 접근하는 클라이언트의 권한을 확인해요.

## Basic 인증과 Bearer 인증의 모든 것

2023년 10월 10일 ・ 읽는 시간 11분

[![Basic 인증과 Bearer 인증 메인 이미지](https://static.toss.im/assets/payments/contents/payments-thumb-3.jpg)](https://static.toss.im/assets/payments/contents/payments-thumb-3.jpg)

HTTP 인증(Authorization)은 웹 서버의 비밀번호 같은 역할을 해줘요. 비밀번호로 이메일 계정의 권한을 확인하는 것 처럼, HTTP 인증으로 서버에 접근하는 클라이언트의 권한을 확인해요. 이번 포스트에는 HTTP 인증 프레임워크와 Basic, Bearer 인증 방법을 알아볼게요.

## HTTP 통신 방법

HTTP 통신은 요청(Request)과 응답(Response)으로 HTML 문서 및 웹 리소스를 불러와요. 요청과 응답은 클라이언트-서버 간에 이루어져요. 클라이언트(보통 웹브라우저)가 서버에 요청을 보내면, 서버는 요청한 리소스를 보내줘요.

HTTP 통신에는 인증이 왜 필요할까요? 예를 들어 블로그 포스트를 하나 작성했다고 가정해볼게요. 내가 작성한 블로그 포스트, 나만 수정할 수 있어야 겠죠. 블로그 포스트, 이메일과 같이 보호된 서버 리소스를 접근하는 클라이언트의 인증 정보(Credentials)를 확인해요. [HTTP 인증 프레임워크](https://developer.mozilla.org/ko/docs/Web/HTTP/Authentication) 는 [RFC 7235](https://datatracker.ietf.org/doc/html/rfc7235) 에 정의되어 있고 아래와 같은 인증 헤더를 요청에 사용해요.

```
Authorization: <type> <credentials>
```

올바른 인증 정보를 넣으면 `200 OK` 코드와 요청한 데이터가 돌아와요. 인증 헤더를 누락하면 `401 Unauthorized` 에러가 돌아와요. 인증 정보를 넣었지만 권한이 없는 접근이라면 `403 Forbidden` 에러가 돌아와요.

[![토스페이먼츠-인증](https://velog.velcdn.com/images/tosspayments/post/637cbb3a-760f-4c7c-a06a-17f034e5f72e/image.png)](https://velog.velcdn.com/images/tosspayments/post/637cbb3a-760f-4c7c-a06a-17f034e5f72e/image.png)

인증 정보는 인증 방식(Type)에 따라 달라져요. 두 가지의 대표적인 인증 방식을 알아볼게요.

## Basic 인증이란?

Basic 인증 방식은 말 그대로 가장 기본적인 인증 방식이에요. 인증 정보로 사용자 ID, 비밀번호를 사용해요. [base64](https://developer.mozilla.org/en-US/docs/Glossary/Base64) 로 인코딩한 “사용자ID:비밀번호” 문자열을 `Basic` 과 함께 인증 헤더에 입력해요. 더 자세한 내용은 [RFC 7617](https://datatracker.ietf.org/doc/html/rfc7617) 에 정의되어 있어요.

Base64는 쉽게 복호화할 수 있어요. 단순 base64 인코딩된 사용자 ID와 비밀번호를 HTTP로 전달하면 요청의 보안이 보장되지 않아요. Basic 인증을 사용하는 요청은 꼭 HTTPS, SSL/TLS로 통신해야 안전해요.

```
Authorization: Basic base64({USERNAME}:{PASSWORD})
```

### Basic 인증의 장점과 단점

Basic 인증 방식의 가장 큰 장점은 간단함이에요. 사용자 ID와 비밀번호 외에 로그인 페이지나 별도의 인증 정보를 요구하지 않아요. 이런 간편함 때문에 다수의 서비스가 Basic 인증 방식을 사용하고 있어요. 쉬운 접근이 중요시되는 웹 서비스를 기반으로 만들어진만큼 Basic 인증은 단순하고 구축하기 쉬워요.

그러나 Basic 인증 방식은 서버에 사용자 목록을 저장해요. 요청한 리소스가 많거나 사용자가 많으면 목록에서 권한을 확인하는 시간이 길어지겠죠. 또한 서버에 현실적으로 저장할 수 있는 데이터는 한정되어 있어서 사용자가 많거나 사용자 변화가 잦은 서비스가 Basic 인증을 사용하면 서버에 부담이 커져요.

또 Basic 인증 방식만으로는 사용자 권한을 정교하게 제어할 수 없어요. 사용자가 꼭 필요한 리소스에만 권한을 주는 게 좋은데, Basic 인증 방식으로 세세하게 사용자의 권한을 설정하려면 추가 구현이 필요해요. 사용자 ID, 비밀번호는 우리에게 가장 친근한 인증 방법이지만, 어떻게 보면 그만큼 구시대적이에요. 복잡한 현대 IT 서비스는 더 정교한 인증 방식을 요구해요.

## Bearer 인증이란?

Bearer 인증 방식은 [OAuth 2.0](https://oauth.net/2/) 프레임워크에서 사용하는 토큰 인증 방식이에요. “Bearer”은 소유자라는 뜻인데, “이 토큰의 소유자에게 권한을 부여해줘”라는 의미로 이름을 붙였다고 해요. `Bearer` 와 토큰을 인증 헤더에 입력해요. 더 자세한 내용은 [RFC 6750](https://datatracker.ietf.org/doc/html/rfc6750) 에 정의되어 있어요.

```
Authorization: Bearer <token>
```

### OAuth 2.0 프레임워크

요즘은 회원가입을 하지 않아도 구글과 같은 소셜 계정으로 바로 이용할 수 있는 편리한 서비스가 많죠. 구글에서 내 데이터의 일부를 제 3자의 서비스와 공유하는 거에요. 이렇게 다양한 서비스 또는 서버 사이에 안전하게 데이터를 전송하기 위해 OAuth 프레임워크가 탄생했어요. OAuth는 제 3자의 클라이언트에게 보호된 리소스를 제한적으로 접근하게 해주는 프레임워크에요.

OAuth 프레임워크에는 리소스 소유자, 클라이언트, 인증 서버, 리소스 서버가 있어요.

- 리소스 소유자: 사용자
- 클라이언트: 사용자의 정보를 접근하는 제 3자의 서비스
- 인증 서버: 클라이언트의 접근을 관리하는 서버
- 리소스 서버: 리소스 소유자의 데이터를 관리하는 서버

리소스 소유자의 동의가 확인되면 인증 서버는 클라이언트에게 액세스 토큰을 발급해줘요. 클라이언트는 액세스 토큰을 사용해서 리소스 서버에 보호된 데이터를 불러와요.

[![토스페이먼츠-Bearer 인증](https://velog.velcdn.com/images/tosspayments/post/00e43ffd-de9b-402e-a6ff-db0c78ddd4d7/image.png)](https://velog.velcdn.com/images/tosspayments/post/00e43ffd-de9b-402e-a6ff-db0c78ddd4d7/image.png)

### Bearer 토큰

Bearer 토큰은 OAuth 프레임워크에서 액세스 토큰으로 사용하는 토큰의 유형이에요.

Bearer 토큰은 [불투명한(Opaque)](https://auth0.com/docs/secure/tokens/access-tokens#opaque-access-tokens) 문자열이에요. 토큰의 형태는 인증 서버에서 정의하기 나름인데, 16진수의 문자열을 사용하기도 하고 [JSON Web Token(JWT)](https://jwt.io/) 을 사용하기도 해요. 중요한건 Bearer 토큰은 클라이언트가 해석할 수 없는 형태여야 하고, 사용자의 정보를 전달하면 안 돼요. 대신 서버에서 클라이언트의 권한을 확인할 수 있는 메타데이터가 토큰에 인코딩되어 있어야 해요. 충분히 복잡한 알고리즘을 사용해서 발급해야 돼요.

### Bearer 인증의 장점 및 단점

Bearer 인증은 안전하고, 확장이 쉬워요.

Bearer 토큰은 쉽게 복호화 할 수 없고 OAuth는 프레임워크의 인증 및 리소스 서버는 SSL/TLS를 필수로 사용해요. 게다가 서버에서 토큰의 리소스 접근 권한을 쉽게 철회할 수도 있고, 토큰의 유효기간을 설정할 수 있어서 안전하게 리소스를 보호할 수 있어요. OAuth 프레임워크는 또 제한적으로 리소스 접근을 정교하게 설정할 수 있어요.

Bearer 토큰 자체가 메타데이터를 가지고 있어서 서버는 토큰을 발급만 하고 보관할 필요가 없어요. 사용자가 아무리 많아도 토큰을 검증하는 과정은 같은 시간이 소요돼요. 게다가 여러 서비스 및 서버 간에 토큰을 공유할 수 있어서 사용자에게 편리한 경험을 제공해요.

하지만 Bearer 인증도 보안 측면에서 문제가 있어요.

만약 Bearer 토큰이 외부에 노출되면 다른 서비스도 토큰으로 바로 리소스를 접근할 수 있어요. 하지만 서버가 OAuth 프레임워크에 정의된 보안 장치를 잘 구축하면 문제가 없고, 노출이 발견되면 해당 토큰의 권한을 철회할 수 있어요.

Basic 인증 방식과 Bearer 인증 방식의 대표적인 차이점은 아래 표에서 확인하세요.

|  | 보안 | 확장성 | 복잡성 |
| --- | --- | --- | --- |
| Basic 인증 | 쉽게 복호화할 수 있는 base64를 사용하고, 노출된 인증 정보를 철회할 방법이 없음 | 사용자 정보를 서버에 저장하기 때문에 사용자 많을 수록 서버에 부담됨 | 간단한 인증 방법이지만, 정교하게 권한을 제어하기 어려움 |
| Bearer 인증 | 충분히 복잡한 알고리즘으로 토큰을 발급하고, 토큰이 노출되면 권한을 철회할 수 있음 | Bearer 토큰이 메타데이터를 담고 있어서 사용자가 많아도 서버에 부담되지 않음 | 정교하게 권한을 제어할 수 있고 유효기간, MFA 등 추가 장치도 연동할 수 있음 |

## 토스페이먼츠는 어떻게 인증하고 있을까요?

토스페이먼츠는 언제 Basic 인증을 사용하고, 언제 Bearer 인증을 사용하는지 알려드릴게요.

### 상점 정보가 필요한 API는 Basic 인증

결제, 결제 취소, 현금영수증 발급 등 상점에서 자주 사용하는 [코어 API](https://docs.tosspayments.com/reference) 는 Basic 인증 방식을 사용해요. “Basic 인증 방식을 사용하면 결제 정보가 위험한 거 아닌가”라고 생각할 수 있지만 토스페이먼츠는 HTTPS/SSL 통신을 강제하고 있어서 안전해요.

토스페이먼츠는 시크릿 키를 사용자 ID로 사용하고 비밀번호는 없어요. `{SECRET_KEY}:`문자열을 base64 인코딩해서 API 인증 헤더에 사용하면 돼요.

```
Authorization: Basic dGVzdF9za19PeUwwcVo0RzFWT0xvYkI2S3d2cm9XYjJNUVlnOg==
```

✅ 더 자세한 내용은 [API 인증 페이지](https://docs.tosspayments.com/reference/using-api/authorization) 에서 확인하세요.

### 결제 고객을 특정해야 하는 API는 Bearer 인증

보통 토스페이먼츠는 결제 고객의 정보를 저장하지 않지만 브랜드페이를 사용하는 결제 고객의 정보는 저장해요. 브랜드페이는 상점에서 자체 간편결제 시스템을 구축하는 서비스예요. 그래서 브랜드페이에 가입한 고객, 고객이 등록한 결제 수단 등 민감한 고객 정보를 서버에 저장해요.

상점이 브랜드페이 고객 정보를 접근하려면 Bearer 유형의 액세스 토큰을 토스페이먼츠에서 발급받아요. 브랜드페이 서비스 자체가 OAuth 프레임워크를 사용하고, 더 안전하게 고객 정보를 보관하기 위해서 Bearer 인증 방식을 사용했어요.

[Access Token을 발급](https://docs.tosspayments.com/blog/reference/brandpay#access-token-%EB%B0%9C%EA%B8%89) 받은 뒤 인증 헤더에 사용하면 돼요.

```
Authorization: Bearer Xy0E4Dv5qpMGjLJoQ1aVZ5449xB1P3w6KYe2RNgOWznZb7Bm
```

✅ 더 자세한 내용은 [브랜드페이 인증 페이지](https://docs.tosspayments.com/guides/brandpay/auth) 에서 확인하세요

  

**Writer** 박수연 **Graphic** 이은호, 이나눔

---

**📍 참고하면 좋은 자료**