= Widok wytwarzania

== Wprowadzenie

Widok wytwarzania przedstawia technologie, narzędzia oraz proces wdrażania aplikacji webowej do zarządzania salonem samochodowym. System składa się z frontendu w React oraz backendu opartego na funkcjach AWS Lambda w TypeScript, z infrastrukturą zarządzaną przez AWS CDK.

== Technologie

=== Frontend
- *Framework:* React
- *Język:* TypeScript
- *Hosting:* AWS S3 + CloudFront
- *Routing DNS:* AWS Route53

=== Backend
- *Język:* TypeScript
- *Runtime:* AWS Lambda (Node.js)
- *API:* API Gateway (REST)
- *Bazy danych:* Amazon RDS (relacyjne bazy danych)

=== Infrastruktura jako Kod
- *Narzędzie:* AWS CDK
- *Język:* TypeScript
- *Wersjonowanie:* Git

=== Usługi AWS
- *Route53* - zarządzanie DNS
- *CloudFront* - dystrybucja CDN
- *S3* - hosting statycznej strony
- *API Gateway* - warstwa API
- *Lambda* - funkcje serverless
- *RDS* - bazy danych relacyjne
- *Secrets Manager* - zarządzanie sekretami

== Architektura wdrożenia

System jest wdrażany jako aplikacja serverless w chmurze AWS. Użytkownicy łączą się przez Route53 do CloudFront, który dystrybuuje:
- Statyczne pliki frontendu (React) z S3
- Requesty API przez API Gateway do funkcji Lambda

== Funkcje Lambda

System składa się z trzech głównych funkcji Lambda napisanych w TypeScript:

=== Auth Lambda
Odpowiedzialna za autoryzację i uwierzytelnianie użytkowników.
- *Połączenia:* Account Database
- *Operacje:* logowanie, rejestracja, zarządzanie sesjami

=== Showroom and Service Lambda
Obsługuje funkcjonalności związane z salonem i serwisem samochodowym.
- *Połączenia:* Showroom and Service Database
- *Operacje:* zarządzanie pojazdami, rezerwacje wizyt serwisowych, harmonogram

=== Shop Lambda
Obsługuje sklep internetowy z częściami i akcesoriami.
- *Połączenia:* 
  - Shop Database
  - Third party payment provider (TPay)
- *Operacje:* katalog produktów, koszyk, zamówienia, integracja z systemem płatności

== Bazy danych

System wykorzystuje trzy oddzielne bazy danych RDS:
- *Account Database* - dane użytkowników i autoryzacji
- *Showroom and Service Database* - dane o pojazdach, wizytach, serwisie
- *Shop Database* - katalog produktów, zamówienia

Separacja baz danych zapewnia lepszą skalowalność i izolację danych pomiędzy domenami biznesowymi.

== Proces wdrażania

Wdrożenie systemu odbywa się automatycznie za pomocą AWS CDK:

1. *Przygotowanie kodu:*
   - Kompilacja frontendu React do statycznych plików
   - Kompilacja kodu TypeScript backendu

2. *Synteza infrastruktury:*
   ```bash
   cdk synth
   ```
   Generuje szablony CloudFormation

3. *Wdrożenie:*
   ```bash
   cdk deploy --all
   ```
   Tworzy/aktualizuje wszystkie zasoby AWS

4. *Invalidacja cache:*
   Po wdrożeniu frontendu automatyczna invalidacja CloudFront

== Struktura projektu

```
salon-samochodowy/
├── frontend/              # Aplikacja React
│   ├── src/
│   └── public/
├── backend/              # Funkcje Lambda (TypeScript)
│   ├── auth/
│   ├── showroom-service/
│   └── shop/
├── infra/                # Infrastruktura AWS CDK
│   └── lib/
│       ├── frontend-stack.ts
│       ├── api-stack.ts
│       ├── database-stack.ts
│       └── lambda-stack.ts
└── shared/               # Współdzielone typy i utilities
```
