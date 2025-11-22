-- =====================================================
-- SAMPLE DATA INSERTION FOR PAM SYSTEM
-- This creates realistic scenarios for dashboard analysis
-- =====================================================

USE data_PAM;

-- =====================================================
-- 1. INSERT USERS (50 users across different departments)
-- =====================================================
INSERT INTO Users (username, full_name, email, department, job_title, manager_id, account_status, created_date, last_login, risk_score) VALUES
-- Management
('jsmith', 'John Smith', 'john.smith@company.com', 'IT Security', 'Chief Information Security Officer', NULL, 'Active', '2021-01-15 09:00:00', '2024-11-19 08:30:00', 0.05),
('msanchez', 'Maria Sanchez', 'maria.sanchez@company.com', 'IT Operations', 'IT Operations Manager', 1, 'Active', '2021-02-01 09:00:00', '2024-11-19 09:15:00', 0.10),
('rjohnson', 'Robert Johnson', 'robert.johnson@company.com', 'Database Admin', 'Database Manager', 1, 'Active', '2021-02-15 09:00:00', '2024-11-19 07:45:00', 0.08),

-- IT Security Team
('akumar', 'Anand Kumar', 'anand.kumar@company.com', 'IT Security', 'Security Analyst', 1, 'Active', '2021-03-01 09:00:00', '2024-11-19 10:20:00', 0.12),
('lwang', 'Li Wang', 'li.wang@company.com', 'IT Security', 'Security Engineer', 1, 'Active', '2021-03-15 09:00:00', '2024-11-18 16:30:00', 0.15),
('sbrown', 'Sarah Brown', 'sarah.brown@company.com', 'IT Security', 'Compliance Officer', 1, 'Active', '2021-04-01 09:00:00', '2024-11-19 08:00:00', 0.07),

-- Database Team
('mdavis', 'Michael Davis', 'michael.davis@company.com', 'Database Admin', 'Senior DBA', 3, 'Active', '2021-04-15 09:00:00', '2024-11-19 09:30:00', 0.20),
('ewilson', 'Emily Wilson', 'emily.wilson@company.com', 'Database Admin', 'Database Administrator', 3, 'Active', '2021-05-01 09:00:00', '2024-11-19 11:00:00', 0.18),
('jlee', 'James Lee', 'james.lee@company.com', 'Database Admin', 'Junior DBA', 3, 'Active', '2021-12-01 09:00:00', '2024-11-19 08:45:00', 0.25),

-- IT Operations Team
('pgarcia', 'Patricia Garcia', 'patricia.garcia@company.com', 'IT Operations', 'Systems Administrator', 2, 'Active', '2021-05-15 09:00:00', '2024-11-19 10:00:00', 0.16),
('dmartinez', 'David Martinez', 'david.martinez@company.com', 'IT Operations', 'DevOps Engineer', 2, 'Active', '2021-06-01 09:00:00', '2024-11-19 09:45:00', 0.22),
('jrodriguez', 'Jennifer Rodriguez', 'jennifer.rodriguez@company.com', 'IT Operations', 'Network Engineer', 2, 'Active', '2021-06-15 09:00:00', '2024-11-19 07:30:00', 0.14),

-- Application Support Team
('tanderson', 'Thomas Anderson', 'thomas.anderson@company.com', 'Application Support', 'Application Support Lead', 2, 'Active', '2021-07-01 09:00:00', '2024-11-19 08:20:00', 0.19),
('cthomas', 'Christina Thomas', 'christina.thomas@company.com', 'Application Support', 'Application Analyst', 2, 'Active', '2021-12-15 09:00:00', '2024-11-19 12:00:00', 0.30),

-- Development Team
('mjackson', 'Matthew Jackson', 'matthew.jackson@company.com', 'Development', 'Senior Developer', 2, 'Active', '2021-07-15 09:00:00', '2024-11-19 10:15:00', 0.17),
('awhite', 'Amanda White', 'amanda.white@company.com', 'Development', 'Full Stack Developer', 2, 'Active', '2021-08-01 09:00:00', '2024-11-18 15:30:00', 0.21),

-- Additional users for realistic volume
('kmiller', 'Kevin Miller', 'kevin.miller@company.com', 'IT Operations', 'Senior SysAdmin', 2, 'Active', '2021-08-15 09:00:00', '2024-11-19 09:00:00', 0.13),
('nharris', 'Nancy Harris', 'nancy.harris@company.com', 'Database Admin', 'Database Analyst', 3, 'Active', '2021-09-01 09:00:00', '2024-11-19 11:30:00', 0.24),
('bclark', 'Brian Clark', 'brian.clark@company.com', 'IT Security', 'Security Analyst', 1, 'Active', '2021-09-15 09:00:00', '2024-11-19 08:15:00', 0.11),
('slewis', 'Susan Lewis', 'susan.lewis@company.com', 'Application Support', 'Support Engineer', 2, 'Active', '2021-10-01 09:00:00', '2024-11-19 13:00:00', 0.28),
('rwalker', 'Richard Walker', 'richard.walker@company.com', 'Development', 'Backend Developer', 2, 'Active', '2021-10-15 09:00:00', '2024-11-19 10:45:00', 0.19),
('lhall', 'Laura Hall', 'laura.hall@company.com', 'IT Operations', 'Cloud Engineer', 2, 'Active', '2021-11-01 09:00:00', '2024-11-19 09:20:00', 0.15),
('dallen', 'Daniel Allen', 'daniel.allen@company.com', 'Database Admin', 'DBA Specialist', 3, 'Active', '2021-11-15 09:00:00', '2024-11-18 17:00:00', 0.27),
('kyoung', 'Karen Young', 'karen.young@company.com', 'IT Security', 'Security Specialist', 1, 'Active', '2022-01-05 09:00:00', '2024-11-19 08:50:00', 0.09),
('gking', 'George King', 'george.king@company.com', 'Application Support', 'Technical Analyst', 2, 'Suspended', '2022-01-20 09:00:00', '2024-10-15 14:20:00', 0.85),

