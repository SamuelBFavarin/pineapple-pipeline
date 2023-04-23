{{
  config(
    materialized = 'table',
    tags = ['daily', 'nutrisense']
  )
}}

SELECT *
FROM {{ source('raw_nutrisense', 'active_members') }}