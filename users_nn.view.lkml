view: users_nn {
  derived_table: {
    sql:
    SELECT 1 AS ID, 'Aaron' as first_name
    UNION ALL
    SELECT 1 AS ID, 'Aaron' as first_name
    UNION ALL
    SELECT 1 AS ID, 'Aaron' as first_name
    UNION ALL
    SELECT 9999 AS ID, 'Voldemort' as first_name ;;

    indexes: ["ID"]
    persist_for: "24 hours"
  }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

}
