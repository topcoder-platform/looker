- view: user_rating
  sql_table_name: public.user_rating
  fields:

  - dimension_group: create_date
    type: time
    timeframes: [time, date, week, month, quarter, year]
    sql: ${TABLE}.create_date_time

  - dimension: highest_rating
    type: number
    sql: ${TABLE}.highest_rating

  - dimension: last_rated_project_id
    type: number
    sql: ${TABLE}.last_rated_project_id

  - dimension: lowest_rating
    type: number
    sql: ${TABLE}.lowest_rating

  - dimension_group: mod_date
    type: time
    timeframes: [time, date, week, month, quarter, year]
    sql: ${TABLE}.mod_date_time

  - dimension: phase_id
    type: number
    sql: ${TABLE}.phase_id

  - dimension: rating
    type: number
    sql: ${TABLE}.rating

  - dimension: rating_no_vol
    type: number
    sql: ${TABLE}.rating_no_vol

  - dimension: user_id
    type: number
    sql: ${TABLE}.user_id

  - dimension: vol
    type: number
    sql: ${TABLE}.vol

  - measure: count
    type: count
    drill_fields: []

  - measure: num_ratings
    type: sum
    sql: ${TABLE}.num_ratings