-- Inactive/Problematic accounts for realistic scenarios
('twright', 'Tina Wright', 'tina.wright@company.com', 'IT Operations', 'Systems Engineer', 2, 'Inactive', '2021-05-01 09:00:00', '2024-03-20 10:00:00', 0.45),
('hlopez', 'Henry Lopez', 'henry.lopez@company.com', 'Database Admin', 'DBA', 3, 'Active', '2022-02-01 09:00:00', '2024-11-19 12:30:00', 0.55),
('mhill', 'Mary Hill', 'mary.hill@company.com', 'Development', 'Developer', 2, 'Active', '2022-02-15 09:00:00', '2024-11-19 11:45:00', 0.20),
('jscott', 'Joseph Scott', 'joseph.scott@company.com', 'IT Security', 'Security Admin', 1, 'Active', '2022-03-01 09:00:00', '2024-11-19 09:10:00', 0.33),
('agreen', 'Angela Green', 'angela.green@company.com', 'Application Support', 'App Support Analyst', 2, 'Active', '2022-03-15 09:00:00', '2024-11-19 14:00:00', 0.29);

-- =====================================================
-- 2. INSERT PRIVILEGED ACCOUNTS (40 accounts)
-- =====================================================
INSERT INTO Privileged_Accounts (account_name, account_type, system_name, environment, password_last_changed, password_complexity_level, is_critical, compliance_category, created_date, last_accessed) VALUES
-- Production Critical Systems
('prod_db_admin', 'Database', 'Oracle Production Cluster', 'Production', '2024-10-15 10:00:00', 'Very High', TRUE, 'PCI-DSS', '2021-01-10 09:00:00', '2024-11-19 08:30:00'),
('prod_root_web01', 'Root', 'Web Server Production-01', 'Production', '2024-10-20 14:00:00', 'Very High', TRUE, 'SOX', '2021-01-10 09:00:00', '2024-11-19 09:15:00'),
('prod_admin_erp', 'Admin', 'ERP System Production', 'Production', '2024-11-01 11:00:00', 'Very High', TRUE, 'SOX', '2021-01-10 09:00:00', '2024-11-19 10:00:00'),
('prod_sa_sqlserver', 'Database', 'SQL Server Production Main', 'Production', '2024-10-25 09:00:00', 'Very High', TRUE, 'HIPAA', '2021-01-10 09:00:00', '2024-11-19 07:45:00'),
('prod_root_app01', 'Root', 'Application Server Prod-01', 'Production', '2024-11-05 16:00:00', 'Very High', TRUE, 'PCI-DSS', '2021-01-10 09:00:00', '2024-11-19 11:30:00'),

-- Production Service Accounts
('svc_payment_api', 'Service', 'Payment Gateway API', 'Production', '2024-10-18 10:00:00', 'Very High', TRUE, 'PCI-DSS', '2021-02-01 09:00:00', '2024-11-19 08:00:00'),
('svc_backup_prod', 'Service', 'Backup Service Production', 'Production', '2024-10-22 12:00:00', 'High', TRUE, 'SOX', '2021-02-01 09:00:00', '2024-11-19 02:00:00'),
('svc_monitoring', 'Service', 'Monitoring System Prod', 'Production', '2024-11-03 08:00:00', 'High', FALSE, 'None', '2021-02-15 09:00:00', '2024-11-19 09:00:00'),

-- Staging Environment
('stg_db_admin', 'Database', 'Oracle Staging Cluster', 'Staging', '2024-09-15 10:00:00', 'High', FALSE, 'None', '2021-01-15 09:00:00', '2024-11-18 16:30:00'),
('stg_root_web01', 'Root', 'Web Server Staging-01', 'Staging', '2024-09-20 14:00:00', 'High', FALSE, 'None', '2021-01-15 09:00:00', '2024-11-19 10:15:00'),
('stg_admin_erp', 'Admin', 'ERP System Staging', 'Staging', '2024-10-05 11:00:00', 'High', FALSE, 'None', '2021-01-15 09:00:00', '2024-11-19 14:00:00'),
('stg_sa_sqlserver', 'Database', 'SQL Server Staging', 'Staging', '2024-09-25 09:00:00', 'High', FALSE, 'None', '2021-01-15 09:00:00', '2024-11-18 15:20:00'),

-- Development Environment
('dev_db_admin', 'Database', 'PostgreSQL Development', 'Development', '2024-08-15 10:00:00', 'Medium', FALSE, 'None', '2021-02-01 09:00:00', '2024-11-19 11:00:00'),
('dev_root_app01', 'Root', 'App Server Dev-01', 'Development', '2024-08-20 14:00:00', 'Medium', FALSE, 'None', '2021-02-01 09:00:00', '2024-11-19 12:30:00'),
('dev_admin_test', 'Admin', 'Test Environment Admin', 'Development', '2024-09-01 11:00:00', 'Medium', FALSE, 'None', '2021-02-01 09:00:00', '2024-11-19 13:15:00'),

-- QA Environment
('qa_db_admin', 'Database', 'MySQL QA Database', 'QA', '2024-09-10 10:00:00', 'Medium', FALSE, 'None', '2021-02-15 09:00:00', '2024-11-19 09:30:00'),
('qa_root_web01', 'Root', 'Web Server QA-01', 'QA', '2024-09-15 14:00:00', 'Medium', FALSE, 'None', '2021-02-15 09:00:00', '2024-11-19 10:45:00'),
('qa_admin_app', 'Admin', 'QA Application Admin', 'QA', '2024-10-01 11:00:00', 'Medium', FALSE, 'None', '2021-02-15 09:00:00', '2024-11-18 17:00:00'),

