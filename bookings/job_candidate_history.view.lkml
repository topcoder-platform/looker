view: job_candidate_history {
  derived_table: {
    sql_create:
      create table ${SQL_TABLE_NAME}
      AS
       select
        id,
        candidate_slug,
        job_slug,
        status,
        stage_date,
        remark,
        updated_on,
        lead(stage_date, 1) over (partition by candidate_slug, job_slug order by stage_date)
        as status_end_date,
        datediff(hours,stage_date,status_end_date) as duration

      from tcs_dw.recruit_crm_stage_history
      order by candidate_slug, job_slug, stage_date;;

      sql_trigger_value: select max(id) from recruit_crm_stage_history;;
    }

    dimension: job_candidate_id {
      primary_key: no
      description: "Generated by concatenating candidate slug with job slug"
      sql:CONCAT(${TABLE}.candidate_slug, ${TABLE}.job_slug) ;;
    }

    dimension:  id {
      type: number
      hidden: yes
      primary_key: yes
      description: "Identity Key generated for uniqueness"
      value_format_name: id
      sql: ${TABLE}.id ;;
    }

    dimension: candidate_slug {
      type: string
      sql: ${TABLE}.candidate_slug ;;
    }

  dimension: job_slug{
    type: string
    sql: ${TABLE}.job_slug ;;
  }

  dimension: status {
    type: string
    description: "Candidate Job Status"
    sql: ${TABLE}.status ;;
  }

  dimension_group: stage {
    type: time
    description: "Timestamp when the stage was updated"
    sql: ${TABLE}.stage_date ;;
    timeframes: [time, date, week, month]
  }

  dimension: remark {
    type: string
    description: "Remarks on candidate"
    sql: ${TABLE}.remark ;;
  }

  dimension_group: updated_on {
    type: time
    description: "Last Update on"
    sql: ${TABLE}.updated_on ;;
    timeframes: [time, date, week, month]
  }
  measure: duration_hours {
    type: sum_distinct
    description: "Status Duration (in Hours)"
    sql: ${TABLE}.duration ;;
  }

  measure: duration {
    type: sum_distinct
    description: "Status Duration (in Days)"
    sql: ${TABLE}.duration / 24 ;;
  }

  measure: avg_duration_days {
    type: average_distinct
    description: "Average Status Duration (in Days)"
    sql: ${TABLE}.duration / 24 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }


  set: detail {
    fields: [
      id,
      candidate_slug,
      job_slug,
      status,
      remark,
      duration,
      duration_hours
    ]
  }
}
