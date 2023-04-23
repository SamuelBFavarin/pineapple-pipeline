{{
  config(
    materialized = 'table',
    tags = ['daily', 'nutrisense']
  )
}}

SELECT *
FROM {{ source('raw_nutrisense', 'new_members') }}