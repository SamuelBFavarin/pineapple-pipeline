
def model(dbt, session):

    dbt.config(
        materialized='table'
    )

    source_github_repositories = dbt.source("raw_github", "repository")
    final_table = source_github_repositories.filter(col("archived"==True)) 
    df = final_table.select("*")

    return df