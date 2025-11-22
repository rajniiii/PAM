-- =====================================================
-- ANALYTICAL QUERIES FOR POWER BI DASHBOARDS
-- Optimized queries
-- =====================================================

USE data_PAM;

-- =====================================================
-- DASHBOARD 1: EXECUTIVE SUMMARY KPIs
-- =====================================================

-- Query 1.1: Key Metrics Overview (Single Row for KPI Cards)
SELECT 
    (SELECT COUNT(*) FROM Users WHERE account_status = 'Active') as Active_Users,
    (SELECT COUNT(*) FROM Privileged_Accounts WHERE is_critical = TRUE) as Critical_Accounts,
    (SELECT COUNT(*) FROM Access_Requests WHERE request_status = 'Pending') as Pending_Requests,
    (SELECT COUNT(*) FROM Access_Sessions WHERE session_status = 'Active') as Active_Sessions,
    (SELECT COUNT(*) FROM Security_Incidents WHERE incident_status IN ('Open', 'Investigating')) as Open_Incidents,
    (SELECT ROUND(AVG(compliance_percentage), 2) 
     FROM Compliance_Reports 
     WHERE report_date >= DATE_SUB(CURRENT_DATE, INTERVAL 3 MONTH)) as Avg_Compliance_Rate;

-- Query 1.2: Monthly Access Request Trends
SELECT 
    DATE_FORMAT(request_date, '%Y-%m') as Month,
    COUNT(*) as Total_Requests,
    SUM(CASE WHEN request_status = 'Approved' THEN 1 ELSE 0 END) as Approved,
    SUM(CASE WHEN request_status = 'Rejected' THEN 1 ELSE 0 END) as Rejected,
    SUM(CASE WHEN request_status = 'Pending' THEN 1 ELSE 0 END) as Pending,
    ROUND(SUM(CASE WHEN request_status = 'Approved' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as Approval_Rate
FROM Access_Requests
WHERE request_date >= DATE_SUB(CURRENT_DATE, INTERVAL 6 MONTH)
GROUP BY DATE_FORMAT(request_date, '%Y-%m')
ORDER BY Month;

-- Query 1.3: Department-wise Access Activity
SELECT 
    u.department as Department,
    COUNT(DISTINCT ar.user_id) as Active_Users,
    COUNT(ar.request_id) as Total_Requests,
    SUM(CASE WHEN ar.request_status = 'Approved' THEN 1 ELSE 0 END) as Approved_Requests,
    COUNT(DISTINCT ass.session_id) as Total_Sessions,
    ROUND(AVG(ass.session_duration_minutes), 2) as Avg_Session_Duration,
    SUM(si.incident_id IS NOT NULL) as Incident_Count
FROM Users u
LEFT JOIN Access_Requests ar ON u.user_id = ar.user_id
LEFT JOIN Access_Sessions ass ON ar.request_id = ass.request_id
LEFT JOIN Security_Incidents si ON u.user_id = si.user_id
WHERE ar.request_date >= DATE_SUB(CURRENT_DATE, INTERVAL 3 MONTH)
GROUP BY u.department
ORDER BY Total_Requests DESC;

-- =====================================================
-- DASHBOARD 2: ACCESS REQUEST ANALYSIS
-- =====================================================

-- Query 2.1: Request Status Distribution with Time Metrics
SELECT 
    request_status as Status,
    COUNT(*) as Request_Count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Access_Requests), 2) as Percentage,
    ROUND(AVG(TIMESTAMPDIFF(MINUTE, request_date, approved_date)), 2) as Avg_Approval_Time_Minutes,
    AVG(requested_duration_hours) as Avg_Requested_Duration
FROM Access_Requests
WHERE request_date >= DATE_SUB(CURRENT_DATE, INTERVAL 3 MONTH)
GROUP BY request_status
ORDER BY Request_Count DESC;

