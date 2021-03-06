view: member_payments {
  derived_table: {
    sql: SELECT
          p.payment_id,
          p.payment_desc,
          p.payment_type_id,
          p.payment_type_desc,
          p.reference_id,
          p.parent_payment_id,
          p.charity_ind,
          p.show_in_profile_ind,
          p.show_details_ind,
          p.payment_status_id,
          p.payment_status_desc,
          p.client,
          mod_date.date AS date_modified,
          p.modified_time_id,
          p.installment_number,
          p.jira_ticket_id,
          create_date.date as date_created,
          p.created_time_id,
          up.payment_id,
          up.user_id,
          payee.handle,
          payee.country_code,
          payee.comp_country_code,
          payee.member_since,
          due_date.date AS date_due,
          paid_date.date AS date_paid,
          up.net_amount,
          up.gross_amount,
          up.total_amount
      FROM tcs_dw.payment p,
           tcs_dw.user_payment up,
           tcs_dw.calendar mod_date,
           tcs_dw.calendar due_date,
           tcs_dw.calendar paid_date,
           tcs_dw.calendar create_date,
           tcs_dw.coder payee
      WHERE p.payment_id = up.payment_id
        AND p.modified_calendar_id = mod_date.calendar_id
        AND up.due_calendar_id = due_date.calendar_id
        AND up.paid_calendar_id = paid_date.calendar_id
        AND p.created_calendar_id = create_date.calendar_id
        AND up.user_id = payee.coder_id
       ;;
  }

  dimension: payment_id {
    type: number
    sql: ${TABLE}.payment_id ;;
  }

  dimension: payment_desc {
    type: string
    sql: ${TABLE}.payment_desc ;;
  }

  dimension: payment_type_desc {
    type: string
    sql: ${TABLE}.payment_type_desc ;;
  }

  dimension: reference_id {
    type: number
    sql: ${TABLE}.reference_id ;;
  }

  dimension: parent_payment_id {
    type: number
    sql: ${TABLE}.parent_payment_id ;;
  }

  dimension: charity_ind {
    type: number
    sql: ${TABLE}.charity_ind ;;
  }

  dimension: show_in_profile_ind {
    type: number
    sql: ${TABLE}.show_in_profile_ind ;;
  }

  dimension: show_details_ind {
    type: number
    sql: ${TABLE}.show_details_ind ;;
  }

  dimension: payment_status_desc {
    type: string
    sql: ${TABLE}.payment_status_desc ;;
  }

  dimension: client {
    type: string
    sql: ${TABLE}.client ;;
  }

  dimension_group: date_modified {
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      year,
      quarter,
      fiscal_month_num,
      fiscal_quarter,
      fiscal_quarter_of_year,
      fiscal_year
    ]
    sql: ${TABLE}.date_modified ;;
  }

  dimension_group: date_created {
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      year,
      quarter,
      fiscal_month_num,
      fiscal_quarter,
      fiscal_quarter_of_year,
      fiscal_year
    ]
    sql: ${TABLE}.date_created ;;
  }

  dimension: installment_number {
    type: number
    sql: ${TABLE}.installment_number ;;
  }

  dimension: jira_ticket_id {
    type: string
    sql: ${TABLE}.jira_ticket_id ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: handle {
    type: string
    sql: ${TABLE}.handle ;;
  }

  dimension: country_code {
    type: number
    sql: ${TABLE}.country_code ;;
  }

  dimension: comp_country_code {
    type: number
    sql: ${TABLE}.comp_country_code ;;
  }

  dimension_group: member_since {
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      year,
      quarter,
      fiscal_month_num,
      fiscal_quarter,
      fiscal_quarter_of_year,
      fiscal_year
    ]
    sql: ${TABLE}.member_since ;;
  }

  dimension_group: date_due {
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      year,
      quarter,
      fiscal_month_num,
      fiscal_quarter,
      fiscal_quarter_of_year,
      fiscal_year
    ]
    sql: ${TABLE}.date_due ;;
  }

  dimension_group: date_paid {
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      year,
      quarter,
      fiscal_month_num,
      fiscal_quarter,
      fiscal_quarter_of_year,
      fiscal_year
    ]
    sql: ${TABLE}.date_paid ;;
  }

  measure: net_amount {
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.net_amount ;;
  }

  measure: gross_amount {
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.gross_amount ;;
  }

  measure: total_amount {
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.total_amount ;;
  }

  measure: count {
    type: count
  }

  measure: count_distinct_user {
    type: count_distinct
    sql: ${TABLE}.user_id ;;
  }
}
