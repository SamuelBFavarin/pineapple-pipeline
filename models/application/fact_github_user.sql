{{ 
    config(
        materialized='table', 
        tags=['daily']) 
}}

WITH user_repo_metrics AS (
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
),

user_commit_metrics AS (
  SELECT 
    u.id AS id_user,
    COUNT(c.sha) AS total_commits,

  FROM {{ source('raw_github', 'user') }} AS u
  INNER JOIN {{ source('raw_github', 'user_email') }} AS ue
    ON ue.user_id = u.id
  INNER JOIN {{ source('raw_github', 'commit') }}  AS c
    ON c.author_email = ue.email
  GROUP BY u.id
)

SELECT 
  u.id AS id_user,
  urm.total_repositories,
  urm.total_private_repositories,
  urm.total_public_repositories,
  urm.total_archived_repositories,
  urm.total_fork_repositories,
  urm.total_programing_languages,
  ucm.total_commits,
  urm.first_repository_created_at,
  urm.last_repository_created_at,
  urm.user_created_at,
  urm.user_updated_at
FROM {{ source('raw_github', 'user') }} AS u
INNER JOIN user_repo_metrics AS urm
  ON urm.id_user = u.id
INNER JOIN user_commit_metrics AS ucm
  ON ucm.id_user = u.id