view: gig {
  derived_table: {
    sql: select
      company.id  as company_id,
      company.name as company_name,
      job.slug as slug,
      job.name as job_name,
      job.contact_slug as contact_slug,
      job.note_for_candidates as note_for_candidates,
      job.job_status_comment as job_status_comment,
      job.city as city,
      job.locality as locality,
      job.state as state,
      job.country as country,
      job.address as address,
      job.created_on as created_on,
      job.created_by as created_by,
      job.updated_on as updated_on,
      job.updated_by as updated_by,
      job.owner as owner,
      job.job_code as job_code,
      job.show_company_logo as show_company_logo,
      job.specialization as specialization,
      job.job_description_file as job_description_file,
      job.job_questions_id as job_questions_id,
      job.job_questions as job_questions,
      job.duration as duration,
      job.technologies_required as technologies_required,
      job.timezone as timezone,
      job.topcoder_url as topcoder_url,
      job.resource_url as resource_url,
      job.application_form_url as application_form_url,
      job.number_of_openings as number_of_openings,
      job.minimum_experience as minimum_experience,
      job.maximum_experience as maximum_experience,
      job.min_annual_salary as min_annual_salary,
      job.max_annual_salary as max_annual_salary,
      job.salary_type as salary_type,
      job.job_status as job_status,
      job.id as job_id,
      job.enable_job_application_form as enable_job_application_form,
      job.job_posting_status as job_posting_status,
      job.qualification_id as qualification_id,
      job.currency_id as currency_id,
      job.hours_per_week as hours_per_week,
      job.job_description_text as job_description_text,
      left(job.opportunity_id,15) as opportunity_id,
      job.salesforce_url as salesforce_url,
      job.connect_url as connect_url,
      job.candidates_url as candidates_url,
      job.fulfillment_confidence as fulfillment_confidence,
      job.client_rate_type as client_rate_type,
      job.account_executive as account_executive,
      job.completion_date as completion_date,
      job.completion_reason as completion_reason,
      job.system_modified_timestamp as system_modified_timestamp,

      json_extract_path_text(custom_fields,'18','value', true) as taas_app_link,
      json_extract_path_text(custom_fields,'19','value', true) as wipro,
      json_extract_path_text(custom_fields,'20','value', true) as wipro_smu,
      json_extract_path_text(custom_fields,'22','value', true) as wipro_centralization_spoc


      from recruit_crm_job as job
      inner join recruit_crm_company as company ON job.company_slug = company.slug
       ;;
    persist_for: "24 hours"
    distribution_style: "even"
    indexes: ["company_id", "job_id", "slug"]
  }

  #------------------------------------Metadata extracts -------------------#
  dimension: taas_app_link {
    label: "TaaS App Link"
    type: string

    link: {
      label: "App Link"
      url: "{{value}}"
      icon_url: "https://topcoder.com/favicon.ico"
    }
  }

  dimension: wipro {
    label: "Wipro"
    type: string
    description: "Is the Job Posted on behalf of Wipro ?"
  }

  dimension: wipro_smu {
    label: "Wipro SMU"
    type: string
    description: "Wipro SMU for the Gig"
  }

  dimension: wipro_centralization_spoc {
    label: "Wipro Centralization SPOC"
    type: string
  }

  #-----------------------------------------------------------------------#

  dimension: company_id {
    type: number
    hidden: yes
    sql: ${TABLE}.company_id ;;
  }

  dimension_group: system_modified_timestamp {
    label: "System Modified"
    type: time
    description: "Timestamp when the record was touched by the Loader"
    timeframes: [
      raw,
      date,
      month,
      year,
      fiscal_month_num,
      fiscal_quarter,
      fiscal_quarter_of_year,
      fiscal_year
    ]

  }

  dimension: company_name {
    type: string
    sql: ${TABLE}.company_name ;;
  }

  dimension: job_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.job_id ;;
  }

  dimension: opportunity_id {
    type: string
    hidden: yes
    case_sensitive: yes
    sql: ${TABLE}.opportunity_id ;;
  }

  dimension: address {
    type: string
    sql: ${TABLE}.address ;;
  }

  dimension: application_form_url {
    type: string
    hidden: yes
    sql: ${TABLE}.application_form_url ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: contact_slug {
    type: string
    hidden: yes
    sql: ${TABLE}.contact_slug ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: created_by {
    type: string
    hidden: yes
    sql: ${TABLE}.created_by ;;
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
    sql: ${TABLE}.created_on ;;
  }

  dimension: currency_id {
    type: number
    hidden: yes
    sql: ${TABLE}.currency_id ;;
  }

  dimension: duration {
    type: string
    sql: ${TABLE}.duration ;;
  }

  dimension: enable_job_application_form {
    type: number
    sql: ${TABLE}.enable_job_application_form ;;
  }

  dimension: hours_per_week {
    type: number
    sql: ${TABLE}.hours_per_week ;;
  }

  dimension: job_code {
    type: string
    sql: ${TABLE}.job_code ;;
  }

  dimension: job_description_file {
    type: string
    hidden: yes
    sql: ${TABLE}.job_description_file ;;
  }

  dimension: job_description_text {
    type: string
    sql: ${TABLE}.job_description_text ;;
  }

  dimension: job_posting_status {
    type: number
    sql: ${TABLE}.job_posting_status ;;
  }

  dimension: job_questions {
    type: string
    hidden: yes
    sql: ${TABLE}.job_questions ;;
  }

  dimension: job_questions_id {
    type: string
    hidden: yes
    sql: ${TABLE}.job_questions_id ;;
  }

  dimension: job_status {
    type: string
    sql: ${TABLE}.job_status ;;
  }

  dimension: job_status_comment {
    type: string
    sql: ${TABLE}.job_status_comment ;;
  }

  dimension: locality {
    type: string
    sql: ${TABLE}.locality ;;
  }

  dimension: max_annual_salary {
    type: number
    sql: ${TABLE}.max_annual_salary ;;
  }

  dimension: maximum_experience {
    type: number
    sql: ${TABLE}.maximum_experience ;;
  }

  dimension: min_annual_salary {
    type: number
    sql: ${TABLE}.min_annual_salary ;;
  }

  dimension: minimum_experience {
    type: number
    sql: ${TABLE}.minimum_experience ;;
  }

  dimension_group: completion {
   type: time
   description: "When was the gig marked complete ?"
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
    sql: ${TABLE}.completion_date ;;
  }

  dimension: completion_reason {
    type: string
    description: "Reason for marking the Gig as completed.A completed gig is not being worked as its either fulfilled or dropped"
    sql: ${TABLE}.completion_reason ;;
  }


  dimension: job_name {
    type: string
    sql: ${TABLE}.job_name ;;
  }

  dimension: note_for_candidates {
    type: string
    sql: ${TABLE}.note_for_candidates ;;
  }


  dimension: owner {
    type: string
    hidden: yes
    sql: ${TABLE}.owner ;;
  }

  dimension: qualification_id {
    type: number
    hidden: yes
    sql: ${TABLE}.qualification_id ;;
  }

  dimension: resource_url {
    type: string
    sql: ${TABLE}.resource_url ;;
  }

  dimension: salary_type {
    type: string
    sql: ${TABLE}.salary_type ;;
  }

  dimension: show_company_logo {
    type: string
    hidden: yes
    sql: ${TABLE}.show_company_logo ;;
  }

  dimension: slug {
    type: string
    sql: ${TABLE}.slug ;;
  }

  dimension: specialization {
    type: string
    sql: ${TABLE}.specialization ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: technologies_required {
    type: string
    sql: ${TABLE}.technologies_required ;;
  }

  dimension: timezone {
    type: string
    sql: ${TABLE}.timezone ;;
  }

  dimension: topcoder_url {
    type: string
    sql: ${TABLE}.topcoder_url ;;
    link: {
      label: "Gig Link"
      url: "{{ gig.topcoder_url._value }}"
      icon_url: "https://topcoder.com/favicon.ico"
    }
  }

  dimension: updated_by {
    type: string
    hidden: yes
    sql: ${TABLE}.updated_by ;;
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
    sql: ${TABLE}.updated_on ;;
  }

  dimension: salesforce_url {
    type: string
    sql: ${TABLE}.salesforce_url ;;
    link: {
      label: "Salesforce Link"
      url: "{{ gig.salesforce_url._value }}"
      icon_url: "https://salesforce.com/favicon.ico"
    }
  }

  dimension: connect_url {
    type: string
    sql: ${TABLE}.connect_url ;;
  }

  dimension: candidates_url {
    type: string
    sql: ${TABLE}.candidates_url ;;
  }

  dimension: fulfillment_confidence {
    type: string
    sql: ${TABLE}.fulfillment_confidence ;;
  }

  dimension: client_rate_type {
    type: string
    sql: ${TABLE}.client_rate_type ;;
  }

  dimension: account_executive {
    type: string
    sql: ${TABLE}.account_executive ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: number_of_openings {
    type: sum
    sql: ${TABLE}.number_of_openings ;;
  }

  set: detail {
    fields: [
      company_id,
      company_name,
      slug,
      job_name,
      contact_slug,
      note_for_candidates,
      job_status_comment,
      city,
      locality,
      state,
      country,
      address,
      created_by,
      updated_by,
      owner,
      job_code,
      show_company_logo,
      specialization,
      job_description_file,
      job_questions_id,
      job_questions,
      technologies_required,
      timezone,
      topcoder_url,
      resource_url,
      application_form_url,
      number_of_openings,
      minimum_experience,
      maximum_experience,
      min_annual_salary,
      max_annual_salary,
      salary_type,
      job_status,
      job_id,
      enable_job_application_form,
      job_posting_status,
      qualification_id,
      currency_id,
      hours_per_week,
      job_description_text,
      salesforce_url,
      connect_url,
      candidates_url,
      fulfillment_confidence,
      client_rate_type,
      account_executive,
      completion_date,
      completion_reason

    ]
  }
 }
