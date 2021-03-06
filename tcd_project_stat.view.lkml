view: tcd_project_stat {
  sql_table_name: tcs_dw.tcd_project_stat ;;

  dimension_group: create {
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
    sql: ${TABLE}.create_date ;;
  }

  dimension: create_user {
    type: string
    sql: ${TABLE}.create_user ;;
  }

  dimension_group: modify {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.modify_date ;;
  }

  dimension: modify_user {
    type: string
    sql: ${TABLE}.modify_user ;;
  }

  dimension: project_category_id {
    type: number
    sql: ${TABLE}.project_category_id ;;
  }

  dimension_group: stat_date {
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
    sql: ${TABLE}.stat_date ;;
  }

  dimension: tcd_project_id {
    type: number
    sql: ${TABLE}.tcd_project_id ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: total_project {
    type: sum
    sql: ${TABLE}.total_project ;;
  }

  measure: cost {
    type: sum
    sql: ${TABLE}.cost ;;
  }

  measure: duration {
    type: sum
    sql: ${TABLE}.duration ;;
  }

  measure: fulfillment {
    type: sum
    sql: ${TABLE}.fulfillment ;;
  }
}
