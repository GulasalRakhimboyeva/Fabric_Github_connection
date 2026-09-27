-- RETURN SELECT 1 AS result
-- WHERE @region = 'North' OR USER_NAME() = 'rose.raximboyeva@diserviceinc.com';
CREATE FUNCTION dbo.fn_region_filter(@region VARCHAR(50))
RETURNS TABLE
WITH SCHEMABINDING
AS
RETURN
(
    SELECT 1 AS result
    FROM dbo.emp_region_map
    WHERE username = USER_NAME()
      AND region = @region
);

GO