-- Query 2.2: Priority Level Analysis
SELECT 
    priority_level as Priority,
    COUNT(*) as Total_Requests,
    SUM(CASE WHEN request_status = 'Approved' THEN 1 ELSE 0 END) as Approved,
    SUM(CASE WHEN request_status = 'Rejected' THEN 1 ELSE 0 END) as Rejected,
    ROUND(AVG(TIMESTAMPDIFF(MINUTE, request_date, COALESCE(approved_date, CURRENT_TIMESTAMP))), 2) as Avg_Processing_Time,
    ROUND(SUM(CASE WHEN request_status = 'Approved' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as Approval_Rate
FROM Access_Requests
WHERE request_date >= DATE_SUB(CURRENT_DATE, INTERVAL 3 MONTH)
GROUP BY priority_level
ORDER BY FIELD(priority_level, 'Critical', 'High', 'Medium', 'Low');

-- Query 2.3: Top Requesters and Their Activity
SELECT 
    u.username as Username,
    u.full_name as Full_Name,
    u.department as Department,
    COUNT(ar.request_id) as Total_Requests,
    SUM(CASE WHEN ar.request_status = 'Approved' THEN 1 ELSE 0 END) as Approved,
    SUM(CASE WHEN ar.request_status = 'Rejected' THEN 1 ELSE 0 END) as Rejected,
    ROUND(SUM(CASE WHEN ar.request_status = 'Approved' THEN 1 ELSE 0 END) * 100.0 / COUNT(ar.request_id), 2) as Approval_Rate,
    u.risk_score as Risk_Score
FROM Users u
INNER JOIN Access_Requests ar ON u.user_id = ar.user_id
WHERE ar.request_date >= DATE_SUB(CURRENT_DATE, INTERVAL 3 MONTH)
GROUP BY u.user_id, u.username, u.full_name, u.department, u.risk_score
ORDER BY Total_Requests DESC
LIMIT 20;

-- Query 2.4: Most Requested Accounts
SELECT 
    pa.account_name as Account_Name,
    pa.account_type as Type,
    pa.system_name as System,
    pa.environment as Environment,
    pa.is_critical as Is_Critical,
    COUNT(ar.request_id) as Request_Count,
    COUNT(DISTINCT ar.user_id) as Unique_Requesters,
    ROUND(AVG(ar.requested_duration_hours), 2) as Avg_Duration_Hours
FROM Privileged_Accounts pa
INNER JOIN Access_Requests ar ON pa.account_id = ar.account_id
WHERE ar.request_date >= DATE_SUB(CURRENT_DATE, INTERVAL 3 MONTH)
GROUP BY pa.account_id, pa.account_name, pa.account_type, pa.system_name, pa.environment, pa.is_critical
ORDER BY Request_Count DESC
LIMIT 15;

-- =====================================================
-- DASHBOARD 3: SESSION MONITORING
-- =====================================================

-- Query 3.1: Session Activity Over Time (Daily)
SELECT 
    DATE(session_start) as Session_Date,
    COUNT(*) as Total_Sessions,
    SUM(CASE WHEN session_status = 'Active' THEN 1 ELSE 0 END) as Active,
    SUM(CASE WHEN session_status = 'Completed' THEN 1 ELSE 0 END) as Completed,
    SUM(CASE WHEN session_status = 'Timeout' THEN 1 ELSE 0 END) as Timeout,
    SUM(CASE WHEN session_status = 'Terminated' THEN 1 ELSE 0 END) as Terminated,
    ROUND(AVG(session_duration_minutes), 2) as Avg_Duration_Minutes,
    SUM(commands_executed) as Total_Commands_Executed
FROM Access_Sessions
WHERE session_start >= DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY)
GROUP BY DATE(session_start)
ORDER BY Session_Date DESC;

-- Query 3.2: Access Method Distribution
SELECT 
    access_method as Access_Method,
    COUNT(*) as Session_Count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Access_Sessions 
                               WHERE session_start >= DATE_SUB(CURRENT_DATE, INTERVAL 3 MONTH)), 2) as Percentage,
    ROUND(AVG(session_duration_minutes), 2) as Avg_Duration,
    ROUND(AVG(commands_executed), 2) as Avg_Commands
FROM Access_Sessions
WHERE session_start >= DATE_SUB(CURRENT_DATE, INTERVAL 3 MONTH)
GROUP BY access_method
ORDER BY Session_Count DESC;

-- Query 3.3: Long Running Sessions Analysis
SELECT 
    ass.session_id,
    u.username as Username,
    u.department as Department,
    pa.account_name as Account,
    pa.environment as Environment,
    ass.session_start as Start_Time,
    COALESCE(ass.session_end, CURRENT_TIMESTAMP) as End_Time,
    COALESCE(ass.session_duration_minutes, 
             TIMESTAMPDIFF(MINUTE, ass.session_start, CURRENT_TIMESTAMP)) as Duration_Minutes,
    ass.commands_executed as Commands,
    ass.session_status as Status
