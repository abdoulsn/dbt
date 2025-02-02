{{
	config(
		query_tag='dbt-demo'
	)
}}

with source_store_sales as (
	select
		ss_sold_date_sk,
		ss_item_sk,
		ss_customer_sk,
		ss_cdemo_sk,
		ss_hdemo_sk,
		ss_addr_sk,
		ss_store_sk,
		ss_promo_sk,
		ss_ticket_number,
		ss_quantity,
		ss_wholesale_cost,
		ss_list_price,
		ss_sales_price,
		ss_ext_discount_amt,
		ss_ext_sales_price,
		ss_ext_wholesale_cost,
		ss_ext_list_price,
		ss_ext_tax,
		ss_coupon_amt,
		ss_net_paid,
		ss_net_paid_inc_tax,
		ss_net_profit
	from
		{{ source('snowflake_sample_src', 'store_sales') }}
),
store_sales as (
	select
		*
	from
		source_store_sales
)
select * from store_sales

-- Call the unapply_masking_policy macro
{{ dbt_snow_mask.unapply_masking_policy(resource_type="models", meta_key="masking_policy", operation_type="unapply") }}