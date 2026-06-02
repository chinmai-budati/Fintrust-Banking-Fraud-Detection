CREATE DATABASE banking_fraud_analytics;
USE banking_fraud_analytics;

-- 1. CUSTOMERS TABLE
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    gender VARCHAR(20),
    age INT,
    city VARCHAR(50),
    state VARCHAR(50),
    occupation VARCHAR(60),
    annual_income DECIMAL(12,2),
    kyc_status VARCHAR(20),
    customer_since DATE,
    risk_category VARCHAR(20)
);

-- 2. BRANCHES TABLE
CREATE TABLE Branches (
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    region VARCHAR(30),
    branch_manager VARCHAR(100),
    opening_date DATE,
    branch_type VARCHAR(30)
); 

-- 3. MERCHANTS TABLE
CREATE TABLE Merchants (
    merchant_id INT PRIMARY KEY,
    merchant_name VARCHAR(100),
    merchant_category VARCHAR(50),
    merchant_city VARCHAR(50),
    risk_level VARCHAR(20),
    chargeback_rate DECIMAL(5,2)
); 

-- 4. ACCOUNTS TABLE
CREATE TABLE Accounts (
    account_id INT PRIMARY KEY,
    customer_id INT,
    branch_id INT,
    account_type VARCHAR(30),
    account_open_date DATE,
    account_status VARCHAR(20),
    current_balance DECIMAL(14,2),
    avg_monthly_balance DECIMAL(14,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (branch_id) REFERENCES Branches(branch_id)
); 

-- 5. CREDIT CARDS TABLE
CREATE TABLE Credit_Cards (
    card_id INT PRIMARY KEY,
    customer_id INT,
    card_type VARCHAR(30),
    credit_limit DECIMAL(12,2),
    available_limit DECIMAL(12,2),
    issue_date DATE,
    expiry_date DATE,
    card_status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
); 

-- 6. DEVICE LOGINS TABLE
CREATE TABLE Device_Logins (
    login_id BIGINT PRIMARY KEY,
    customer_id INT,
    device_id VARCHAR(100),
    ip_address VARCHAR(30),
    login_city VARCHAR(50),
    login_datetime DATETIME,
    login_status VARCHAR(20),
    device_type VARCHAR(30),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- 7. TRANSACTIONS TABLE
CREATE TABLE Transactions (
    transaction_id BIGINT PRIMARY KEY,
    customer_id INT,
    account_id INT,
    card_id INT NULL, 
    transaction_datetime DATETIME,
    transaction_amount DECIMAL(14,2),
    transaction_type VARCHAR(30),
    channel VARCHAR(30),
    merchant_id INT NULL, 
    transaction_city VARCHAR(50),
    transaction_status VARCHAR(20),
    is_fraud BIT,
    fraud_type VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id),
    FOREIGN KEY (card_id) REFERENCES Credit_Cards(card_id),
    FOREIGN KEY (merchant_id) REFERENCES Merchants(merchant_id)
);

-- 8. ATM LOGS TABLE
CREATE TABLE ATM_Logs (
    atm_log_id BIGINT PRIMARY KEY,
    customer_id INT,
    account_id INT,
    atm_id VARCHAR(20),
    atm_city VARCHAR(50),
    withdrawal_amount DECIMAL(12,2),
    attempt_status VARCHAR(20),
    attempt_datetime DATETIME,
    failed_attempt_count INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);

-- 9. FRAUD ALERTS TABLE
CREATE TABLE Fraud_Alerts (
    alert_id BIGINT PRIMARY KEY,
    transaction_id BIGINT,
    alert_type VARCHAR(50),
    risk_score INT,
    alert_status VARCHAR(30),
    investigation_result VARCHAR(30),
    created_datetime DATETIME,
    resolved_datetime DATETIME,
    FOREIGN KEY (transaction_id) REFERENCES Transactions(transaction_id)
);

-- 10. CHARGEBACKS TABLE
CREATE TABLE Chargebacks (
    chargeback_id BIGINT PRIMARY KEY,
    transaction_id BIGINT,
    customer_id INT,
    reason_code VARCHAR(50),
    chargeback_amount DECIMAL(12,2),
    reported_date DATE,
    status VARCHAR(30),
    FOREIGN KEY (transaction_id) REFERENCES Transactions(transaction_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
); 