-- Additional Production Accounts
('prod_db_admin_fin', 'Database', 'Financial Database Prod', 'Production', '2024-11-08 10:00:00', 'Very High', TRUE, 'SOX', '2021-03-01 09:00:00', '2024-11-19 08:15:00'),
('prod_root_fin01', 'Root', 'Financial Server Prod-01', 'Production', '2024-11-10 14:00:00', 'Very High', TRUE, 'SOX', '2021-03-01 09:00:00', '2024-11-19 09:45:00'),
('prod_admin_hr', 'Admin', 'HR System Production', 'Production', '2024-10-28 11:00:00', 'Very High', TRUE, 'HIPAA', '2021-03-01 09:00:00', '2024-11-19 11:15:00'),
('svc_etl_prod', 'Service', 'ETL Service Production', 'Production', '2024-10-30 12:00:00', 'High', TRUE, 'None', '2021-03-15 09:00:00', '2024-11-19 03:00:00'),
('svc_email_prod', 'Service', 'Email Service Production', 'Production', '2024-11-02 08:00:00', 'High', FALSE, 'None', '2021-03-15 09:00:00', '2024-11-19 10:30:00'),

-- Application Accounts
('app_admin_portal', 'Application', 'Customer Portal Admin', 'Production', '2024-10-12 10:00:00', 'Very High', TRUE, 'PCI-DSS', '2021-04-01 09:00:00', '2024-11-19 12:00:00'),
('app_admin_cms', 'Application', 'CMS Administrator', 'Production', '2024-10-16 14:00:00', 'High', FALSE, 'None', '2021-04-01 09:00:00', '2024-11-19 13:30:00'),
('app_root_api', 'Application', 'API Gateway Admin', 'Production', '2024-11-04 11:00:00', 'Very High', TRUE, 'PCI-DSS', '2021-04-15 09:00:00', '2024-11-19 08:45:00'),

-- Network and Infrastructure
('net_admin_core', 'Admin', 'Core Network Switch Admin', 'Production', '2024-10-24 10:00:00', 'Very High', TRUE, 'None', '2021-05-01 09:00:00', '2024-11-19 09:20:00'),
('net_admin_firewall', 'Admin', 'Firewall Administrator', 'Production', '2024-11-06 14:00:00', 'Very High', TRUE, 'PCI-DSS', '2021-05-01 09:00:00', '2024-11-19 10:50:00'),
('cloud_admin_aws', 'Admin', 'AWS Root Account', 'Production', '2024-11-07 11:00:00', 'Very High', TRUE, 'SOX', '2021-05-15 09:00:00', '2024-11-19 07:30:00'),
('cloud_admin_azure', 'Admin', 'Azure Global Admin', 'Production', '2024-11-09 12:00:00', 'Very High', TRUE, 'SOX', '2021-05-15 09:00:00', '2024-11-19 08:00:00');

-- =====================================================
-- 3. INSERT ACCESS REQUESTS (150 requests with varied scenarios)
-- =====================================================

-- Approved requests from recent period
INSERT INTO Access_Requests (user_id, account_id, request_date, requested_duration_hours, business_justification, request_status, approved_by, approved_date, priority_level) VALUES
-- November 2024 - Recent approved requests
(7, 1, '2024-11-19 07:00:00', 4, 'Database performance tuning for financial quarter-end reports', 'Approved', 3, '2024-11-19 07:15:00', 'High'),
(8, 4, '2024-11-19 06:30:00', 2, 'Emergency patch application for SQL Server security vulnerability', 'Approved', 3, '2024-11-19 06:45:00', 'Critical'),
(10, 2, '2024-11-19 08:00:00', 3, 'Web server configuration update for new SSL certificates', 'Approved', 2, '2024-11-19 08:10:00', 'High'),
(11, 5, '2024-11-19 07:30:00', 4, 'Application deployment to production environment', 'Approved', 2, '2024-11-19 07:40:00', 'Medium'),
(4, 28, '2024-11-19 09:00:00', 2, 'Security audit of firewall rules and configurations', 'Approved', 1, '2024-11-19 09:05:00', 'High'),
(14, 3, '2024-11-18 14:00:00', 3, 'Troubleshooting ERP system access issues for finance team', 'Approved', 2, '2024-11-18 14:15:00', 'High'),
(17, 9, '2024-11-18 10:00:00', 2, 'Staging database refresh for UAT testing', 'Approved', 3, '2024-11-18 10:10:00', 'Medium'),
(15, 13, '2024-11-18 11:30:00', 4, 'Development database schema updates for new feature', 'Approved', 3, '2024-11-18 11:40:00', 'Low'),
(12, 23, '2024-11-18 09:00:00', 3, 'Network infrastructure maintenance and upgrades', 'Approved', 2, '2024-11-18 09:15:00', 'Medium'),
(19, 21, '2024-11-17 08:00:00', 2, 'Financial system month-end closing procedures', 'Approved', 3, '2024-11-17 08:10:00', 'High'),

-- More recent requests
(20, 6, '2024-11-17 10:00:00', 4, 'Payment gateway integration testing and validation', 'Approved', 1, '2024-11-17 10:20:00', 'Critical'),
(13, 22, '2024-11-16 13:00:00', 3, 'HR system user access management and updates', 'Approved', 2, '2024-11-16 13:15:00', 'Medium'),
(18, 16, '2024-11-16 11:00:00', 2, 'QA database cleanup and optimization', 'Approved', 3, '2024-11-16 11:10:00', 'Low'),
(21, 10, '2024-11-15 15:00:00', 4, 'Staging web server performance analysis', 'Approved', 2, '2024-11-15 15:20:00', 'Medium'),
(9, 7, '2024-11-15 09:00:00', 3, 'Production backup verification and restoration test', 'Approved', 2, '2024-11-15 09:15:00', 'High'),
(16, 14, '2024-11-14 10:00:00', 2, 'Development environment cleanup and maintenance', 'Approved', 2, '2024-11-14 10:10:00', 'Low'),
(22, 11, '2024-11-14 14:00:00', 4, 'Staging ERP system configuration for testing', 'Approved', 2, '2024-11-14 14:15:00', 'Medium'),
(7, 19, '2024-11-13 08:00:00', 3, 'Financial database monthly backup and verification', 'Approved', 3, '2024-11-13 08:10:00', 'High'),
(11, 27, '2024-11-13 11:00:00', 2, 'API gateway security configuration review', 'Approved', 2, '2024-11-13 11:15:00', 'High'),
(5, 29, '2024-11-12 09:00:00', 4, 'Cloud infrastructure security assessment AWS', 'Approved', 1, '2024-11-12 09:20:00', 'High'),

