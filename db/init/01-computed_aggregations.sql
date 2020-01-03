\connect clinical_trials_status;

CREATE FUNCTION trials_status_schema.handle_trial_update()
RETURNS trigger AS $BODY$
BEGIN
    IF TG_OP='UPDATE' OR TG_OP='INSERT' THEN
        PERFORM trials_status_schema.update_organization_counts(NEW.org_id);
    END IF;
    IF TG_OP='UPDATE' OR TG_OP='DELETE' THEN
        PERFORM trials_status_schema.update_organization_counts(OLD.org_id);
    END IF;
    RETURN NEW;
END $BODY$ language plpgsql;

CREATE TRIGGER trials_updated
  AFTER UPDATE OR INSERT OR DELETE
  ON trials_status_schema.trials
  FOR EACH ROW
  EXECUTE PROCEDURE trials_status_schema.handle_trial_update();

CREATE FUNCTION trials_status_schema.update_organization_counts(_org_id BIGINT)
RETURNS BOOLEAN AS $BODY$
BEGIN
    update trials_status_schema.organizations o
    set total_count = t.cnt, should_have_results_count = shr_cnt, late_count = l_cnt, missing_count = m_cnt,
        on_time_count = ot_cnt, late_frac = l_frac, missing_frac = m_frac, on_time_frac = ot_frac
    from (
        select
            c.*,
            CASE WHEN shr_cnt > 0 THEN (l_cnt / shr_cnt) ELSE 0.5 END as l_frac,
            CASE WHEN shr_cnt > 0 THEN (m_cnt / shr_cnt) ELSE 0.5 END as m_frac,
            CASE WHEN shr_cnt > 0 THEN (ot_cnt / shr_cnt) ELSE 0.5 END as ot_frac
        from (
            select
                count(*) as cnt,
                sum(should_have_results::int) as shr_cnt,
                sum(is_late::int) as l_cnt,
                sum(is_missing::int) as m_cnt,
                sum(is_on_time::int) as ot_cnt
            from trials_status_schema.trials t where t.org_id = _org_id
        ) c
    ) t
    where o.id = _org_id;
    RETURN true;
END $BODY$ language plpgsql;