FROM Access_Sessions ass
INNER JOIN Users u ON ass.user_id = u.user_id
INNER JOIN Privileged_Accounts pa ON ass.account_id = pa.account_id
WHERE ass.session_start >= DATE_SUB(CURRENT_DATE, INTERVAL 7 DAY)
    AND (ass.session_duration_minutes > 180 OR 
         (ass.session_status = 'Active' AND TIMESTAMPDIFF(MINUTE, ass.session_start, CURRENT_TIMESTAMP) > 180))
ORDER BY Duration_Minutes DESC;

-- Query 3.4: User Session Statistics
SELECT 
    u.username as Username,
    u.full_name as Full_Name,
    u.department as Department,
    COUNT(ass.session_id) as Total_Sessions,
    ROUND(AVG(ass.session_duration_minutes), 2) as Avg_Duration,
    MAX(ass.session_duration_minutes) as Max_Duration,
    SUM(ass.commands_executed) as Total_Commands,
    ROUND(AVG(ass.commands_executed), 2) as Avg_Commands_Per_Session
FROM Users u
INNER JOIN Access_Sessions ass ON u.user_id = ass.user_id
WHERE ass.session_start >= DATE_SUB(CURRENT_DATE, INTERVAL 3 MONTH)
GROUP BY u.user_id, u.username, u.full_name, u.department
HAVING COUNT(ass.session_id) >= 5
ORDER BY Total_Sessions DESC
LIMIT 20;

-- =====================================================
-- DASHBOARD 4: SECURITY & COMPLIANCE
-- =====================================================

-- Query 4.1: Security Incidents Overview
SELECT 
    incident_type as Incident_Type,
    severity as Severity,
    COUNT(*) as Incident_Count,
    SUM(CASE WHEN incident_status = 'Open' THEN 1 ELSE 0 END) as Open,
    SUM(CASE WHEN incident_status = 'Investigating' THEN 1 ELSE 0 END) as Investigating,
    SUM(CASE WHEN incident_status = 'Resolved' THEN 1 ELSE 0 END) as Resolved,
    SUM(CASE WHEN incident_status = 'Closed' THEN 1 ELSE 0 END) as Closed,
    ROUND(AVG(TIMESTAMPDIFF(HOUR, incident_date, COALESCE(resolution_date, CURRENT_TIMESTAMP))), 2) as Avg_Resolution_Hours
FROM Security_Incidents
WHERE incident_date >= DATE_SUB(CURRENT_DATE, INTERVAL 3 MONTH)
GROUP BY incident_type, severity
ORDER BY FIELD(severity, 'Critical', 'High', 'Medium', 'Low'), Incident_Count DESC;

-- Query 4.2: Incident Trend Analysis (Weekly)
SELECT 
    DATE_FORMAT(incident_date, '%Y-Week %v') as Week,
    COUNT(*) as Total_Incidents,
    SUM(CASE WHEN severity = 'Critical' THEN 1 ELSE 0 END) as Critical,
    SUM(CASE WHEN severity = 'High' THEN 1 ELSE 0 END) as High,
    SUM(CASE WHEN severity = 'Medium' THEN 1 ELSE 0 END) as Medium,
    SUM(CASE WHEN severity = 'Low' THEN 1 ELSE 0 END) as Low,
    ROUND(AVG(TIMESTAMPDIFF(HOUR, incident_date, COALESCE(resolution_date, CURRENT_TIMESTAMP))), 2) as Avg_Resolution_Hours
FROM Security_Incidents
WHERE incident_date >= DATE_SUB(CURRENT_DATE, INTERVAL 12 WEEK)
GROUP BY DATE_FORMAT(incident_date, '%Y-Week %v')
ORDER BY Week DESC;

-- Query 4.3: Compliance Trends
SELECT 
    DATE_FORMAT(report_date, '%Y-%m') as Month,
    compliance_framework as Framework,
    total_accounts_reviewed as Total_Accounts,
    compliant_accounts as Compliant,
    non_compliant_accounts as Non_Compliant,
    compliance_percentage as Compliance_Rate,
    critical_findings as Critical_Findings
