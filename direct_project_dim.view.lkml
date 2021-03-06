view: direct_project_dim {
  sql_table_name: tcs_dw.direct_project_dim ;;

  dimension: billing_account_id {
    type: number
    sql: ${TABLE}.billing_project_id ;;
  }

  dimension: direct_project_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.direct_project_id ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
    link: {
      label: "Direct Project Link"
      url: "https://www.topcoder.com/direct/projectOverview?formData.projectId={{ direct_project_dim.direct_project_id._value }}"
      icon_url: "https://looker.com/favicon.ico"
    }
  }

  dimension_group: project_create {
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      quarter,
      year,
      fiscal_month_num,
      fiscal_quarter,
      fiscal_quarter_of_year,
      fiscal_year
    ]
    sql: ${TABLE}.project_create_date ;;
  }

  dimension_group: project_modification {
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      quarter,
      year,
      fiscal_month_num,
      fiscal_quarter,
      fiscal_quarter_of_year,
      fiscal_year
    ]
    sql: ${TABLE}.project_modification_date ;;
  }

  dimension: project_status_id {
    type: number
    sql: ${TABLE}.project_status_id ;;
  }

  dimension: project_status_desc {
    type: string
    sql: CASE WHEN ${project_status_id} = 1 THEN 'Active'
          WHEN ${project_status_id} = 2 THEN 'Inactive'
          WHEN ${project_status_id} = 3 THEN 'Cancelled'
          WHEN ${project_status_id} = 4 THEN 'Completed'
          WHEN ${project_status_id} = 5 THEN 'Draft'
          ELSE 'NA'
      END
       ;;
  }

  measure:project_budget  {
    type: sum
    value_format_name: usd
    description: "Direct project budget (user entered)"
    sql:  ${TABLE}.direct_project_budget;;
  }

  measure:project_budget_distinct  {
    type: sum_distinct
    value_format_name: usd
    sql_distinct_key: ${TABLE}.direct_project_id ;;
    description: "Direct project budget (user entered). Used for summary calculations "
    sql:  ${TABLE}.direct_project_budget;;
  }


  measure:project_duration {
    type: sum
    description: "Direct project duration (user entered)"
    sql: ${TABLE}.direct_project_duration  ;;
  }

  measure: count {
    type: count
    drill_fields: [name]
  }

  measure: count_project {
    type: count_distinct
    sql: ${TABLE}.direct_project_id ;;
  }
}
