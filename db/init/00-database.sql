CREATE DATABASE clinical_trials_status;
\connect clinical_trials_status;

CREATE SCHEMA trials_status_schema;

CREATE TABLE trials_status_schema.institutions (
  id SERIAL UNIQUE,
  org_full_name TEXT,
  org_class TEXT,
  created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (org_full_name, org_class)
);
COMMENT ON TABLE trials_status_schema.institutions IS 'Institutions that run clinical trials.';
CREATE TABLE trials_status_schema.trials (
  id TEXT PRIMARY KEY,

  overall_status TEXT,
  official_title TEXT,
  condition TEXT,
  delayed_posting BOOLEAN,
  why_stopped TEXT,
  start_date TIMESTAMP,
  status_verified_date TIMESTAMP,
  completion_date TIMESTAMP,
  results_first_submit_date TIMESTAMP,
  results_first_post_date TIMESTAMP,
  last_update_submit_date TIMESTAMP,
  point_of_contact_e_mail TEXT,
  point_of_contact_organization TEXT,
  responsible_party_investigator_full_name TEXT,
  responsible_party_type TEXT,
  overall_official_affiliation TEXT,
  overall_official_name TEXT,

  data_version TIMESTAMP,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  org_id INTEGER NOT NULL REFERENCES trials_status_schema.institutions(id)
);
COMMENT ON TABLE trials_status_schema.trials IS 'Trials from clinicaltrials.gov with their completion status.';
