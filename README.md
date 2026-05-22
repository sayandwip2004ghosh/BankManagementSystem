# 🏦 Bank Management System

A full-stack banking web application with secure JWT authentication, real-time transactions, PDF bank statements, and an AI-assisted chatbot.



## 🛠️ Tech Stack
- **Backend:** Java 17, Spring Boot, Spring Security
- **Database:** MySQL
- **Authentication:** JWT (JSON Web Token)
- **Frontend:** HTML, CSS, JavaScript
- **Other:** Docker, iText PDF(Coming soon) , JavaMail

## ✨ Features
- ✅ User Registration & Login (JWT secured)
- ✅ Check Account Balance
- ✅ Deposit & Withdraw Funds
- ✅ Fund Transfer between accounts
- ✅ Transaction History
- ✅ PDF Bank Statement (emailed automatically)
- ✅ AI Chatbot with identity verification before any action

## 🚀 How to Run
## Quick Start (Docker)
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
- Scheduled statements (weekly/monthly email)(Coming SOON)
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
- Add CI/CD pipeline (GitHub Actio
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
### Prerequisites
- Java 17
- MySQL
- Maven

### Steps
1. Clone the repo
```bash
   git clone https://github.com/sayandwip2004ghosh/BankManagementSystem.git
```
2. Create a `.env` file from `.env.example` and fill in your MySQL and email credentials
3. Run the app
```bash
   ./mvnw spring-boot:run
```
4. Open browser → `http://localhost:8080`

### Or run with Docker
```bash
docker-compose up --build
```

## 📸 Screenshots


### 🏠 Home / Login
<img width="1918" height="915" alt="image" src="https://github.com/user-attachments/assets/cdb0e0c4-16a5-4447-a2ec-b9a307a6ef9f" />

### 📊 Dashboard
<img width="1917" height="920" alt="image" src="https://github.com/user-attachments/assets/42ca9fcd-02db-4506-beca-f6da34aa4e43" />

### 💰 Balance / Transactions
<img width="971" height="652" alt="image" src="https://github.com/user-attachments/assets/e2d8f0bc-1243-4bd5-81e6-a4265eb27d27" />
<img width="1077" height="468" alt="image" src="https://github.com/user-attachments/assets/3c9bcc9e-b866-4222-8140-1356752e7393" />

### 🔄 Transfer / Deposit / Withdraw
<img width="675" height="407" alt="image" src="https://github.com/user-attachments/assets/0c79ef86-62ad-4fd1-9467-e028a5cda336" />
<img width="661" height="481" alt="image" src="https://github.com/user-attachments/assets/351b0dc8-dda0-4678-a18f-5696a937096a" />
<img width="820" height="480" alt="image" src="https://github.com/user-attachments/assets/1f79fd25-4fa8-42ec-b87c-329b4daecbb8" />

### 🤖 Chatbot
<img width="1916" height="806" alt="image" src="https://github.com/user-attachments/assets/19e5e657-7b62-401a-9109-631c3abcc209" />



###Transaction History
<img width="1918" height="828" alt="image" src="https://github.com/user-attachments/assets/cbb2bb3e-e4a1-43b9-87b7-0ce057c83587" />


## 👨‍💻 Author
**Sayandwip Ghosh**  
[GitHub](https://github.com/sayandwip2004ghosh)














ns)
