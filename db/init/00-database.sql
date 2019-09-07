CREATE DATABASE clinical_trials_status;

\connect clinical_trials_status;

CREATE SCHEMA trials_status_schema;

CREATE TABLE trials_status_schema.institutions (
    id SERIAL PRIMARY KEY,
    org_name TEXT,
    org_type TEXT,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
COMMENT ON TABLE trials_status_schema.institutions IS
'Institutions that run clinical trials.';

CREATE TABLE trials_status_schema.trials (
    id SERIAL PRIMARY KEY,
    trial_id TEXT,
    completion_date TIMESTAMP,
    completion_status TEXT,
    results_report_date TIMESTAMP,
    clinicaltrials_updated_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    org_id INTEGER NOT NULL REFERENCES trials_status_schema.institutions(id)
);
COMMENT ON TABLE trials_status_schema.trials IS
'Trials from clinicaltrials.gov with their completion status.';
