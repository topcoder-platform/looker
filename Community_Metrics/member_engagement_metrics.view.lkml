view: member_engagement_metrics {

   derived_table: {
     sql:
SELECT date,
       (SELECT count(*) FROM heapdata.pageviews WHERE date_trunc('week', time) = c.date ) as pageviews,
       (SELECT count(*)  FROM coder WHERE status = 'A' and date_trunc('week', member_since) = c.date) as sign_ups,
       (SELECT count(*) FROM project_result WHERE date_trunc('week', inquire_timestamp) = c.date ) as challenge_registrations,
       (SELECT count(distinct user_id) FROM project_result WHERE date_trunc('week', inquire_timestamp) = c.date ) as distinct_challenge_registrants,
       (SELECT count(*) FROM project_result WHERE date_trunc('week', submit_timestamp) = c.date AND submit_ind = 1 ) as challenge_submissions,
       (SELECT count(distinct user_id) FROM project_result WHERE date_trunc('week', submit_timestamp) = c.date AND submit_ind = 1 ) as distinct_challenge_submitters,
       (SELECT count(*) FROM recruit_crm_candidate WHERE date_trunc('week', created_on) = c.date ) as gig_applicants,
       (SELECT count(*) FROM bookings_resource_bookings WHERE date_trunc('week', created_at) = c.date) as gig_placements,
       (SELECT count(distinct user_id) FROM user_payment WHERE date_trunc('week', create_date) = c.date ) as members_paid,
       (SELECT count(*) FROM heapdata.profile_events_success_login WHERE date_trunc('week', time) = c.date ) as logins,
       (SELECT count(distinct nickname) FROM heapdata.profile_events_success_login WHERE date_trunc('week', time) = c.date ) as distinct_logins
FROM calendar c
WHERE c.date < getdate()
GROUP BY 1
       ;;
   }

  # Define your dimensions and measures here, like this:
  dimension_group: event_date {
    type: time
    timeframes: [
      week
    ]
    sql: ${TABLE}.date ;;
  }

   measure: pageviews {
     description: "The total number of pageviews"
     type: sum
     sql: ${TABLE}.pageviews ;;
   }

  measure: sign_ups {
    description: "The total number of sign_ups"
    type: sum
    sql: ${TABLE}.sign_ups ;;
  }

  measure: challenge_registrations {
    description: "The total number of challenge_registrations"
    type: sum
    sql: ${TABLE}.challenge_registrations ;;
  }

  measure: distinct_challenge_registrants {
    description: "The total number of distinct_challenge_registrants"
    type: sum
    sql: ${TABLE}.distinct_challenge_registrants ;;
  }

  measure: challenge_submissions {
    description: "The total number of challenge_submissions"
    type: sum
    sql: ${TABLE}.challenge_submissions ;;
  }

  measure: distinct_challenge_submitters {
    description: "The total number of distinct_challenge_submitters"
    type: sum
    sql: ${TABLE}.distinct_challenge_submitters ;;
  }

  measure: gig_applicants {
    description: "The total number of gig_applicants"
    type: sum
    sql: ${TABLE}.gig_applicants ;;
  }

  measure: gig_placements {
    description: "The total number of gig_placements"
    type: sum
    sql: ${TABLE}.gig_placements ;;
  }

  measure: members_paid {
    description: "The total number of members_paid"
    type: sum
    sql: ${TABLE}.members_paid ;;
  }

  measure: logins {
    description: "The total number of logins"
    type: sum
    sql: ${TABLE}.logins ;;
  }

  measure: distinct_logins {
    description: "The total number of distinct_logins"
    type: sum
    sql: ${TABLE}.distinct_logins ;;
  }

  measure: count {
    type: count
  }
}



#   dimension: lifetime_orders {
#     description: "The total number of orders for each user"
#     type: number
#     sql: ${TABLE}.lifetime_orders ;;
#   }
#
#   dimension_group: most_recent_purchase {
#     description: "The date when each user last ordered"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.most_recent_purchase_at ;;
#   }
#
#   measure: total_lifetime_orders {
#     description: "Use this for counting lifetime orders across many users"
#     type: sum
#     sql: ${lifetime_orders} ;;
#   }
# }