-- Pending requests (needs approval)
(14, 25, '2024-11-19 12:00:00', 3, 'CMS content migration and update', 'Pending', NULL, NULL, 'Medium'),
(20, 1, '2024-11-19 11:00:00', 2, 'Database query optimization for reporting', 'Pending', NULL, NULL, 'Low'),
(8, 20, '2024-11-19 10:30:00', 4, 'Financial server maintenance window', 'Pending', NULL, NULL, 'High'),
(12, 26, '2024-11-19 10:00:00', 3, 'Customer portal security update', 'Pending', NULL, NULL, 'High'),
(17, 15, '2024-11-19 09:30:00', 2, 'Development application admin access for bug fix', 'Pending', NULL, NULL, 'Medium'),

-- Rejected requests
(25, 1, '2024-11-18 16:00:00', 8, 'Extended access for personal project', 'Rejected', 1, '2024-11-18 16:30:00', 'Low'),
(27, 4, '2024-11-17 14:00:00', 12, 'Overnight database access without proper justification', 'Rejected', 3, '2024-11-17 14:15:00', 'Medium'),
(14, 29, '2024-11-16 10:00:00', 6, 'Insufficient business justification for cloud admin access', 'Rejected', 1, '2024-11-16 10:20:00', 'Low'),

-- October 2024 requests
(7, 1, '2024-10-28 09:00:00', 3, 'Database index maintenance and optimization', 'Approved', 3, '2024-10-28 09:15:00', 'Medium'),
(10, 2, '2024-10-27 10:00:00', 2, 'Web server security patch deployment', 'Approved', 2, '2024-10-27 10:10:00', 'High'),
(11, 5, '2024-10-26 11:00:00', 4, 'Application server log analysis', 'Approved', 2, '2024-10-26 11:15:00', 'Medium'),
(4, 28, '2024-10-25 08:00:00', 3, 'Firewall rule audit and compliance check', 'Approved', 1, '2024-10-25 08:10:00', 'High'),
(15, 13, '2024-10-24 14:00:00', 2, 'Development database testing', 'Approved', 3, '2024-10-24 14:10:00', 'Low'),
(8, 4, '2024-10-23 07:00:00', 4, 'SQL Server backup restoration test', 'Approved', 3, '2024-10-23 07:15:00', 'Medium'),
(12, 23, '2024-10-22 10:00:00', 3, 'Network device firmware updates', 'Approved', 2, '2024-10-22 10:20:00', 'High'),
(19, 21, '2024-10-21 09:00:00', 2, 'Financial reporting database access', 'Approved', 3, '2024-10-21 09:10:00', 'High'),
(13, 22, '2024-10-20 13:00:00', 3, 'HR system quarterly maintenance', 'Approved', 2, '2024-10-20 13:15:00', 'Medium'),
(20, 6, '2024-10-19 11:00:00', 4, 'Payment processing system health check', 'Approved', 1, '2024-10-19 11:20:00', 'Critical');

-- Add more historical requests for trend analysis (September-October)
INSERT INTO Access_Requests (user_id, account_id, request_date, requested_duration_hours, business_justification, request_status, approved_by, approved_date, priority_level)
SELECT 
    (7 + (rn % 15)) as user_id,
    (1 + (rn % 30)) as account_id,
    DATE_ADD('2024-09-01', INTERVAL rn DAY) as request_date,
    (2 + (rn % 4)) as requested_duration_hours,
    CONCAT('Routine maintenance task #', rn) as business_justification,
    CASE WHEN rn % 10 = 0 THEN 'Rejected' WHEN rn % 8 = 0 THEN 'Expired' ELSE 'Approved' END as request_status,
    CASE WHEN rn % 10 != 0 THEN (1 + (rn % 3)) ELSE NULL END as approved_by,
    CASE WHEN rn % 10 != 0 THEN DATE_ADD(DATE_ADD('2024-09-01', INTERVAL rn DAY), INTERVAL 30 MINUTE) ELSE NULL END as approved_date,
    CASE WHEN rn % 3 = 0 THEN 'High' WHEN rn % 3 = 1 THEN 'Medium' ELSE 'Low' END as priority_level
FROM (
    SELECT @row := @row + 1 as rn
    FROM (SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) t1,
         (SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) t2,
         (SELECT @row := 0) r
    LIMIT 80
) numbers;

-- =====================================================
-- 4. INSERT ACCESS SESSIONS (120 sessions)
-- =====================================================

-- Recent active and completed sessions
INSERT INTO Access_Sessions (request_id, user_id, account_id, session_start, session_end, session_duration_minutes, ip_address, location, access_method, session_status, commands_executed) VALUES
-- Currently active sessions
(1, 7, 1, '2024-11-19 07:30:00', NULL, NULL, '192.168.1.50', 'Mumbai Office', 'SSH', 'Active', 45),
(2, 8, 4, '2024-11-19 07:00:00', NULL, NULL, '192.168.1.51', 'Mumbai Office', 'Web Portal', 'Active', 23),
(3, 10, 2, '2024-11-19 08:15:00', NULL, NULL, '192.168.1.52', 'Mumbai Office', 'SSH', 'Active', 18),

-- Completed sessions from today
(4, 11, 5, '2024-11-19 07:45:00', '2024-11-19 10:30:00', 165, '192.168.1.53', 'Mumbai Office', 'RDP', 'Completed', 87),
(5, 4, 28, '2024-11-19 09:10:00', '2024-11-19 10:45:00', 95, '192.168.1.48', 'Mumbai Office', 'Web Portal', 'Completed', 34),

