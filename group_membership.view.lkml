view: group_membership {
  sql_table_name: "authorization".group_membership
    ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: createdat {
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
    sql: ${TABLE}.createdat ;;
  }

  dimension: createdby {
    type: number
    sql: ${TABLE}.createdby ;;
  }

  dimension: group_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.group_id ;;
  }

  dimension: group_name {
    type: string
    hidden: yes
    sql: ${TABLE}.group_name ;;
  }

  dimension: membership_type {
     type: string
     description: "If the Member Id is of user or group"
      sql: CASE
    WHEN ${TABLE}.membership_type = 1
        THEN 'User'
    WHEN ${TABLE}.membership_type = 2
        THEN 'Group'
    ELSE
         'Unknown'
    END;;
  }

  dimension: member_name {
    type: string
    hidden: yes
    description: "Member name for the groups are populated"
    sql: ${TABLE}.member_name;;
  }

  dimension: member_id {
    type: number
    sql: ${TABLE}.member_id ;;
  }

  dimension: membership_type_ind {
    type: number
    description: "Numeric field to indicate if the member is of type user or group. 1 is member and 2 is group"
    sql: ${TABLE}.membership_type ;;
  }

  dimension_group: modifiedat {
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
    sql: ${TABLE}.modifiedat ;;
  }

  dimension: modifiedby {
    type: number
    sql: ${TABLE}.modifiedby ;;
  }

  measure: count {
    type: count
    drill_fields: [id, group.id, group.name]
  }
}
