- view: negz
  # # You can specify the table name if it's different from the view name:
  # sql_table_name: my_schema_name.negz
  #
  # # Define your dimensions and measures here, like this:
  # fields:
  #   - dimension: id
  #     description: "The unique ID for each order"
  #     type: number
  #     sql: ${TABLE}.id
  #
  #   - dimension_group: created
  #     description: "Transaction created date"
  #     type: time
  #     timeframes: [date, week, month, year]
  #     sql: ${TABLE}.created_at
  #
  #   - measure: count
  #     description: "Count of orders"
  #     type: count

# - view: negz
  # Or, you could make this view a derived table, like this:
  derived_table:
    sql: |
      SELECT
        1 as id
        , -.02 as lifetime_orders
        , '2012-01-01 00:00:00' as time
      UNION
      SELECT
        2 as id
        , -.03 as lifetime_orders
        , '2012-02-01 00:00:00' as time
      UNION
      SELECT
        3 as id
        , -.04 as lifetime_orders
        , '2012-03-01 00:00:00' as time
      

#   # Define your dimensions and measures here, like this:
  fields:
    - dimension: id
      description: "Unique ID for each user that has ordered"
      type: number
      sql: ${TABLE}.id

    - measure: lifetime_orders
      description: "The total number of orders for each user"
      type: number
      sql: ${TABLE}.lifetime_orders

    - dimension_group: most_recent_purchase
      description: "The date when each user last ordered"
      type: time
      timeframes: [month]
      sql: ${TABLE}.time

#     - measure: total_lifetime_orders
#       description: "Use this for counting lifetime orders across many users"
#       type: sum
#       sql: ${lifetime_orders}
