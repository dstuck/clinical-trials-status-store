\connect clinical_trials_status;

CREATE FUNCTION trials_status_schema.trials_ready_for_report(trial trials_status_schema.trials)
RETURNS BOOLEAN as $$
    SELECT
    (trial.completion_date IS NOT NULL) AND
    (trial.completion_date <= now() - INTERVAL '1 year');
$$ language sql stable;

CREATE FUNCTION trials_status_schema.trials_is_late(trial trials_status_schema.trials)
RETURNS BOOLEAN as $$
    SELECT
    trials_status_schema.trials_ready_for_report(trial) AND
    (
        (trial.results_report_date IS NULL) OR
        (trial.results_report_date - trial.completion_date >= INTERVAL '1 year')
    );
$$ language sql stable;

CREATE FUNCTION trials_status_schema.institutions_late_report_count(institution trials_status_schema.institutions)
RETURNS BIGINT as $$
    SELECT COUNT(trial_table.id)
    FROM trials_status_schema.trials as trial_table
    WHERE trial_table.org_id = institution.id AND
        trials_status_schema.trials_is_late(trial_table);
$$ language sql stable;

CREATE FUNCTION trials_status_schema.institutions_ready_for_report_count(institution trials_status_schema.institutions)
RETURNS BIGINT as $$
    SELECT COUNT(trial_table.id)
    FROM trials_status_schema.trials as trial_table
    WHERE trial_table.org_id = institution.id AND
        trials_status_schema.trials_ready_for_report(trial_table);
$$ language sql stable;

CREATE FUNCTION trials_status_schema.institutions_late_report_rate(institution trials_status_schema.institutions)
RETURNS FLOAT as $$
    SELECT CAST(trials_status_schema.institutions_late_report_count(institution) AS FLOAT)
     / trials_status_schema.institutions_ready_for_report_count(institution)
$$ language sql stable;
