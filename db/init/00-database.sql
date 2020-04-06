CREATE DATABASE clinical_trials_status;
\connect clinical_trials_status;

CREATE SCHEMA trials_status_schema;

CREATE TABLE trials_status_schema.organizations (
  id SERIAL UNIQUE,
  org_full_name TEXT,
  org_class TEXT,
  total_count INT DEFAULT 0,
  should_have_results_count INT DEFAULT 0,
  has_regulated_studies BOOLEAN DEFAULT false,
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
CREATE INDEX has_regulated_studies ON trials_status_schema.organizations (has_regulated_studies);

CREATE TABLE trials_status_schema.trials (
  id TEXT PRIMARY KEY,

  -- fields scraped directly from clinicaltrials.gov
  is_applicable_trial BOOLEAN,
  brief_title TEXT,
  delayed_posting BOOLEAN,
  design_primary_purpose TEXT,
  last_update_submit_date TIMESTAMP,
  location_country TEXT,
  is_f_d_a_regulated_drug BOOLEAN,
  is_interventional BOOLEAN,
  is_major_device_test BOOLEAN,
  is_major_drug_test BOOLEAN,
  is_unapproved_device BOOLEAN,
  is_under_fda_oversight BOOLEAN,
  is_u_s_export BOOLEAN,
  n_c_t_id TEXT,
  overall_status TEXT,
  phase TEXT,
  primary_completion_date TIMESTAMP,
  primary_completion_date_type TEXT,
  results_first_post_date TIMESTAMP,
  results_first_submit_date TIMESTAMP,
  start_date TIMESTAMP,
  study_type TEXT,

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
