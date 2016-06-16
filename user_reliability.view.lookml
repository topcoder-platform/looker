- view: user_reliability
  sql_table_name: tcs_dw.user_reliability
  fields:

  - dimension_group: create
    type: time
    timeframes: [time, date, week, month, quarter, year]
    sql: ${TABLE}.create_date

  - dimension_group: modify
    type: time
    timeframes: [time, date, week, month, quarter, year]
    sql: ${TABLE}.modify_date

  - dimension: phase_id
    type: number
    sql: ${TABLE}.phase_id

  - dimension: rating
    type: number
    sql: ${TABLE}.rating

  - dimension: user_id
    type: number
    sql: ${TABLE}.user_id

  - measure: count
    type: count
    drill_fields: []