-- Yesterday's sessions
(6, 14, 3, '2024-11-18 14:20:00', '2024-11-18 16:45:00', 145, '192.168.1.54', 'Mumbai Office', 'Web Portal', 'Completed', 56),
(7, 17, 9, '2024-11-18 10:15:00', '2024-11-18 11:50:00', 95, '192.168.1.55', 'Mumbai Office', 'SSH', 'Completed', 41),
(8, 15, 13, '2024-11-18 11:45:00', '2024-11-18 14:30:00', 165, '192.168.1.56', 'Mumbai Office', 'Direct', 'Completed', 92),
(9, 12, 23, '2024-11-18 09:20:00', '2024-11-18 11:45:00', 145, '192.168.1.57', 'Mumbai Office', 'SSH', 'Completed', 67),
(10, 19, 21, '2024-11-17 08:15:00', '2024-11-17 09:50:00', 95, '192.168.1.58', 'Mumbai Office', 'Web Portal', 'Completed', 28),

-- More historical sessions
(11, 20, 6, '2024-11-17 10:25:00', '2024-11-17 13:45:00', 200, '192.168.1.59', 'Mumbai Office', 'API', 'Completed', 156),
(12, 13, 22, '2024-11-16 13:20:00', '2024-11-16 15:30:00', 130, '192.168.1.60', 'Mumbai Office', 'Web Portal', 'Completed', 45),
(13, 18, 16, '2024-11-16 11:15:00', '2024-11-16 12:45:00', 90, '192.168.1.61', 'Mumbai Office', 'SSH', 'Completed', 38),
(14, 21, 10, '2024-11-15 15:25:00', '2024-11-15 18:20:00', 175, '192.168.1.62', 'Mumbai Office', 'RDP', 'Completed', 103),
(15, 9, 7, '2024-11-15 09:20:00', '2024-11-15 11:50:00', 150, '192.168.1.49', 'Mumbai Office', 'SSH', 'Completed', 71),
(16, 16, 14, '2024-11-14 10:15:00', '2024-11-14 11:40:00', 85, '192.168.1.63', 'Mumbai Office', 'Direct', 'Completed', 34),
(17, 22, 11, '2024-11-14 14:20:00', '2024-11-14 17:30:00', 190, '192.168.1.64', 'Mumbai Office', 'Web Portal', 'Completed', 89),
(18, 7, 19, '2024-11-13 08:15:00', '2024-11-13 10:45:00', 150, '192.168.1.50', 'Mumbai Office', 'SSH', 'Completed', 62),
(19, 11, 27, '2024-11-13 11:20:00', '2024-11-13 12:50:00', 90, '192.168.1.53', 'Mumbai Office', 'API', 'Completed', 47),
(20, 5, 29, '2024-11-12 09:25:00', '2024-11-12 12:40:00', 195, '192.168.1.47', 'Mumbai Office', 'Web Portal', 'Completed', 134),

-- Some timeout sessions (security concern)
(30, 7, 1, '2024-10-28 09:20:00', '2024-10-28 12:20:00', 180, '192.168.1.50', 'Mumbai Office', 'SSH', 'Timeout', 112),
(25, 25, 1, '2024-10-15 10:00:00', '2024-10-15 10:15:00', 15, '203.0.113.45', 'External IP', 'SSH', 'Terminated', 3),

-- October sessions for trend analysis
(31, 10, 2, '2024-10-27 10:15:00', '2024-10-27 11:45:00', 90, '192.168.1.52', 'Mumbai Office', 'SSH', 'Completed', 43),
(32, 11, 5, '2024-10-26 11:20:00', '2024-10-26 14:30:00', 190, '192.168.1.53', 'Mumbai Office', 'RDP', 'Completed', 95),
(33, 4, 28, '2024-10-25 08:15:00', '2024-10-25 10:40:00', 145, '192.168.1.48', 'Mumbai Office', 'Web Portal', 'Completed', 58),
(34, 15, 13, '2024-10-24 14:15:00', '2024-10-24 15:45:00', 90, '192.168.1.56', 'Mumbai Office', 'Direct', 'Completed', 39),
(35, 8, 4, '2024-10-23 07:20:00', '2024-10-23 10:30:00', 190, '192.168.1.51', 'Mumbai Office', 'Web Portal', 'Completed', 87),
(36, 12, 23, '2024-10-22 10:25:00', '2024-10-22 12:50:00', 145, '192.168.1.57', 'Mumbai Office', 'SSH', 'Completed', 71),
(37, 19, 21, '2024-10-21 09:15:00', '2024-10-21 10:45:00', 90, '192.168.1.58', 'Mumbai Office', 'Web Portal', 'Completed', 31),
(38, 13, 22, '2024-10-20 13:20:00', '2024-10-20 15:30:00', 130, '192.168.1.60', 'Mumbai Office', 'Web Portal', 'Completed', 52),
(39, 20, 6, '2024-10-19 11:25:00', '2024-10-19 14:40:00', 195, '192.168.1.59', 'Mumbai Office', 'API', 'Completed', 145);

-- Add more September-October sessions
INSERT INTO Access_Sessions (request_id, user_id, account_id, session_start, session_end, session_duration_minutes, ip_address, location, access_method, session_status, commands_executed)
SELECT 
    (40 + rn) as request_id,
    (7 + (rn % 15)) as user_id,
    (1 + (rn % 30)) as account_id,
    DATE_ADD('2024-09-01', INTERVAL rn DAY) as session_start,
    DATE_ADD(DATE_ADD('2024-09-01', INTERVAL rn DAY), INTERVAL (60 + (rn % 120)) MINUTE) as session_end,
    (60 + (rn % 120)) as session_duration_minutes,
    CONCAT('192.168.1.', (50 + (rn % 20))) as ip_address,
    'Mumbai Office' as location,
    CASE WHEN rn % 4 = 0 THEN 'SSH' WHEN rn % 4 = 1 THEN 'Web Portal' WHEN rn % 4 = 2 THEN 'RDP' ELSE 'API' END as access_method,
    CASE WHEN rn % 15 = 0 THEN 'Timeout' ELSE 'Completed' END as session_status,
    (20 + (rn % 100)) as commands_executed
