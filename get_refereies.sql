select TABLE_NAME, COLUMN_NAME from information_schema.key_column_usage where CONSTRAINT_SCHEMA = 'schema' and REFERENCED_TABLE_NAME = 'target';
