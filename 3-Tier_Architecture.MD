## Expenses Project ##
## 🏗️ 3-Tier Architecture Project( Manual and Automation Way) ##

🏗️ 3-Tier Architecture Definition
````
3-Tier Architecture is a software architecture model that separates an application into three independent layers:
```

```
1️⃣ Presentation Tier/Layer (Frontend):
    Presentation Layer → Handles user interface

2️⃣ Application Tier/Layer (Backend):
    Application Layer → Processes business logic

3️⃣ Data Tier/Layer (Database):
    Data Layer → Stores and manages data

```
Each tier runs on separate servers or services and communicates with the other tiers to process user requests.

🏗️ 3-Tier Architecture Flow:

Flow:
```
User → Frontend(Presentation Layer) → Backend(Application Layer) → Database(Data Layer)

```
Response Flow:
```
Database(Data Layer) → Backend(Application Layer) → Frontend(Presentation Layer) → User
```

Layers in 3-Tier Architecture

1️⃣ Presentation Tier (Frontend)

Definition:
```
The Presentation Layer is responsible for providing the user interface and interacting directly with users. It collects user input and sends requests to the Application Layer (Backend).

```
Examples:
```
HTML, CSS, JavaScript
React / Angular
Login page
Dashboard
Expense entry form
```
Role:
```
User → Frontend(Presentation Layer) → Backend(Application Layer)
```

2️⃣ Application Tier (Backend)

Definition:
```
The Application Tier contains the business logic of the system and processes requests received from the Presentation Layer (Frontend) before communicating with the Data Layer (Database).
```
Examples:
```
Java (Spring Boot)
Node.js
Python (Flask / Django)
```
Role:
```
Frontend(Presentation Layer) → Backend(Application Layer) → Database(Data Layer)
```

3️⃣ Data Tier (Database)

Definition:
```
The Data Tier stores, retrieves, and manages application data. It responds to requests received from the Application Layer (Backend).
```
Examples:
```
MySQL
PostgreSQL
MongoDB
```
Role:
```
Backend(Application Layer) ↔ DatDatabase(Data Layer)
```