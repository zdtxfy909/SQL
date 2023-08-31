-- SQL에서 한줄 주석 부호(--)
-- HTTP 포트 변경 : 8080 -> 8090
select DBMS_XDB.getHttpport() FROM dual;
select DBMS_XDB.getHttpport() FROM dual;

-- HTTP 포트 8090 으로 변경
exec dbms_xdb.setHttpPort(8090);

select DBMS_XDB.getHttpport() FROM dual;