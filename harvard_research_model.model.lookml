- connection: prod_-_topcoder_redshift

- include: "*.view.lookml"       # include all views in this project
- include: "*.dashboard.lookml"  # include all dashboards in this project

- week_start_day: sunday    # sets the week start day to Sunday


- explore: challenge
  fields: [ALL_FIELDS*, -copilot.email, -user.email, -creator.email, -manager.email, -launcher.email]
  joins:
    - join: client_project_dim
      type: left_outer 
      sql_on: ${client_project_dim.client_project_id} = ${challenge.client_project_id}
      relationship: many_to_one
    - join: direct_project_dim
      type: left_outer 
      sql_on:  ${challenge.tc_direct_project_id} = ${direct_project_dim.direct_project_id}
      relationship: many_to_one
    - join: connect_project
      type: left_outer 
      sql_on: ${direct_project_dim.direct_project_id} = ${connect_project.directprojectid}
      relationship: many_to_one
    - join: copilot
      from: user
      type: left_outer 
      sql_on: ${challenge.copilot_id} = ${copilot.coder_id}
      relationship: many_to_one
    - join: creator
      from: user
      type: left_outer 
      sql_on: ${challenge.challenge_creator_id} = ${creator.coder_id}
      relationship: many_to_one
    - join: manager
      from: user
      type: left_outer 
      sql_on: ${challenge.challenge_manager_id} = ${manager.coder_id}
      relationship: many_to_one
    - join: launcher
      from: user
      type: left_outer 
      sql_on: ${challenge.challenge_launcher_id} = ${launcher.coder_id}
      relationship: many_to_one
    - join: contest_project_xref
      type: left_outer 
      sql_on: ${challenge.project_id} = ${contest_project_xref.project_id}
      relationship: many_to_one
    - join: contest
      type: left_outer
      sql_on: ${contest.contest_id} = ${contest_project_xref.contest_id}
      relationship: many_to_one
    - join: event
      type: left_outer 
      sql_on: ${contest.event_id} = ${event.event_id}
      relationship: many_to_one
      

- explore: project_result
  fields: [ALL_FIELDS*, -copilot.email, -user.email, -creator.email, -manager.email, -launcher.email]
  joins:
    - join: challenge
      type: left_outer 
      sql_on: ${project_result.project_id} = ${challenge.project_id}
      relationship: many_to_one
    - join: submitter
      from: user
      type: inner 
      sql_on: ${project_result.user_id} = ${submitter.coder_id}
      relationship: many_to_one
    - join: country
      type: left_outer
      sql_on: ${submitter.comp_country_code} = ${country.country_code}
      relationship: many_to_one      
    - join: client_project_dim
      type: left_outer 
      sql_on: ${client_project_dim.client_project_id} = ${challenge.client_project_id}
      relationship: many_to_one
    - join: direct_project_dim
      type: left_outer 
      sql_on:  ${challenge.tc_direct_project_id} = ${direct_project_dim.direct_project_id}
      relationship: many_to_one
    - join: connect_project
      type: left_outer 
      sql_on: ${direct_project_dim.direct_project_id} = ${connect_project.directprojectid}
      relationship: many_to_one
    - join: copilot
      from: user
      type: left_outer 
      sql_on: ${challenge.copilot_id} = ${copilot.coder_id}
      relationship: many_to_one
    - join: creator
      from: user
      type: left_outer 
      sql_on: ${challenge.challenge_creator_id} = ${creator.coder_id}
      relationship: many_to_one
    - join: manager
      from: user
      type: left_outer 
      sql_on: ${challenge.challenge_manager_id} = ${manager.coder_id}
      relationship: many_to_one
    - join: launcher
      from: user
      type: left_outer 
      sql_on: ${challenge.challenge_launcher_id} = ${launcher.coder_id}
      relationship: many_to_one

- explore: design_project_result
  fields: [ALL_FIELDS*, -copilot.email, -user.email, -creator.email, -manager.email, -launcher.email, -submitter.email]
  joins:
    - join: challenge
      type: left_outer 
      sql_on: ${design_project_result.project_id} = ${challenge.project_id}
      relationship: many_to_one
    - join: submitter
      from: user
      type: inner 
      sql_on: ${design_project_result.user_id} = ${submitter.coder_id}
      relationship: many_to_one
    - join: submitter_country
      from: country
      type: left_outer
      sql_on: ${submitter.comp_country_code} = ${submitter_country.country_code}
      relationship: many_to_one 
    - join: client_project_dim
      type: left_outer 
      sql_on: ${client_project_dim.client_project_id} = ${challenge.client_project_id}
      relationship: many_to_one
    - join: direct_project_dim
      type: left_outer 
      sql_on:  ${challenge.tc_direct_project_id} = ${direct_project_dim.direct_project_id}
      relationship: many_to_one
    - join: connect_project
      type: left_outer 
      sql_on: ${direct_project_dim.direct_project_id} = ${connect_project.directprojectid}
      relationship: many_to_one
    - join: copilot
      from: user
      type: left_outer 
      sql_on: ${challenge.copilot_id} = ${copilot.coder_id}
      relationship: many_to_one
    - join: creator
      from: user
      type: left_outer 
      sql_on: ${challenge.challenge_creator_id} = ${creator.coder_id}
      relationship: many_to_one
    - join: manager
      from: user
      type: left_outer 
      sql_on: ${challenge.challenge_manager_id} = ${manager.coder_id}
      relationship: many_to_one
    - join: launcher
      from: user
      type: left_outer 
      sql_on: ${challenge.challenge_launcher_id} = ${launcher.coder_id}
      relationship: many_to_one


