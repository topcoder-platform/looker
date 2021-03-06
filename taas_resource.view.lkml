view: taas_resource {

  sql_table_name: tcs_dw.taas_resource ;;
  drill_fields: [taas_resource_id]

  dimension: taas_resource_id {
    primary_key: yes
    type: string
    description: "Salesforce Primary Key"
    sql: ${TABLE}.id ;;
  }

  dimension: billing_account {
    hidden: yes
    type: string
    sql: ${TABLE}.billing_account__c ;;
  }

  dimension_group: billing_account_end {
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
    sql: ${TABLE}.billing_account_end_date__c ;;
  }

  dimension: billing_account_name {
    type: string
    sql: ${TABLE}.billing_account_name__c ;;
  }

  dimension_group: billing_account_start {
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
    sql: ${TABLE}.billing_account_start_date__c ;;
  }

  dimension: billing_status {
    hidden: yes
    type: string
    sql: ${TABLE}.billing_status__c ;;
  }

  dimension: challenge_description {
    hidden: yes
    type: string
    sql: ${TABLE}.challenge_description__c ;;
  }

  dimension: challenge_prefix {
    hidden: yes
    type: string
    sql: ${TABLE}.challenge_prefix__c ;;
  }

  dimension: client {
    type: string
    sql: ${TABLE}.client__c ;;
  }

  dimension: client_blling_account {
    type: string
    sql: ${TABLE}.client_billing_account__c ;;
  }

  dimension: client_bill_rate {
    type: number
    sql: ${TABLE}.client_bill_rate__c ;;
  }

  dimension: client_poc {
    type: string
    description: "Client Point of Contact Name"
    sql: ${TABLE}.client_poc__c ;;
  }

  dimension: client_poc_email {
    type: string
    description: "Client Point of Contact Email"
    sql: ${TABLE}.client_poc_email__c ;;
  }

  dimension: comments {
    type: string
    description: "Additional Internal Comments for the Resource"
    sql: ${TABLE}.comments__c ;;
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
      year
    ]
    sql: ${TABLE}.createddate ;;
  }

  dimension: direct_link {
    hidden: yes
    type: string
    sql: ${TABLE}.direct_link__c ;;
  }

  dimension: direct_project_id {
    type: number
    value_format_name: id
    sql: ${TABLE}.direct_project_id__c ;;
  }

  dimension_group: end {
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
    sql: ${TABLE}.end_date__c ;;
  }

  dimension: group_id {
    type: string
    sql: ${TABLE}.group_id__c ;;
  }

  dimension: group_name {
    type: string
    description: "Group to which the payment task should be assigned, used for Reporting"
    sql: ${TABLE}.group_name__c ;;
  }

  dimension_group: last_modified {
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
    sql: ${TABLE}.lastmodifieddate ;;
  }

  dimension: milestone_id {
    hidden: yes
    type: number
    value_format_name: id
    sql: ${TABLE}.milestone_id__c ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: opportunity {
    type: string
    sql: ${TABLE}.opportunity__c ;;
  }

  dimension: ratio {
    type: number
    sql: ${TABLE}.ratio__c ;;
    value_format: "0.00\%"
  }

  dimension: resource_email {
    type: string
    sql: ${TABLE}.resource_email__c ;;
  }

  dimension: resource_handle {
    type: string
    sql: ${TABLE}.resource_handle__c ;;
  }

  dimension: send_weekly_survey {
    type: yesno
    sql: ${TABLE}.send_weekly_survey__c ;;
  }

  dimension_group: start {
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
    sql: ${TABLE}.start_date__c ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status__c ;;
  }

  dimension: survey_monkey_contact_id {
    hidden: yes
    type: string
    sql: ${TABLE}.survey_monkey_contact_id__c ;;
  }

  measure: total_payments {
    type: sum
    sql: ${TABLE}.total_payments__c ;;
    value_format_name: usd
  }

  dimension: user_id {
    type: number
    value_format_name: id
    sql: ${TABLE}.user_id__c ;;
  }

  measure: weekly_payment {
    type: sum
    description: "Amount that is being paid per week"
    sql: ${TABLE}.weekly_payment__c ;;
    value_format_name: usd
  }

  dimension: connect_project_id  {
    type: number
    value_format_name: id
    sql: ${TABLE}.connect_project_id__c ;;
  }

  dimension: connect_project_link {
    type: string
    sql: ${TABLE}.connect_project_link__c ;;
  }

  measure: daily_payment {
    type: sum
    sql: ${TABLE}.daily_payment__c ;;
    value_format_name: usd
  }

  dimension: opportunity_name {
    type: string
    sql: ${TABLE}.opportunity_name__c ;;
  }

  dimension: subscription_project {
    type: string
    sql: ${TABLE}.subscription_project__c;;
  }

  dimension: taas_with_new_approach {
    type: yesno
    sql: ${TABLE}.taas_with_new_approach__c ;;
  }

  dimension: terms_signed {
    type: string
    sql: ${TABLE}.terms_signed__c ;;
  }

  measure: total_mismanaged_client_billing {
    type: sum
    sql: ${TABLE}.total_mismanaged_client_billing__c ;;
    value_format_name: usd
  }

  measure: total_planned_client_billing {
    type: sum
    sql: ${TABLE}.total_planned_client_billing__c ;;
    value_format_name: usd
  }

  dimension: verification_status__c {
    type: string
    sql: ${TABLE}.verification_status__c ;;
  }

  dimension: verified {
    type: string
    sql: ${TABLE}.verified__c;;
  }

  dimension: job_candidate_id {
    type: string
    description: "Recruit CRM Key Combination of Candidate ID and Job ID"
    sql: ${TABLE}.job_candidate_id__c ;;
  }

  measure: count {
    type: count
    drill_fields: [taas_resource_id, name]
  }

}
