{{ 
    config(materialized='table') 
}}

SELECT 
  u.id AS id_user,
  COUNT(r.id) AS total_repositories,
  COUNTIF(r.private IS TRUE) AS total_private_repositories,
  COUNTIF(r.private IS FALSE) AS total_public_repositories,
  COUNTIF(r.archived IS TRUE) AS total_archived_repositories,
  COUNTIF(r.fork IS TRUE) AS total_fork_repositories,
  ARRAY_LENGTH((ARRAY_AGG(DISTINCT language IGNORE NULLS))) AS total_programing_languages,
  MIN(r.created_at) AS first_repository_created_at,
  MAX(r.created_at) AS last_repository_created_at,
  MIN(u.created_at) AS user_created_at,
  MAX(u.updated_at) AS user_updated_at
FROM {{ source('raw_github', 'user') }} AS u
INNER JOIN {{ source('raw_github', 'repository') }} AS r
  ON r.owner_id = u.id
GROUP BY u.id