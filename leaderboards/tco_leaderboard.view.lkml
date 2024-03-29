view: tco_leaderboard{
  label: "TCO Leaderboard"
  derived_table: {
    sql:
    select  leaderboard.challenge_blended_id as challenge_id,
            leaderboard.user_id as user_id,
            leaderboard.total_score as total_score,
            leaderboard.round_id as round_id,
            leaderboard.created_at as created_at,
            leaderboard.updated_at as updated_at,
            leaderboard.contest_id as contest_id,
            --leaderboard.points as points,
            leaderboard.placement as placement,
            leaderboard.total_prize as total_prize,
            leaderboard.percentage as percentage,
            leaderboard.raw_points as raw_points,
            leaderboard.fixed_score as fixed_score,
            nvl(rating_booster.rating, 1) as rating_booster,
            contest.track as tco_track,
            contest.sub_track as tco_sub_track,
            contest.contest_name as tco_contest_name,
            challenge.status_id,
            challenge.status_desc,
            challenge.num_submissions_passed_review,
            review.final_score as final_score,
            review.max_score as max_score,
            review.scorecard_type
    from tcs_dw.tco_leaderboard as leaderboard
    left join tcs_dw.tco_rating_booster as rating_booster
        on leaderboard.contest_id = rating_booster.contest_id
        and leaderboard.user_id = rating_booster.user_id
    left join tcs_dw.contest as contest
        on leaderboard.contest_id = contest.contest_id
    left join tcs_dw.project as challenge
        on leaderboard.challenge_blended_id = challenge.challenge_blended_id
    left join tcs_dw.submission_review as review
        on leaderboard.submission_id = review.submission_id
    ;;
      #Cache the data as long as their is no new entry
      datagroup_trigger: tco_leaderboard_cache
      distribution_style: "even"
      indexes: ["challenge_id", "user_id", "contest_id"]
    }

    dimension: final_score {
      description: "Review Final Score"
      type: number
      hidden: yes
      sql: NULLIF(${TABLE}.final_score, 0) ;;
    }

    dimension: max_score {
      description: "Review Max Score"
      type: number
      sql: NULLIF(${TABLE}.max_score, 0) ;;
    }

    dimension: num_submissions_passed_review {
      description: "Number of Submissions Passed Review"
      type: number
      sql: NULLIF(${TABLE}.num_submissions_passed_review, 0) ;;
    }

    dimension: challenge_id {
      description: "Challenge id"
      type: string
      hidden: yes
      sql: ${TABLE}.challenge_id ;;
    }

    dimension: scorecard_type {
      description: "Review Scorecard Type"
      type: string
      sql: ${TABLE}.scorecard_type ;;
    }

    dimension: user_id {
      description: "User id"
      type: number
      hidden: yes
      sql: ${TABLE}.user_id ;;
    }

    measure: total_score {
      description: "Total Score obtained"
      type: sum
      sql: ${TABLE}.total_score ;;
    }

    dimension: round_id {
      description: "SRM Round identifier"
      type: number
      sql: ${TABLE}.round_id ;;
    }

    dimension_group: created_at {
      type: time
      sql: ${TABLE}.created_at ;;
    }

    dimension_group: updated_at {
      type: time
      sql: ${TABLE}.updated_at ;;
    }

    dimension: contest_id {
      description: "Contest id"
      type: number
      hidden: yes
      sql: ${TABLE}.contest_id ;;
    }

    dimension: placement {
      description: "Placement earned by the member "
      type: number
      sql: NULLIF(${TABLE}.placement, 0) ;;
    }

    dimension: total_prize {
      description: "Total prize on the challenge"
      type: number
      sql: ${TABLE}.total_prize ;;
    }

    dimension: percentage {
      description: "Percentage of prize eanred , for tco point calculation"
      type: number
      sql: ${TABLE}.percentage ;;
    }

    dimension: raw_points {
      description: "User defined points. Overrides the computed points"
      type: number
      sql: ${TABLE}.raw_points ;;
    }

    dimension: fixed_score {
      description: "Score if the calculated points is below or above threshold"
      type: number
      sql: ${TABLE}.fixed_score ;;
    }

    dimension: rating_booster {
      description: "Rating booster for tco points applicable to Copilots currently"
      type: number
      sql: ${TABLE}.rating_booster ;;
    }

    dimension: tco_track {
      label: "TCO Track"
      description: "track"
      type: string
      sql: ${TABLE}.tco_track ;;
    }

    dimension: tco_sub_track {
      label: "TCO Sub Track"
      description: "Sub track"
      type: string
      sql: ${TABLE}.tco_sub_track ;;
    }

    dimension: tco_contest_name {
      label: "TCO Contest Name"
      description: "Name of the contest"
      type: string
      sql: ${TABLE}.tco_contest_name ;;
    }

    measure: tco_points {
      label: "TCO Points"
      type: sum
      description: "Computed TCO points"
      value_format: "#,##0"
      sql:  CASE
                WHEN ${TABLE}.raw_points IS NOT NULL THEN (${TABLE}.raw_points * (ISNULL(${TABLE}.rating_booster, 1)))
                WHEN ${TABLE}.fixed_score IS NOT NULL THEN ${TABLE}.fixed_score
                ELSE (${TABLE}.total_prize) * (${TABLE}.percentage) * (ISNULL(${TABLE}.rating_booster, 1))
          END;;
    }

    measure: tco23_points {
      label: "TCO23 Points"
      type: sum
      description: "Computed TCO23 points"
      value_format: "#,##0.00"
      sql: CASE
              WHEN ${TABLE}.fixed_score IS NOT NULL THEN ${TABLE}.fixed_score
              ELSE ROUND(${TABLE}.total_prize * ((${num_submissions_passed_review} - ${placement} + 1)/${num_submissions_passed_review}) * (${final_score}/${max_score}), 1)
           END;;
    }

    dimension:status_desc  {
      hidden: yes
      sql: ${TABLE}.status_desc ;;
      description: "Challenge Status Description"
    }


    measure: fulfillment {
      type: number
      value_format_name: percent_2
      description: "Copilot Fulfilment applicable only to Copilot Track. Completed Challenges / All Challenges"
      sql: (1.0 * ${completed_challenges}) / NULLIF(${applicable_challenges}, 0)  ;;
    }

    measure: completed_challenges {
      type: count
      hidden: yes
      filters: {
        field: status_desc
        value: "Completed"
      }
    }

    measure: applicable_challenges {
      type: count
      hidden: yes
      filters: {
        field: status_desc
        value: "-Cancelled - Client Request" #Exclude Cancelled Client Request challenges
      }
    }

   measure: count {
      type: count
      description: "Leaderboard record count"
      drill_fields: [detail*]
   }

   measure: challenge_count {
      description: "Challenge Count"
      type: count_distinct
      sql: CASE
               WHEN ${TABLE}.raw_points != 0 OR ${TABLE}.fixed_score != 0 OR ( ${TABLE}.total_prize !=0 AND ${TABLE}.percentage !=0 )  THEN
                  CASE
                      WHEN ${TABLE}.challenge_id IS NOT NULL THEN ${TABLE}.challenge_id
                      ELSE ${TABLE}.round_id::varchar
                  END
            END
                ;;
   }


    set: detail {
      fields: [
        challenge_id,
        user_id,
        total_score,
        round_id,
        created_at_time,
        updated_at_time,
        contest_id,
        placement,
        total_prize,
        percentage,
        raw_points,
        fixed_score,
        rating_booster,
      ]
    }
  }