FROM (
    SELECT @row := @row + 1 as rn
    FROM (SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) t1,
         (SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7) t2,
         (SELECT @row := 0) r
    LIMIT 70
) numbers
WHERE (40 + rn) <= 130;

-- =====================================================
-- 5. INSERT SECURITY INCIDENTS (25 incidents)
-- =====================================================

INSERT INTO Security_Incidents (session_id, user_id, account_id, incident_date, incident_type, severity, description, incident_status, resolution_date, resolved_by) VALUES
-- Critical recent incidents
(22, 25, 1, '2024-10-15 10:10:00', 'Unauthorized Access', 'Critical', 'Attempted access to production database from unauthorized location with suspicious activity patterns', 'Closed', '2024-10-15 14:30:00', 1),
(NULL, 27, 4, '2024-11-17 14:05:00', 'Policy Violation', 'High', 'Request for extended access hours without proper approval chain', 'Closed', '2024-11-17 15:00:00', 1),
(NULL, 14, 29, '2024-11-16 10:05:00', 'Policy Violation', 'Medium', 'Insufficient business justification provided for cloud administrator access', 'Closed', '2024-11-16 11:00:00', 1),

-- Suspicious activity incidents
(30, 7, 1, '2024-10-28 12:15:00', 'Suspicious Activity', 'Medium', 'Session timeout - user remained connected beyond approved time window', 'Closed', '2024-10-28 13:00:00', 1),
(NULL, 27, NULL, '2024-11-10 16:30:00', 'Failed Login', 'Low', 'Multiple failed login attempts detected from user account', 'Closed', '2024-11-10 17:00:00', 4),
(15, 9, 7, '2024-11-15 11:30:00', 'Suspicious Activity', 'Medium', 'Unusual command execution pattern detected during backup verification session', 'Investigating', NULL, NULL),

-- Password-related incidents
(NULL, NULL, 10, '2024-09-25 10:00:00', 'Password Issue', 'High', 'Password for staging web server not changed for 60+ days - compliance violation', 'Closed', '2024-09-25 14:00:00', 2),
(NULL, NULL, 13, '2024-08-20 10:00:00', 'Password Issue', 'Medium', 'Development database admin password complexity below required standards', 'Closed', '2024-08-20 15:00:00', 3),

-- Compliance breaches
(NULL, NULL, 1, '2024-10-01 09:00:00', 'Compliance Breach', 'High', 'PCI-DSS compliance audit identified password rotation delay for production database', 'Closed', '2024-10-02 10:00:00', 1),
(NULL, NULL, 4, '2024-09-15 09:00:00', 'Compliance Breach', 'High', 'HIPAA audit identified missing MFA enforcement for SQL Server admin account', 'Closed', '2024-09-16 11:00:00', 1),
(NULL, NULL, 3, '2024-09-01 09:00:00', 'Compliance Breach', 'Critical', 'SOX compliance violation - ERP admin access logging gaps identified', 'Closed', '2024-09-03 14:00:00', 1),

-- Recent open incidents
(1, 7, 1, '2024-11-19 10:30:00', 'Suspicious Activity', 'Low', 'Higher than normal command execution rate during current session', 'Open', NULL, NULL),
(2, 8, 4, '2024-11-19 09:45:00', 'Policy Violation', 'Low', 'Session extended beyond initially requested duration', 'Open', NULL, NULL),
(NULL, 20, 1, '2024-11-19 11:05:00', 'Failed Login', 'Low', 'Failed login attempt before successful access', 'Investigating', NULL, NULL),

-- October incidents
(35, 8, 4, '2024-10-23 09:30:00', 'Suspicious Activity', 'Medium', 'Elevated privilege commands executed outside normal working hours', 'Closed', '2024-10-23 15:00:00', 1),
(NULL, NULL, 21, '2024-10-10 10:00:00', 'Password Issue', 'Medium', 'Financial server admin password not meeting new complexity requirements', 'Closed', '2024-10-10 14:00:00', 3),
(37, 19, 21, '2024-10-21 09:50:00', 'Policy Violation', 'Low', 'Accessed financial reports without documented approval in ticket', 'Closed', '2024-10-21 16:00:00', 3),

-- September incidents
(NULL, 27, NULL, '2024-09-20 08:30:00', 'Failed Login', 'Medium', 'Five consecutive failed login attempts from user account', 'Closed', '2024-09-20 10:00:00', 4),
(NULL, NULL, 6, '2024-09-05 07:00:00', 'Compliance Breach', 'Critical', 'PCI-DSS audit - payment gateway service account password unchanged for 90+ days', 'Closed', '2024-09-06 12:00:00', 1),
(NULL, 25, NULL, '2024-09-12 14:00:00', 'Policy Violation', 'High', 'Attempted to share privileged credentials via unencrypted email', 'Closed', '2024-09-12 17:00:00', 1),

-- Additional incidents for analysis
(NULL, NULL, 29, '2024-08-15 09:00:00', 'Password Issue', 'High', 'AWS root account password complexity does not meet updated security standards', 'Closed', '2024-08-16 10:00:00', 1),
(NULL, 18, 16, '2024-11-16 12:00:00', 'Suspicious Activity', 'Low', 'QA database accessed from unusual workstation', 'Closed', '2024-11-16 14:00:00', 4),
(NULL, NULL, 28, '2024-11-05 10:00:00', 'Compliance Breach', 'Medium', 'Firewall admin access logs incomplete for previous month - audit finding', 'Investigating', NULL, NULL),
(11, 20, 6, '2024-11-17 12:30:00', 'Suspicious Activity', 'Medium', 'Payment API service account showing unusual transaction patterns', 'Investigating', NULL, NULL),
(NULL, 27, NULL, '2024-11-08 09:00:00', 'Failed Login', 'Medium', 'Multiple failed authentication attempts detected', 'Closed', '2024-11-08 11:00:00', 4);

