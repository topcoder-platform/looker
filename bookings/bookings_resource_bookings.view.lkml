view: resource_bookings {

  sql_table_name: public.bookings_resource_bookings ;;
  drill_fields: [id]

  dimension: id {
    description: ""
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    description: ""
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: created_by {
    description: ""
    type: string
    sql: ${TABLE}.created_by ;;
  }

  dimension: customer_rate {
    description: "Rate decided by the customer"
    type: number
    sql: ${TABLE}.customer_rate ;;
  }

  dimension_group: deleted {
    description: ""
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.deleted_at ;;
  }

  dimension_group: end {
    description: ""
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.end_date ;;
  }

  dimension: job_id {
    description: " id of the job"
    type: string
    sql: ${TABLE}.job_id ;;
  }

  dimension: member_rate {
    description: " Rate for the member"
    type: number
    sql: ${TABLE}.member_rate ;;
  }

  dimension: project_id {
    description: " Project id assocaited with the job "
    type: number
    sql: ${TABLE}.project_id ;;
  }

  dimension: rate_type {
    description: "rate type of the booking"
    type: string
    sql: ${TABLE}.rate_type ;;
  }

  dimension_group: start {
    description: ""
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.start_date ;;
  }

  dimension: status {

    description: " Status of the booking"
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension_group: updated {
    description: ""
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.updated_at ;;
  }

  dimension: updated_by {
    description: ""
    type: string
    sql: ${TABLE}.updated_by ;;
  }

  dimension: user_id {
    description: "user id"
    type: string
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
