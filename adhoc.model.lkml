connection: "prod_-_topcoder_redshift"

include: "*.view.lkml"                       # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

###########################################################################################
## This is a temporary model used to store temporary tables and looks
## This views are created for admin use only and should not be exposed to normal users as is
###########################################################################################

#for fiscal year
fiscal_month_offset: -9

 explore: dec_give_away_submission {
   join: member_profile_basic {
    relationship: many_to_one
     sql_on: ${member_profile_basic.user_id} = ${dec_give_away_submission.user_id};;
    }
 }

#Added back to check for schedule
explore: project_scorecard {
  label: "New Project Scorecards"
  description: "New Project that are launched with other scorecards"
  join: challenge {
    type: left_outer
    sql_on: ${project_scorecard.project_id} = ${challenge.challenge_id} ;;
    relationship: one_to_one

  }
}


explore: copilot_self_payment {}

# Find all Reviews for a submission to help detect duplicates
explore: duplicate_review {
  label: "Detect Duplicate Review"
  description: "Detects if there are duplicate reviews created, Used to alert the support team"
  join: submission {
    type: inner
    sql_on: ${submission.submission_id} = ${duplicate_review.submission_id} ;;
    relationship: one_to_one
  }

}

# Find the dmz submissions
explore: dmz_submission {
  label: "Detect Dmz Submission"
  join: submission {
    type: left_outer
    sql_on:  ${dmz_submission.challenge_id} = ${submission.project_id} ;;
    relationship: many_to_one
  }

}

#Join Submission with Challenge to see Challenge details and Submission
explore: challenge {
  label: "Challenge Submissions"
  description: "Challenge with Informix Submissions"
  join: submission {
    type: inner
    sql_on: ${challenge.project_id} = ${submission.project_id} ;;
    relationship: one_to_many
  }
  join: user {
    type: inner
    sql_on: ${submission.submitter_id} = ${user.coder_id} ;;
    relationship: one_to_one
  }
}

#Added on 13th March 2019
explore: budget_threshold {}

explore: direct_budget {
  join:  user_payment{
    type: inner
    sql_on: ${direct_budget.payment_id} = ${user_payment.payment_id} ;;
    relationship: one_to_one
  }
  join: challenge {
    type: left_outer
    sql_on: ${direct_budget.reference_id} = ${challenge.project_id} ;;
    relationship: one_to_many
  }
  join: direct_project_dim {
    type: left_outer
    sql_on: ${challenge.tc_direct_project_id} = ${direct_project_dim.direct_project_id} ;;
    relationship: one_to_many
  }
  join: challenge_groups {
    type: left_outer
    sql_on: ${challenge.project_id} = ${challenge_groups.challenge_id} ;;
    relationship: one_to_one
  }
}

explore: duplicate_resource {
  label: "Detect Duplicate Resource"
  description: "Duplicate Resources assigned on a project"
  join: challenge {
    type: left_outer
    sql_on: ${duplicate_resource.challenge_id} = ${challenge.project_id} ;;
    relationship: many_to_one
  }
  join: user {
    type: left_outer
    sql_on: ${duplicate_resource.user_id} = ${user.coder_id} ;;
    relationship: one_to_one
  }

}

#added the problem_submission,system_test_case,system_test_result view of srm at 1st Jule 2019

explore: problem_submission {}

explore: system_test_case {}

explore: system_test_result {}


#Added adhoc explore for winner handles verification

explore: challenge_stats{

  join: member_verification {
    type: left_outer
    sql_on: ${challenge_stats.winner_id}=${member_verification.user_id} ;;
    relationship: many_to_one
  }
}
