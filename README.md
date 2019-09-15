# clinical-trials-status-store
Graphql api for storing clinical trials statuses

# Current testing

1) `cd clinical-trials-status-store`

2) `docker-compose up --build`

3) Navigate to http://0.0.0.0:5000/graphiql
    * Then run query:
        ```
        query {
          allInstitutions {
            nodes {
              id
              orgName
              orgType
              trialsByOrgId {
                nodes {
                  id
                  completionDate
                  completionStatus
                  resultsReportDate
                }
              }
            }
          }
        }
        ```
