# clinical-trials-status-store
Graphql api for storing clinical trials statuses

# Current testing

1) `cd clinical-trials-status-store`

2) `POSTGRES_USER=postgres POSTGRES_PASSWORD=1234 POSTGRES_DATABASE=clinical_trials_status docker-compose up --build`

3) Navigate to http://0.0.0.0:5000/graphiql
    * Then run query:
        ```
        query {
          allInstitutions {
            nodes {
              id
              orgName
              orgType
              lateReportCount
              readyForReportCount
              lateReportRate
              trialsByOrgId {
                nodes {
                  id
                  completionDate
                  completionStatus
                  resultsReportDate
                  isLate
                  readyForReport
                }
              }
            }
          }
        }
        ```
# Updating schema file

1) `npm install -g graphql-cli`

2) Run with docker

3) `graphql init`

4) `graphql get-schema`
