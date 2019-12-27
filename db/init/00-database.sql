CREATE DATABASE clinical_trials_status;
\connect clinical_trials_status;

CREATE SCHEMA trials_status_schema;

CREATE TABLE trials_status_schema.institutions (
  id SERIAL UNIQUE,
  org_name TEXT,
  org_type TEXT DEFAULT '',
  created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (org_name, org_type)
);
COMMENT ON TABLE trials_status_schema.institutions IS 'Institutions that run clinical trials.';
CREATE TABLE trials_status_schema.trials (
  id TEXT PRIMARY KEY,
  completion_date TIMESTAMP,
  completion_status TEXT,
  results_report_date TIMESTAMP,
  is_delayed BOOLEAN,
  contact_email TEXT,
  clinicaltrials_updated_at TIMESTAMP,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  org_id INTEGER NOT NULL REFERENCES trials_status_schema.institutions(id)
);
COMMENT ON TABLE trials_status_schema.trials IS 'Trials from clinicaltrials.gov with their completion status.';
