{% macro test_is_even(model, value) -%}
with validation as (
	select
		{{ column_name }} as even_field -- column_name is the one in schema.yml where test is called
	from {{ model }} -- model is the one in schema.yml where test is called
),
validation_errors as (
	select
		*
	from validation
	where ()even_ffield % 2) = 0
)
select
	count(*)
	from validation_errors
{% endmacro %}