FROM Compliance_Reports
WHERE report_date >= DATE_SUB(CURRENT_DATE, INTERVAL 6 MONTH)
    AND report_status = 'Final'
ORDER BY report_date DESC, compliance_framework;

-- Query 4.4: High-Risk Users
SELECT 
    u.username as Username,
    u.full_name as Full_Name,
    u.department as Department,
    u.risk_score as Risk_Score,
    COUNT(DISTINCT ar.request_id) as Total_Requests,
    COUNT(DISTINCT si.incident_id) as Incident_Count,
    u.last_login as Last_Login,
    u.account_status as Status
FROM Users u
LEFT JOIN Access_Requests ar ON u.user_id = ar.user_id 
    AND ar.request_date >= DATE_SUB(CURRENT_DATE, INTERVAL 3 MONTH)
LEFT JOIN Security_Incidents si ON u.user_id = si.user_id 
    AND si.incident_date >= DATE_SUB(CURRENT_DATE, INTERVAL 3 MONTH)
WHERE u.risk_score >= 0.20 OR u.account_status IN ('Suspended', 'Inactive')
GROUP BY u.user_id, u.username, u.full_name, u.department, u.risk_score, u.last_login, u.account_status
ORDER BY u.risk_score DESC, Incident_Count DESC;

-- =====================================================
-- DASHBOARD 5: PRIVILEGED ACCOUNT MANAGEMENT
-- =====================================================

-- Query 5.1: Account Type Distribution
SELECT 
    account_type as Type,
    environment as Environment,
    COUNT(*) as Account_Count,
    SUM(CASE WHEN is_critical = TRUE THEN 1 ELSE 0 END) as Critical_Accounts,
    AVG(DATEDIFF(CURRENT_DATE, password_last_changed)) as Avg_Days_Since_Password_Change,
    COUNT(DISTINCT ar.request_id) as Recent_Access_Requests
FROM Privileged_Accounts pa
LEFT JOIN Access_Requests ar ON pa.account_id = ar.account_id 
    AND ar.request_date >= DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY)
GROUP BY account_type, environment
ORDER BY Account_Count DESC;

-- Query 5.2: Password Rotation Status
SELECT 
    pa.account_name as Account_Name,
    pa.account_type as Type,
    pa.system_name as System,
    pa.environment as Environment,
    pa.is_critical as Is_Critical,
    pa.compliance_category as Compliance,
    pa.password_last_changed as Last_Changed,
    DATEDIFF(CURRENT_DATE, pa.password_last_changed) as Days_Since_Change,
    CASE 
        WHEN DATEDIFF(CURRENT_DATE, pa.password_last_changed) > 90 THEN 'Overdue'
        WHEN DATEDIFF(CURRENT_DATE, pa.password_last_changed) > 75 THEN 'Warning'
        ELSE 'Compliant'
    END as Rotation_Status,
    ph.password_strength_score as Current_Strength
FROM Privileged_Accounts pa
LEFT JOIN (
    SELECT account_id, password_strength_score,
           ROW_NUMBER() OVER (PARTITION BY account_id ORDER BY changed_date DESC) as rn
    FROM Password_History
) ph ON pa.account_id = ph.account_id AND ph.rn = 1
WHERE pa.environment = 'Production'
ORDER BY Days_Since_Change DESC;

-- Query 5.3: Account Access Frequency
SELECT 
    pa.account_name as Account_Name,
    pa.account_type as Type,
    pa.environment as Environment,
    COUNT(DISTINCT ass.session_id) as Session_Count_30d,
    COUNT(DISTINCT ass.user_id) as Unique_Users_30d,
    MAX(ass.session_start) as Last_Accessed,
    DATEDIFF(CURRENT_DATE, MAX(ass.session_start)) as Days_Since_Last_Access,
    CASE 
        WHEN MAX(ass.session_start) IS NULL THEN 'Never Used'
        WHEN DATEDIFF(CURRENT_DATE, MAX(ass.session_start)) > 90 THEN 'Inactive'
        WHEN DATEDIFF(CURRENT_DATE, MAX(ass.session_start)) > 30 THEN 'Low Activity'
        ELSE 'Active'
    END as Usage_Status
FROM Privileged_Accounts pa
LEFT JOIN Access_Sessions ass ON pa.account_id = ass.account_id 
    AND ass.session_start >= DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY)
