# SmartBank — Banking System

A Spring Boot banking application with JWT auth, MySQL, email alerts, PDF statements, and an AI-powered chatbot.

## Quick Start (Docker)

```bash
# 1. Clone and enter directory
git clone <your-repo-url>
cd banking-fixed

# 2. Set environment variables
cp .env.example .env
# Edit .env with your DB password, email credentials, JWT secret

# 3. Start everything
docker-compose up -d

# 4. Open in browser
open http://localhost:8080
```

## Local Dev (without Docker)

**Prerequisites:** Java 17, Maven, MySQL 8

```bash
# Create database
mysql -u root -p -e "CREATE DATABASE bank;"

# Set env vars or edit application.properties
export DB_PASSWORD=yourpassword
export MAIL_USERNAME=you@gmail.com
export MAIL_PASSWORD=your-app-password

# Run
cd backend
./mvnw spring-boot:run
```

## Environment Variables

| Variable | Description | Default |
|---|---|---|
| `DB_URL` | MySQL JDBC URL | `jdbc:mysql://localhost:3306/bank` |
| `DB_USERNAME` | DB username | `root` |
| `DB_PASSWORD` | DB password | *(required)* |
| `MAIL_USERNAME` | Gmail address | *(required for email alerts)* |
| `MAIL_PASSWORD` | Gmail App Password | *(required for email alerts)* |
| `JWT_SECRET` | Base64 JWT signing key | *(change in production!)* |
| `JWT_EXPIRATION` | Token TTL in ms | `86400000` (24h) |

## API Endpoints

| Method | URL | Auth | Description |
|---|---|---|---|
| POST | `/api/user` | No | Create account |
| POST | `/api/user/login` | No | Login → JWT |
| POST | `/api/user/balanceEnquiry` | JWT | Get balance |
| POST | `/api/user/nameEnquiry` | JWT | Get account name |
| POST | `/api/user/credit` | JWT | Deposit money |
| POST | `/api/user/debit` | JWT | Withdraw money |
| POST | `/api/user/transfer` | JWT | Transfer funds |
| GET | `/bankStatement` | JWT | Get transactions (PDF + list) |
| POST | `/chatbot/ask` | No | AI chatbot |
| GET | `/swagger-ui.html` | No | API docs |

## Chatbot Commands

The chatbot understands natural language:

- **"check balance"** — shows current balance
- **"deposit 5000"** — credits ₹5000
- **"withdraw 2000"** — debits ₹2000
- **"transfer 1000 to 9876543210"** — transfers funds
- **"what is my name"** — shows account holder name
- **"help"** — shows all commands

## Fixes Applied

1. **transaction.html** — Removed stray ` ```html ``` ` markdown fences that were rendering as text
2. **transaction.html** — Fixed `t.id` → `t.transactionId` (correct entity field name)
3. **chatbot.html** — Full rewrite: multi-turn conversation, intent parsing, result cards, typing indicator, quick-action chips
4. **application.properties** — Replaced hardcoded credentials with environment variables
5. **Dockerfile + docker-compose** — Added for one-command deployment
6. **.env.example** — Template for secrets (never commit `.env`)
7. **.gitignore** — Excludes `.env`, `target/`, IDE files

## Scope of Improvement

### Security
- Add refresh token endpoint (current JWT never refreshes)
- Rate-limit `/api/user/login` to prevent brute force
- Add input sanitization on account number fields
- Replace hardcoded JWT secret with a generated 256-bit key
- Move `/chatbot/ask` behind JWT auth (currently open)

### Features
- OTP/2FA verification on login
- Transaction PIN for debit/transfer
- Push notifications (Firebase)
- Paginated transaction history
- Scheduled statements (weekly/monthly email)
- Account freezing / KYC status

### Code Quality
- Add unit tests (JUnit 5 + Mockito) — currently 0% coverage
- Add integration tests with Testcontainers
- Replace `@Autowired` fields with constructor injection
- Add proper logging with correlation IDs
- Add OpenAPI annotations to all endpoints

### Infrastructure
- Add health-check endpoint (`/actuator/health`)
- Add Prometheus metrics (`/actuator/prometheus`)
- Add Redis for session/token blacklisting on logout
- Use environment-specific profiles (`dev`, `prod`)
- Add CI/CD pipeline (GitHub Actions)