-- =====================================================
-- 6. INSERT AUDIT LOGS (200 entries)
-- =====================================================

-- Recent audit entries
INSERT INTO Audit_Logs (timestamp, user_id, account_id, action_type, action_details, source_ip, result) VALUES
('2024-11-19 07:00:00', 7, 1, 'Login', 'User logged into production database for performance tuning', '192.168.1.50', 'Success'),
('2024-11-19 07:30:00', 7, 1, 'Query Execution', 'Executed index rebuild on CUSTOMER_TRANSACTIONS table', '192.168.1.50', 'Success'),
('2024-11-19 08:45:00', 7, 1, 'Query Execution', 'Updated database statistics for query optimization', '192.168.1.50', 'Success'),
('2024-11-19 06:30:00', 8, 4, 'Login', 'Emergency login for SQL Server security patch', '192.168.1.51', 'Success'),
('2024-11-19 06:45:00', 8, 4, 'Configuration Change', 'Applied security patch KB5028997 to SQL Server instance', '192.168.1.51', 'Success'),
('2024-11-19 08:00:00', 10, 2, 'Login', 'Accessed web server for SSL certificate update', '192.168.1.52', 'Success'),
('2024-11-19 08:20:00', 10, 2, 'Configuration Change', 'Updated SSL certificates on web server', '192.168.1.52', 'Success'),
('2024-11-19 09:00:00', 4, 28, 'Login', 'Security audit session initiated', '192.168.1.48', 'Success'),
('2024-11-19 09:15:00', 4, 28, 'Configuration Change', 'Reviewed and updated firewall rules for compliance', '192.168.1.48', 'Success'),
('2024-11-19 10:30:00', 11, 5, 'Logout', 'Application deployment session completed', '192.168.1.53', 'Success'),

-- Failed attempts and warnings
('2024-11-19 11:00:00', 20, 1, 'Login', 'Failed login attempt - incorrect password', '192.168.1.59', 'Failure'),
('2024-11-19 11:02:00', 20, 1, 'Login', 'Successful login after password reset', '192.168.1.59', 'Success'),
('2024-10-15 10:00:00', 25, 1, 'Login', 'Suspicious login attempt from external IP', '203.0.113.45', 'Failure'),
('2024-10-15 10:05:00', 25, 1, 'Login', 'Multiple failed authentication attempts', '203.0.113.45', 'Failure'),
('2024-10-15 10:10:00', 25, 1, 'Login', 'Account locked due to failed attempts', '203.0.113.45', 'Failure'),

-- Password changes
('2024-11-15 09:00:00', 2, 1, 'Password Change', 'Scheduled password rotation for production database', '192.168.1.45', 'Success'),
('2024-11-10 14:00:00', 2, 2, 'Password Change', 'Password updated for web server admin account', '192.168.1.45', 'Success'),
('2024-11-08 10:00:00', 3, 19, 'Password Change', 'Financial database password rotation', '192.168.1.46', 'Success'),
('2024-11-05 16:00:00', 2, 5, 'Password Change', 'Application server password updated per policy', '192.168.1.45', 'Success'),
('2024-10-30 12:00:00', 2, 23, 'Password Change', 'ETL service account password rotation', '192.168.1.45', 'Success'),

-- Access grants and revocations
('2024-11-19 07:15:00', 3, 1, 'Access Grant', 'Approved emergency access for database tuning', '192.168.1.46', 'Success'),
('2024-11-19 06:45:00', 3, 4, 'Access Grant', 'Critical access granted for security patch', '192.168.1.46', 'Success'),
('2024-11-19 08:10:00', 2, 2, 'Access Grant', 'Access granted for SSL certificate update', '192.168.1.45', 'Success'),
('2024-11-18 16:45:00', 1, 3, 'Access Revoke', 'Access automatically revoked after session completion', '192.168.1.44', 'Success'),
('2024-11-17 09:50:00', 3, 21, 'Access Revoke', 'Financial system access revoked after month-end closing', '192.168.1.46', 'Success');

-- Generate more audit log entries for trend analysis
INSERT INTO Audit_Logs (timestamp, user_id, account_id, action_type, action_details, source_ip, result)
SELECT 
    DATE_ADD('2024-09-01', INTERVAL (rn * 6) HOUR) as timestamp,
    (7 + (rn % 15)) as user_id,
    (1 + (rn % 30)) as account_id,
    CASE 
        WHEN rn % 6 = 0 THEN 'Login'
        WHEN rn % 6 = 1 THEN 'Query Execution'
        WHEN rn % 6 = 2 THEN 'Configuration Change'
        WHEN rn % 6 = 3 THEN 'Logout'
        WHEN rn % 6 = 4 THEN 'Access Grant'
        ELSE 'Access Revoke'
    END as action_type,
    CONCAT('Automated action log entry #', rn) as action_details,
    CONCAT('192.168.1.', (50 + (rn % 20))) as source_ip,
    CASE WHEN rn % 25 = 0 THEN 'Failure' WHEN rn % 20 = 0 THEN 'Warning' ELSE 'Success' END as result
FROM (
    SELECT @row := @row + 1 as rn
    FROM (SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) t1,
         (SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) t2,
         (SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5) t3,
         (SELECT @row := 0) r
    LIMIT 170
) numbers;

-- =====================================================
-- 7. INSERT COMPLIANCE REPORTS (12 reports)
-- =====================================================

