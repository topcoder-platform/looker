view: member_hobby {
  sql_table_name: tcs_dw.member_hobby ;;

  dimension: compound_primary_key {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.user_id || ${TABLE}.hobby ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
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
    sql: ${TABLE}.created_at ;;
  }

  dimension: created_by {
    type: number
    sql: ${TABLE}.created_by ;;
  }

  dimension: description {
    type: string
    description: "Member personal interests in detail"
    sql: ${TABLE}.description ;;
  }

  dimension: hobby {
    type: string
    description: "Member personal interests"
    sql: ${TABLE}.hobby ;;
  }

  dimension_group: updated {
    type: time
    timeframes: [
      raw,
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
    sql: ${TABLE}.updated_at ;;
  }

  dimension: updated_by {
    type: number
    sql: ${TABLE}.updated_by ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: count_distinct_users {
    type: count_distinct
    sql: ${TABLE}.user_id ;;
  }

}
