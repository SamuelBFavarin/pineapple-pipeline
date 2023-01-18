#! /bin/bash

# GET ACCOUNT ID
#curl --request GET \
# --url https://cloud.getdbt.com/api/v2/accounts/ \
# --header 'Content-Type: application/json' \
# --header 'Authorization: Token <your-token>'
account_id=10829

# GET RUN ID
#last_run_id=$(curl --request GET \
#  --url https://cloud.getdbt.com/api/v2/accounts/$account_id/runs/?limit=1\&order_by=-id \
#  --header 'Content-Type: application/json' \
#  --header 'Authorization: Token <your-token>' | jq -r '.data[0] .id');

#echo "LAST RUN ID: " $last_run_id 

# GET MANIFEST.JSON
#curl --request GET \
#  --url https://cloud.getdbt.com/api/v2/accounts/{$account_id}/runs/{$last_run_id}/artifacts/manifest.json \
#  --header 'Content-Type: application/json' \
#  --header 'Authorization: Token <your-token>' >> /app/manifest.json

echo "MANIFEST.JSON GENERATED" 
echo "----------------------------------------------"

echo "Starting the dbt test execution"
echo "----------------------------------------------"

dbt run --select fact_github_user --defer --state ./
dbt test --select fact_channel --defer --state ./


echo "All tests finished"
echo "----------------------------------------------"