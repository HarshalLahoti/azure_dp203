SELECT
    Records.ArrayValue.category AS Category,
    Records.ArrayValue.operationName AS OperationName,
    Records.ArrayValue.statusText AS StatusText,
    Records.ArrayValue.properties.objectkey AS ObjectKey,
    Records.ArrayValue.[identity].type AS IdentityType,
    Records.ArrayValue.[identity].tokenHash AS TokenHash
INTO
    [BlobDiagnostics]
FROM
    [blobhub] bh
CROSS APPLY GetArrayElements(bh.records) AS Records