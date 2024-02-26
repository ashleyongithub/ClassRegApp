#!/usr/bin/env bash

echo "Creating database..."
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P P@55w0rd -i schema.sql
echo "Creating SP ClassRegistrationReport..."
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P P@55w0rd -i sp.create.ClassRegistrationReport.sql