GROUP BY pa.account_id, pa.account_name, pa.account_type, pa.environment
ORDER BY Session_Count_30d DESC;

-- Query 5.4: Critical Account Monitoring
SELECT 
    pa.account_name as Account,
    pa.system_name as System,
    pa.compliance_category as Compliance_Framework,
    DATEDIFF(CURRENT_DATE, pa.password_last_changed) as Days_Since_Password_Change,
    COUNT(DISTINCT ar.request_id) as Access_Requests_90d,
    COUNT(DISTINCT ass.session_id) as Sessions_30d,
    COUNT(DISTINCT si.incident_id) as Related_Incidents_90d,
    MAX(ass.session_start) as Last_Access_Date
FROM Privileged_Accounts pa
LEFT JOIN Access_Requests ar ON pa.account_id = ar.account_id 
    AND ar.request_date >= DATE_SUB(CURRENT_DATE, INTERVAL 90 DAY)
LEFT JOIN Access_Sessions ass ON pa.account_id = ass.account_id 
    AND ass.session_start >= DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY)
LEFT JOIN Security_Incidents si ON pa.account_id = si.account_id 
    AND si.incident_date >= DATE_SUB(CURRENT_DATE, INTERVAL 90 DAY)
WHERE pa.is_critical = TRUE
GROUP BY pa.account_id, pa.account_name, pa.system_name, pa.compliance_category, pa.password_last_changed
ORDER BY Related_Incidents_90d DESC, Days_Since_Password_Change DESC;

-- =====================================================
-- DASHBOARD 6: AUDIT & ACTIVITY LOGS
-- =====================================================

-- Query 6.1: Daily Audit Activity Summary
SELECT 
    DATE(timestamp) as Activity_Date,
    COUNT(*) as Total_Events,
    SUM(CASE WHEN action_type = 'Login' THEN 1 ELSE 0 END) as Logins,
    SUM(CASE WHEN action_type = 'Logout' THEN 1 ELSE 0 END) as Logouts,
    SUM(CASE WHEN action_type = 'Query Execution' THEN 1 ELSE 0 END) as Query_Executions,
    SUM(CASE WHEN action_type = 'Configuration Change' THEN 1 ELSE 0 END) as Config_Changes,
    SUM(CASE WHEN action_type = 'Password Change' THEN 1 ELSE 0 END) as Password_Changes,
    SUM(CASE WHEN result = 'Failure' THEN 1 ELSE 0 END) as Failures,
    SUM(CASE WHEN result = 'Warning' THEN 1 ELSE 0 END) as Warnings
FROM Audit_Logs
WHERE timestamp >= DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY)
GROUP BY DATE(timestamp)
ORDER BY Activity_Date DESC;

-- Query 6.2: Action Type Distribution
SELECT 
    action_type as Action_Type,
    result as Result,
    COUNT(*) as Event_Count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Audit_Logs 
                               WHERE timestamp >= DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY)), 2) as Percentage
FROM Audit_Logs
WHERE timestamp >= DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY)
GROUP BY action_type, result
ORDER BY Event_Count DESC;

-- Query 6.3: Failed Activities Report
SELECT 
    DATE(al.timestamp) as Date,
    u.username as Username,
    u.department as Department,
    pa.account_name as Account,
    al.action_type as Action,
    al.action_details as Details,
    al.source_ip as IP_Address,
    al.result as Result
FROM Audit_Logs al
INNER JOIN Users u ON al.user_id = u.user_id
LEFT JOIN Privileged_Accounts pa ON al.account_id = pa.account_id
WHERE al.result IN ('Failure', 'Warning')
    AND al.timestamp >= DATE_SUB(CURRENT_DATE, INTERVAL 7 DAY)
ORDER BY al.timestamp DESC
LIMIT 100;

-- Query 6.4: User Activity Heatmap Data (Hour of Day)
SELECT 
    HOUR(timestamp) as Hour_of_Day,
    DAYNAME(timestamp) as Day_of_Week,
    COUNT(*) as Activity_Count,
    COUNT(DISTINCT user_id) as Active_Users
FROM Audit_Logs
WHERE timestamp >= DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY)
    AND result = 'Success'
