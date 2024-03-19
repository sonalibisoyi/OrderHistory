-- ANALYSIS TO FIND ORDERS ACCORDING TO REASONS FOR FAILURE


SELECT *
FROM [dbo].[data offers]

SELECT *
FROM [dbo].[data_orders]

-- changing order_number to order_id

EXEC sp_rename '[dbo].[data_orders].[order_number]', 'order_id', 'COLUMN';

-- creating a view for the failure and rejection

CREATE VIEW dbo.FailureAndRejectionView AS
SELECT
    o.order_datetime,
    o.order_id,
    o.whether_driver_has_been_assigned,
    CASE
        WHEN o.whether_driver_has_been_assigned = 1 THEN 'driver already assigned'
        WHEN o.whether_driver_has_been_assigned = 0 THEN 'driver not assigned'
        ELSE 'Other'
    END AS failure_categories,
    r.order_status_key,
    CASE 
        WHEN r.order_status_key = 4 THEN 'Client Cancelled'
        WHEN r.order_status_key = 9 THEN 'System Cancelled'
        ELSE 'Other'
    END AS reason_for_order_rejection
FROM
    [dbo].[data_orders] o
JOIN
    [dbo].[data_orders] r ON o.order_datetime = r.order_datetime AND o.order_id = r.order_id;
 

 SELECT *
 FROM [dbo].[FailureAndRejectionView]

-- ANALYSIS AND EXPLORATION FOR INSIGHTS

CREATE VIEW dbo.FailureAnalysisView AS
SELECT
    COALESCE(oc.failure_categories, cc.failure_categories) AS failure_categories,
    COALESCE(rc.reason_for_order_rejection, cc.reason_for_order_rejection) AS reason_for_order_rejection,
    COALESCE(oc.order_count, 0) AS order_count_by_failure,
    COALESCE(rc.order_count, 0) AS order_count_by_rejection,
    COALESCE(cc.order_count, 0) AS order_count_by_failure_and_rejection,
    COALESCE(oc.order_percentage, 0) AS order_percentage_by_failure
FROM
    (
        -- Count of orders by failure category
        SELECT
            failure_categories,
            COUNT(*) AS order_count,
            CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () AS DECIMAL(5,2)) AS order_percentage
        FROM dbo.FailureAndRejectionView
        GROUP BY failure_categories
    ) oc
FULL OUTER JOIN
    (
        -- Count of orders by reason for rejection
        SELECT
            reason_for_order_rejection,
            COUNT(*) AS order_count
        FROM dbo.FailureAndRejectionView
        GROUP BY reason_for_order_rejection
    ) rc ON oc.failure_categories = rc.reason_for_order_rejection
FULL OUTER JOIN
    (
        -- Count of Orders by failure categories and reason for rejection
        SELECT
            failure_categories,
            reason_for_order_rejection,
            COUNT(*) AS order_count
        FROM dbo.FailureAndRejectionView
        GROUP BY failure_categories, reason_for_order_rejection
    ) cc ON oc.failure_categories = cc.failure_categories AND rc.reason_for_order_rejection = cc.reason_for_order_rejection;

SELECT *
FROM [dbo].[FailureAnalysisView]