INSERT INTO Compliance_Reports (report_date, report_type, compliance_framework, total_accounts_reviewed, compliant_accounts, non_compliant_accounts, compliance_percentage, critical_findings, report_status, created_by) VALUES
-- Recent reports
('2024-11-01', 'Monthly Compliance Audit', 'PCI-DSS', 15, 13, 2, 86.67, 1, 'Final', 1),
('2024-11-01', 'Monthly Compliance Audit', 'SOX', 12, 11, 1, 91.67, 0, 'Final', 1),
('2024-11-01', 'Monthly Compliance Audit', 'HIPAA', 8, 7, 1, 87.50, 1, 'Final', 6),
('2024-10-01', 'Monthly Compliance Audit', 'PCI-DSS', 15, 12, 3, 80.00, 2, 'Final', 1),
('2024-10-01', 'Monthly Compliance Audit', 'SOX', 12, 10, 2, 83.33, 1, 'Final', 1),
('2024-10-01', 'Monthly Compliance Audit', 'HIPAA', 8, 6, 2, 75.00, 2, 'Final', 6),
('2024-09-01', 'Monthly Compliance Audit', 'PCI-DSS', 15, 11, 4, 73.33, 3, 'Final', 1),
('2024-09-01', 'Monthly Compliance Audit', 'SOX', 12, 9, 3, 75.00, 2, 'Final', 1),
('2024-09-01', 'Monthly Compliance Audit', 'HIPAA', 8, 5, 3, 62.50, 3, 'Final', 6),
('2024-11-15', 'Quarterly Security Review', 'Multi-Framework', 40, 35, 5, 87.50, 2, 'Draft', 1),
('2024-08-01', 'Monthly Compliance Audit', 'PCI-DSS', 15, 10, 5, 66.67, 4, 'Final', 1),
('2024-08-01', 'Monthly Compliance Audit', 'SOX', 12, 8, 4, 66.67, 3, 'Final', 1);

-- =====================================================
-- 8. INSERT PASSWORD HISTORY (60 entries)
-- =====================================================

INSERT INTO Password_History (account_id, changed_date, changed_by, change_reason, password_strength_score) VALUES
-- Recent password changes
(1, '2024-11-15 09:00:00', 2, 'Scheduled Rotation', 95),
(2, '2024-11-10 14:00:00', 2, 'Scheduled Rotation', 98),
(3, '2024-11-01 11:00:00', 2, 'Scheduled Rotation', 97),
(4, '2024-10-25 09:00:00', 3, 'Scheduled Rotation', 96),
(5, '2024-11-05 16:00:00', 2, 'Scheduled Rotation', 94),
(6, '2024-10-18 10:00:00', 1, 'Security Incident', 99),
(19, '2024-11-08 10:00:00', 3, 'Scheduled Rotation', 97),
(20, '2024-11-10 14:00:00', 3, 'Compliance', 98),
(21, '2024-10-28 11:00:00', 3, 'Scheduled Rotation', 95),
(22, '2024-11-02 08:00:00', 2, 'Scheduled Rotation', 93),
(28, '2024-11-06 14:00:00', 1, 'Security Incident', 99),
(29, '2024-11-07 11:00:00', 1, 'Compliance', 98),

-- Historical changes for compliance tracking
(1, '2024-08-15 09:00:00', 2, 'Scheduled Rotation', 94),
(1, '2024-05-15 09:00:00', 2, 'Scheduled Rotation', 92),
(1, '2024-02-15 09:00:00', 2, 'Scheduled Rotation', 91),
(2, '2024-08-10 14:00:00', 2, 'Scheduled Rotation', 95),
(2, '2024-05-10 14:00:00', 2, 'Scheduled Rotation', 93),
(3, '2024-08-01 11:00:00', 2, 'Scheduled Rotation', 96),
(3, '2024-05-01 11:00:00', 2, 'Scheduled Rotation', 94),
(4, '2024-07-25 09:00:00', 3, 'Scheduled Rotation', 95),
(4, '2024-04-25 09:00:00', 3, 'Scheduled Rotation', 93),
(5, '2024-08-05 16:00:00', 2, 'Scheduled Rotation', 93),
(5, '2024-05-05 16:00:00', 2, 'Scheduled Rotation', 91),
(6, '2024-07-18 10:00:00', 1, 'Scheduled Rotation', 97),
(7, '2024-10-22 12:00:00', 2, 'Scheduled Rotation', 92),
(7, '2024-07-22 12:00:00', 2, 'Scheduled Rotation', 90),
(8, '2024-11-03 08:00:00', 2, 'Scheduled Rotation', 91),
(8, '2024-08-03 08:00:00', 2, 'Scheduled Rotation', 89);

-- Generate more password history for analysis
INSERT INTO Password_History (account_id, changed_date, changed_by, change_reason, password_strength_score)
SELECT 
    (1 + (rn % 30)) as account_id,
    DATE_SUB('2024-11-01', INTERVAL (rn * 30) DAY) as changed_date,
    (1 + (rn % 3)) as changed_by,
    'Scheduled Rotation' as change_reason,
    (85 + (rn % 15)) as password_strength_score
FROM (
    SELECT @row := @row + 1 as rn
    FROM (SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) t1,
         (SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4) t2,
         (SELECT @row := 0) r
    LIMIT 35
) numbers
WHERE DATE_SUB('2024-11-01', INTERVAL (rn * 30) DAY) >= '2024-01-01';

-- =====================================================
-- VERIFICATION QUERIES
-- =====================================================

SELECT 'Data insertion completed successfully!' as Status;

SELECT 
    'Users' as Table_Name, 
    COUNT(*) as Record_Count 
FROM Users
UNION ALL
SELECT 'Privileged_Accounts', COUNT(*) FROM Privileged_Accounts
UNION ALL
SELECT 'Access_Requests', COUNT(*) FROM Access_Requests
UNION ALL
SELECT 'Access_Sessions', COUNT(*) FROM Access_Sessions
UNION ALL
SELECT 'Security_Incidents', COUNT(*) FROM Security_Incidents
UNION ALL
SELECT 'Audit_Logs', COUNT(*) FROM Audit_Logs
UNION ALL
SELECT 'Compliance_Reports', COUNT(*) FROM Compliance_Reports
UNION ALL
SELECT 'Password_History', COUNT(*) FROM Password_History;