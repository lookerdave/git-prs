- view: lexi
  derived_table:
    sql: |
       SELECT d.displayname, d.equipmenttype, d.deviceidint, (EXTRACT(epoch from current_date)-d.lasttotalconnecttime)/86400 AS dayswithoutconnection,  loc.groupid AS loc
          FROM
        (SELECT d.accountid, d.deviceid, d.displayname, d.deviceidint, d.isactive, d.equipmenttype, d.lasttotalconnecttime FROM Device d ) d,
        (SELECT l.deviceidint,  l.groupid FROM DeviceList l, DeviceGroup g WHERE l.groupidint=g.groupidint and l.groupid LIKE 'loc%')  loc  
        WHERE   loc.deviceidint=d.deviceidint  and accountid='avista'
  
  fields:
  - measure: count
    type: count
    drill_fields: detail*

  - dimension: displayname
    type: string
    sql: ${TABLE}.displayname
    label: "Unit Number"   

  - dimension: equipmenttype
    type: string
    sql: ${TABLE}.equipmenttype
    hidden: false
    label: "Year/Make/Model" 

  - dimension: vehicle_class
    sql_case:
      Truck: ${equipmenttype} = '2011 Chevrolet 1500'
        OR ${equipmenttype} = '2012 Chevrolet 1500'
      SUV: ${equipmenttype} = '2010 GMC Yukon'
      other: true
#     html: |
#      <a href="/embed/explore/avista/equipment?fields=vehicle_summary.displayname,equipment.vehicle_class, equipment.equipmenttype, equipment.location, vehicle_summary.datename_date, vehicle_summary.usedsum, vehicle_summary.odometersum,  vehicle_summary.enginesum, vehicle_summary.drivingsum, vehicle_summary.idlesumnopto,,vehicle_summary.idlepercentagewithoutpto&f[vehicle_summary.datename_date]=last+30+days&f[vehicle_summary.vehicle_class]={{vehicle_summary.vehicle_class._value}}">{{value }}</a>
#     
  - dimension: deviceidint
    type: number
    sql: ${TABLE}.deviceidint
    hidden: true

  - dimension: loc
    sql: ${TABLE}.loc
    hidden: true
    
  - dimension: location
    sql_case:
      Spokane: ${loc} = 'loc-spokane'
      other: true
#     html: |
#      <a href="/embed/explore/avista/equipment?fields=vehicle_summary.displayname,equipment.vehicle_class, equipment.equipmenttype, equipment.location, vehicle_summary.datename_date, vehicle_summary.usedsum, vehicle_summary.odometersum,  vehicle_summary.enginesum, vehicle_summary.drivingsum, vehicle_summary.idlesumnopto,,vehicle_summary.idlepercentagewithoutpto&f[vehicle_summary.datename_date]=last+30+days&f[vehicle_summary.location]={{vehicle_summary.location._value}}">{{value }}</a>
#     
   
  - dimension: dayswithoutconnection
    type: number
    sql: ${TABLE}.dayswithoutconnection

  - dimension: filtering
    type: number  
    sql: |
      CASE
      WHEN ${dayswithoutconnection}>30 THEN 1
      ELSE 0 END
    hidden: true
    
  - dimension: commfilter
    sql_case:
      Not Communicating over 30 days: ${filtering} = 1
      Communicating: ${filtering} = 0
    label: "Non-Communication Filter"
    description: "Filter for unit not communicating > 30 days"   

  - dimension: groupid
    type: string
    sql: ${TABLE}.groupid
    hidden: true

  - dimension: creationtime
    type: number
    sql: ${TABLE}.creationtime


  sets:
    detail:
      - equipmenttype
      - dayswithoutconnection
      - groupid
      - creationtime
      - displayname
      

