# 🏢 Enterprise Data Modeling Case Studies – Real-World SQL & ER Design Projects
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

## Introduction

Welcome to my Data Modeling Portfolio, a collection of five end-to-end SQL and ER-based projects designed to simulate real-world enterprise database systems across diverse business domains.
Each project reimagines how organizations can structure, manage, and analyze their operational data using PostgreSQL, DBML (dbdiagram.io), and pgAdmin 4 — blending technical design with strong business logic and analytics thinking.

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

## 🎯 Objective

The goal of this repository is to demonstrate:

1. How business workflows can be translated into scalable relational databases

2. How entities, attributes, and relationships drive real-world operations

3. How a well-structured schema enables insights, reporting, and automation

4. My capability to design SQL architectures for industry-grade use cases

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

## 🧱 Projects Overview

Below are the five projects included in this repository — each representing a unique business vertical, complete with problem statement, ER model, and PostgreSQL schema.

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

### 🎧 1. Amazon Sonic – Unified Music & Creator Economy Platform

A streaming ecosystem inspired by platforms like Spotify and Amazon Music, connecting listeners, artists, and labels.

- Focus: Music streaming data architecture, royalty computation, and subscription billing.

- Highlights:

   - 20 key entities covering users, songs, artists, playlists, and payments.

   - Royalty events tied to real-time streams for transparent artist payouts.

   - Subscription plans and invoices built with normalized relationships.

- Key Tables: users, artists, songs, streams, royalty_events, plans, payments.

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

### 💳 2. Credora Global – Credit Card Intelligence Platform

A fintech-grade data model for a global credit-card company managing millions of daily transactions.

- Focus: Card lifecycle, transactions, rewards, fraud alerts, and global compliance.

- Highlights:

   - End-to-end schema covering customers, cards, statements, and payments.

   - Fraud detection and customer-support modules.

   - Regulatory mapping and dynamic limit-change tracking.

- Key Tables: customer, credit_card, card_transaction, rewards, statement, fraud_alert.

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

### 🎓 3. LearnSphere – EdTech & Learning Ecosystem

A modern online-learning database supporting courses, instructors, programs, and learner analytics.

- Focus: Learning journeys, assessments, and digital-commerce workflows.

- Highlights:

   - 20 normalized entities connecting courses, modules, lessons, and quizzes.

   - Commerce section managing orders, items, and payments.

   - Scalable design for progress tracking and quiz submissions.

- Key Tables: users, courses, lessons, enrollments, submissions, order_items, payments.

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

### 🏥 4. MediLink 360 – Global Tele-Health & Insurance System

A unified health-tech database integrating tele-consultations, labs, pharmacies, and insurance claims.

- Focus: Patient lifecycle, doctor networks, and insurance claim pipelines.

- Highlights:

   - End-to-end schema covering appointments, prescriptions, lab results, and claims.

   - Policy and membership management for insurers.

   - Detailed claim-item mapping for medical reimbursements.

- Key Tables: patients, doctors, consultations, prescriptions, claims, claim_items, payments.

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

### 🚗 5. AutoVerse – Intelligent Vehicle-Sharing & Fleet Operations

A next-generation mobility platform connecting drivers, passengers, vehicles, and charging stations.

- Focus: Ride-sharing, telemetry, payments, and fleet-maintenance data.

- Highlights:

   - Real-time trips, bookings, and driver-payout workflows.

   - EV charging-session tracking and sustainability metrics.

   - Incident reporting and customer-support modules.

- Key Tables: users, drivers, vehicles, trips, payments, charging_sessions, subscriptions.

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

### 🧩 Tech Stack & Tools

| Layer                    | Tools / Technologies |
| :----------------------- | :------------------- |
| **Modeling & ER Design** | DBML (dbdiagram.io)  |
| **Management**           | pgAdmin 4            |
| **Language Support**     | SQL                  |

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

### 📚 Contents

Each project folder includes:

1. 🧾 Problem Statement – Detailed business scenario and data objectives.

2. 🧠 Entity-Relationship Model (ERD) – Diagram with 20–21 core entities.

3. 🧩 PostgreSQL DDL – CREATE TABLE scripts for all entities.

4. 🧮 Sample Data (Coming Soon) – Synthetic datasets for hands-on queries.

5. 📊 Analytical SQL Queries – Example joins, aggregations, and insights.

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

### 🔍 Learning Outcomes

Through this series I explored:

- Designing normalized relational schemas for business logic.

- Mapping one-to-many and many-to-many relationships.

- Structuring data for analytics, compliance, and operational intelligence.

- Translating ambiguous problem statements into technical deliverables.

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

### 💡 Future Scope

- Add data-generation scripts using Python (Faker + Pandas).

- Build Tableau / Power BI dashboards from the datasets.

- Expand to NoSQL comparative models for hybrid analytics.

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

### ✨ About This Work

This repository showcases my ability to:

1. Understand business systems end-to-end,

2. Build clean, scalable database architectures, and

3. Bridge the gap between data engineering and business analytics.

It reflects my business-analyst + data-architect mindset — translating complex organizational needs into actionable SQL models ready for analytics and visualization.

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
