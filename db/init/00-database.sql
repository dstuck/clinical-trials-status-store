CREATE DATABASE clinical_trials_status;
\connect clinical_trials_status;

CREATE SCHEMA trials_status_schema;

CREATE TABLE trials_status_schema.organizations (
  id SERIAL UNIQUE,
  org_full_name TEXT,
  org_class TEXT,
  total_count INT DEFAULT 0,
  should_have_results_count INT,
  late_count INT DEFAULT 0,
  missing_count INT DEFAULT 0,
  on_time_count INT DEFAULT 0,
  late_frac FLOAT,
  missing_frac FLOAT,
  on_time_frac FLOAT,
  created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (org_full_name, org_class)
);
COMMENT ON TABLE trials_status_schema.organizations IS 'Institutions that run clinical trials.';

CREATE TABLE trials_status_schema.trials (
  id TEXT PRIMARY KEY,

  -- fields scraped directly from clinicaltrials.gov
  completion_date TIMESTAMP,
  condition TEXT,
  delayed_posting BOOLEAN,
  last_update_submit_date TIMESTAMP,
  official_title TEXT,
  overall_official_affiliation TEXT,
  overall_official_name TEXT,
  overall_status TEXT,
  point_of_contact_e_mail TEXT,
  point_of_contact_organization TEXT,
  responsible_party_investigator_full_name TEXT,
  responsible_party_type TEXT,
  results_first_post_date TIMESTAMP,
  results_first_submit_date TIMESTAMP,
  start_date TIMESTAMP,
  status_verified_date TIMESTAMP,
  why_stopped TEXT,

  -- fields computed by scraper
  should_have_results BOOLEAN,
  is_late BOOLEAN,
  is_missing BOOLEAN,
  is_on_time BOOLEAN,

  data_version TIMESTAMP,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  org_id INTEGER NOT NULL REFERENCES trials_status_schema.organizations(id)
  
);
COMMENT ON TABLE trials_status_schema.trials IS 'Trials from clinicaltrials.gov with their completion status.';
CREATE INDEX org_id ON trials_status_schema.trials (org_id);
