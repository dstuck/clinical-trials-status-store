\connect clinical_trials_status;

INSERT INTO trials_status_schema.institutions (org_name, org_type) VALUES
('DrugCo', 'pharma'),
('ResearchU', 'academic');

INSERT INTO trials_status_schema.trials (trial_id, completion_date, completion_status, results_report_date, clinicaltrials_updated_at, org_id) VALUES
('11', '2017-10-01', 'Actual', NULL, '2019-01-01', 1),
('22', '2020-10-01', 'Projected', NULL, '2019-01-01', 1),
('12', '2017-11-01', 'Actual', '2018-10-01', '2019-10-01', 1),
('33', '2015-10-01', 'Actual', '2016-10-01', '2019-01-01', 2),
('34', '2015-10-01', 'Actual', '2016-09-22', '2019-01-01', 2);
