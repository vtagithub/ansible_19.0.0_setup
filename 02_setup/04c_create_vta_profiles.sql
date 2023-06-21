REM	#######################################################
REM	04c_create_vta_profiles.sql
REM	#######################################################
CREATE PROFILE "INFORMAT_PROFILE"
LIMIT
               COMPOSITE_LIMIT DEFAULT
               CONNECT_TIME DEFAULT
               CPU_PER_CALL DEFAULT
               CPU_PER_SESSION DEFAULT
               FAILED_LOGIN_ATTEMPTS  DEFAULT
               LOGICAL_READS_PER_CALL DEFAULT
               LOGICAL_READS_PER_SESSION  DEFAULT
               PASSWORD_GRACE_TIME  DEFAULT
               PASSWORD_LIFE_TIME 60
               PASSWORD_LOCK_TIME DEFAULT
               PASSWORD_REUSE_MAX DEFAULT
               PASSWORD_REUSE_TIME  DEFAULT
               PASSWORD_VERIFY_FUNTION  "VERIFY_FUNCTION_DISA"             
 ;
