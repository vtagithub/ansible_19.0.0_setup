####################################################
# 00_readme.txt - Oracle 19c
#####################################################

0) . oraenv

1) execute scripts below as needed

2) sqlplus "/as sysdba"

3) @2a_verify_function_disa_15char.sql
     or
   @02b_verify_function_disa.sql
   
4)	@3_create_standard_profiles.sql

5)	If applicate
		@04a_create_wms_profiles.sql	
		@04c_create_vdc_profiles.sql
		
06)	@05_create_standard_roles.sql

07)	@06_create_data_security_account.sql

08)	@07_create_dba_account.sql

09)	@08_create_securityscan_account.sql

10)	@09_create_emsmon_account.sql

11) @10_audit_fixes.sql

12)	@11_database_auditing.sql

13)	@12_edit_config_files.txt

14) rman @13_rman_config.rman


############################################################
		
   