GROUP BY HOUR(timestamp), DAYNAME(timestamp)
ORDER BY FIELD(Day_of_Week, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'), 
         Hour_of_Day;

-- =====================================================
-- ADVANCED ANALYTICS QUERIES
-- =====================================================

-- Query 7.1: Risk Scoring Matrix
SELECT 
    u.username as Username,
    u.department as Department,
    u.risk_score as Base_Risk_Score,
    COUNT(DISTINCT si.incident_id) as Incident_Count,
    COUNT(DISTINCT CASE WHEN ar.request_status = 'Rejected' THEN ar.request_id END) as Rejected_Requests,
    COUNT(DISTINCT CASE WHEN ass.session_status = 'Timeout' THEN ass.session_id END) as Timeout_Sessions,
    COUNT(DISTINCT CASE WHEN al.result = 'Failure' THEN al.log_id END) as Failed_Activities,
    ROUND(u.risk_score + 
          (COUNT(DISTINCT si.incident_id) * 0.15) + 
          (COUNT(DISTINCT CASE WHEN ar.request_status = 'Rejected' THEN ar.request_id END) * 0.05) +
          (COUNT(DISTINCT CASE WHEN ass.session_status = 'Timeout' THEN ass.session_id END) * 0.08), 2) as Calculated_Risk_Score
FROM Users u
LEFT JOIN Security_Incidents si ON u.user_id = si.user_id 
    AND si.incident_date >= DATE_SUB(CURRENT_DATE, INTERVAL 3 MONTH)
LEFT JOIN Access_Requests ar ON u.user_id = ar.user_id 
    AND ar.request_date >= DATE_SUB(CURRENT_DATE, INTERVAL 3 MONTH)
LEFT JOIN Access_Sessions ass ON u.user_id = ass.user_id 
    AND ass.session_start >= DATE_SUB(CURRENT_DATE, INTERVAL 3 MONTH)
LEFT JOIN Audit_Logs al ON u.user_id = al.user_id 
    AND al.timestamp >= DATE_SUB(CURRENT_DATE, INTERVAL 3 MONTH)
WHERE u.account_status = 'Active'
GROUP BY u.user_id, u.username, u.department, u.risk_score
HAVING Calculated_Risk_Score > 0.30
ORDER BY Calculated_Risk_Score DESC
LIMIT 25;

-- Query 7.2: Anomaly Detection - Unusual Access Patterns
SELECT 
    u.username as Username,
    pa.account_name as Account,
    COUNT(*) as Access_Count_This_Month,
    avg_access.Avg_Monthly_Access as Historical_Average,
    ROUND(COUNT(*) - avg_access.Avg_Monthly_Access, 2) as Deviation,
    CASE 
        WHEN COUNT(*) > (avg_access.Avg_Monthly_Access * 2) THEN 'High Anomaly'
        WHEN COUNT(*) > (avg_access.Avg_Monthly_Access * 1.5) THEN 'Moderate Anomaly'
        ELSE 'Normal'
    END as Anomaly_Level
FROM Access_Requests ar
INNER JOIN Users u ON ar.user_id = u.user_id
INNER JOIN Privileged_Accounts pa ON ar.account_id = pa.account_id
LEFT JOIN (
    SELECT 
        user_id,
        account_id,
        AVG(monthly_count) as Avg_Monthly_Access
    FROM (
        SELECT 
            user_id,
            account_id,
            DATE_FORMAT(request_date, '%Y-%m') as month,
            COUNT(*) as monthly_count
        FROM Access_Requests
        WHERE request_date >= DATE_SUB(CURRENT_DATE, INTERVAL 6 MONTH)
            AND request_date < DATE_FORMAT(CURRENT_DATE, '%Y-%m-01')
        GROUP BY user_id, account_id, DATE_FORMAT(request_date, '%Y-%m')
    ) monthly_data
    GROUP BY user_id, account_id
) avg_access ON ar.user_id = avg_access.user_id AND ar.account_id = avg_access.account_id
WHERE ar.request_date >= DATE_FORMAT(CURRENT_DATE, '%Y-%m-01')
    AND avg_access.Avg_Monthly_Access > 0
GROUP BY ar.user_id, ar.account_id, u.username, pa.account_name, avg_access.Avg_Monthly_Access
HAVING Anomaly_Level != 'Normal'
ORDER BY Deviation DESC;

-- =====================================================
-- SUCCESS MESSAGE
-- =====================================================
SELECT 'All analytical queries created successfully for Power BI!' as Status;