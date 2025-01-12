{% macro insert_audits(action_name) -%}
insert into dbt_run_log (run_id, run_started_at)
		values ('{{ run_id }}','{{ run_started_at }}')
	commit;
	{ % endmacro %}