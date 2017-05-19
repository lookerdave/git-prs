- view: inventory_items
  sql_table_name: demo_db.inventory_items
  fields:

  - dimension: id
    group_label: 'Foo'
    label: ' ID'
    primary_key: true
    type: number
    sql: ${TABLE}.id

  - dimension: cost
    group_label: 'Foo'
    label: 'Cost'
    type: number
    sql: ${TABLE}.cost

  - dimension_group: created
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.created_at

  - dimension: product_id
    group_label: 'Foo'
    label: '  PID'
    type: number
    # hidden: true
    sql: ${TABLE}.product_id

  - dimension_group: sold
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.sold_at

  - measure: count
    type: count
    drill_fields: [id, products.item_name, products.id, order_items.count, t1.count]

