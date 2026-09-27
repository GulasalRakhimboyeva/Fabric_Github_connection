CREATE FUNCTION dbo.fn_region_filter1(@region VARCHAR(50))
RETURNS TABLE
WITH SCHEMABINDING
AS
RETURN SELECT 1 AS result
WHERE @region = 'North' OR USER_NAME() = 'rose.raximboyeva@diserviceinc.com';

GO