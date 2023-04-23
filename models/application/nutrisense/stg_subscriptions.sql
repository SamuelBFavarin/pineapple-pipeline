SELECT *
FROM {{ source('raw_nutrisense', 'subscriptions') }}