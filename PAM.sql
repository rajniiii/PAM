-- =====================================================
-- PRIVILEGED ACCESS MANAGEMENT (PAM) SYSTEM DATABASE

-- Drop existing database if exists and create new one
DROP DATABASE IF EXISTS data_PAM;
CREATE DATABASE data_PAM;
USE data_PAM;

-- =====================================================
-- 1. USERS TABLE - Stores all system users
-- =====================================================
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(100) NOT NULL UNIQUE,
    full_name VARCHAR(200) NOT NULL,
    email VARCHAR(200) NOT NULL UNIQUE,
    department VARCHAR(100) NOT NULL,
    job_title VARCHAR(150),
    manager_id INT,
    account_status ENUM('Active', 'Inactive', 'Suspended', 'Pending') DEFAULT 'Active',
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    last_login DATETIME,
    risk_score DECIMAL(3,2) DEFAULT 0.00,
    FOREIGN KEY (manager_id) REFERENCES Users(user_id)
);

-- =====================================================
-- 2. PRIVILEGED ACCOUNTS TABLE - High-value accounts
-- =====================================================
CREATE TABLE Privileged_Accounts (
    account_id INT PRIMARY KEY AUTO_INCREMENT,
    account_name VARCHAR(100) NOT NULL UNIQUE,
    account_type ENUM('Admin', 'Root', 'Service', 'Application', 'Database') NOT NULL,
    system_name VARCHAR(150) NOT NULL,
    environment ENUM('Production', 'Staging', 'Development', 'QA') NOT NULL,
    password_last_changed DATETIME,
    password_complexity_level ENUM('Low', 'Medium', 'High', 'Very High') DEFAULT 'High',
    is_critical BOOLEAN DEFAULT FALSE,
    compliance_category VARCHAR(50),
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    last_accessed DATETIME
);

-- =====================================================
-- 3. ACCESS REQUESTS TABLE - Request tracking
-- =====================================================
CREATE TABLE Access_Requests (
    request_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    account_id INT NOT NULL,
    request_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    requested_duration_hours INT NOT NULL,
    business_justification TEXT NOT NULL,
    request_status ENUM('Pending', 'Approved', 'Rejected', 'Expired', 'Cancelled') DEFAULT 'Pending',
    approved_by INT,
    approved_date DATETIME,
    rejection_reason TEXT,
    priority_level ENUM('Low', 'Medium', 'High', 'Critical') DEFAULT 'Medium',
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (account_id) REFERENCES Privileged_Accounts(account_id),
    FOREIGN KEY (approved_by) REFERENCES Users(user_id)
);

-- =====================================================
-- 4. ACCESS SESSIONS TABLE - Active session tracking
-- =====================================================
CREATE TABLE Access_Sessions (
    session_id INT PRIMARY KEY AUTO_INCREMENT,
    request_id INT NOT NULL,
    user_id INT NOT NULL,
    account_id INT NOT NULL,
    session_start DATETIME DEFAULT CURRENT_TIMESTAMP,
    session_end DATETIME,
    session_duration_minutes INT,
    ip_address VARCHAR(45),
    location VARCHAR(200),
    access_method ENUM('Web Portal', 'SSH', 'RDP', 'API', 'Direct') NOT NULL,
    session_status ENUM('Active', 'Completed', 'Terminated', 'Timeout') DEFAULT 'Active',
    commands_executed INT DEFAULT 0,
    FOREIGN KEY (request_id) REFERENCES Access_Requests(request_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (account_id) REFERENCES Privileged_Accounts(account_id)
);

-- =====================================================
-- 5. SECURITY INCIDENTS TABLE - Security events
-- =====================================================
CREATE TABLE Security_Incidents (
    incident_id INT PRIMARY KEY AUTO_INCREMENT,
    session_id INT,
    user_id INT,
    account_id INT,
    incident_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    incident_type ENUM('Unauthorized Access', 'Policy Violation', 'Suspicious Activity', 
                       'Password Issue', 'Compliance Breach', 'Failed Login') NOT NULL,
    severity ENUM('Low', 'Medium', 'High', 'Critical') NOT NULL,
    description TEXT NOT NULL,
    incident_status ENUM('Open', 'Investigating', 'Resolved', 'Closed') DEFAULT 'Open',
    resolution_date DATETIME,
    resolved_by INT,
    FOREIGN KEY (session_id) REFERENCES Access_Sessions(session_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (account_id) REFERENCES Privileged_Accounts(account_id),
    FOREIGN KEY (resolved_by) REFERENCES Users(user_id)
);

-- =====================================================
-- 6. AUDIT LOGS TABLE - Complete audit trail
-- =====================================================
CREATE TABLE Audit_Logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    user_id INT,
    account_id INT,
    action_type ENUM('Login', 'Logout', 'Access Grant', 'Access Revoke', 
                     'Password Change', 'Configuration Change', 'Query Execution') NOT NULL,
    action_details TEXT,
    source_ip VARCHAR(45),
    result ENUM('Success', 'Failure', 'Warning') NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (account_id) REFERENCES Privileged_Accounts(account_id)
);

-- =====================================================
-- 7. COMPLIANCE REPORTS TABLE - Regulatory compliance
-- =====================================================
CREATE TABLE Compliance_Reports (
    report_id INT PRIMARY KEY AUTO_INCREMENT,
    report_date DATE NOT NULL,
    report_type VARCHAR(100) NOT NULL,
    compliance_framework VARCHAR(100), -- e.g., SOX, PCI-DSS, HIPAA
    total_accounts_reviewed INT,
    compliant_accounts INT,
    non_compliant_accounts INT,
    compliance_percentage DECIMAL(5,2),
    critical_findings INT DEFAULT 0,
    report_status ENUM('Draft', 'Final', 'Submitted') DEFAULT 'Draft',
    created_by INT,
    FOREIGN KEY (created_by) REFERENCES Users(user_id)
);

-- =====================================================
-- 8. PASSWORD HISTORY TABLE - Password change tracking
-- =====================================================
CREATE TABLE Password_History (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT NOT NULL,
    changed_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    changed_by INT NOT NULL,
    change_reason ENUM('Scheduled Rotation', 'Security Incident', 'Manual Change', 'Compliance') NOT NULL,
    password_strength_score INT,
    FOREIGN KEY (account_id) REFERENCES Privileged_Accounts(account_id),
    FOREIGN KEY (changed_by) REFERENCES Users(user_id)
);

-- =====================================================
-- INDEXES FOR PERFORMANCE OPTIMIZATION
-- =====================================================
CREATE INDEX idx_user_department ON Users(department);
CREATE INDEX idx_user_status ON Users(account_status);
CREATE INDEX idx_account_type ON Privileged_Accounts(account_type);
CREATE INDEX idx_account_environment ON Privileged_Accounts(environment);
CREATE INDEX idx_request_status ON Access_Requests(request_status);
CREATE INDEX idx_request_date ON Access_Requests(request_date);
CREATE INDEX idx_session_status ON Access_Sessions(session_status);
CREATE INDEX idx_session_start ON Access_Sessions(session_start);
CREATE INDEX idx_incident_date ON Security_Incidents(incident_date);
CREATE INDEX idx_incident_severity ON Security_Incidents(severity);
CREATE INDEX idx_audit_timestamp ON Audit_Logs(timestamp);
CREATE INDEX idx_audit_action ON Audit_Logs(action_type);

-- =====================================================
-- SUCCESS MESSAGE
-- =====================================================
SELECT 'PAM System Database Schema Created Successfully!' AS Status;