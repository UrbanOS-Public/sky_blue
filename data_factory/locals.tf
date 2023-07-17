locals {
  linked_custom_service = {
    "fdot"                = {
      linked_type         = "HttpServer"
      linked_service_name = "fdot"
      baseUrl             = "https://gis.fdot.gov/"
    }
    "arcgis"              = {
      linked_type         = "HttpServer"
      linked_service_name = "arcgis"
      baseUrl             = "https://services1.arcgis.com/"
    }
    "flarisRestService"   = {
      linked_type         = "RestService"
      linked_service_name = "flarisRestService"
      baseUrl             = "https://gis.fdot.gov/"
    }  
    "openmeteoRestService"   = {
      linked_type         = "RestService"
      linked_service_name = "openmeteoRestService"
      baseUrl             = "https://archive-api.open-meteo.com/"
    } 
    "openmeteo"   = {
      linked_type         = "HttpServer"
      linked_service_name = "openmeteo"
      baseUrl             = "https://archive-api.open-meteo.com/"
    }  
  }
  custom_data = {
    "bikes_data_json" = {
      linked_service = "arcgis"
      relativeUrl = "O1JpcwDW8sjYuddV/arcgis/rest/services/USBikeRoutesFlorida/FeatureServer/0/query?where=%20(FDOTCOID%20%3D%2086%20OR%20FDOTCOID%20%3D%2067)%20&outFields=*&outSR=4326&f=json"
      data_type = "Json"
    }    
    "boundaries_data_json" = {
      linked_service = "arcgis"
      relativeUrl = "O1JpcwDW8sjYuddV/arcgis/rest/services/Florida_County_Boundaries_with_FDOT_Districts/FeatureServer/0/query?where=FDOTCountyCode%20%3D%20%2786%27&outFields=*&outSR=4326&f=json"
      data_type = "Json"
    }
    "active_projects_data_json" = {
      linked_service = "fdot"
      relativeUrl = "arcgis/rest/services/Active_Construction_Projects/FeatureServer/0/query?where=County%3D%27Broward%27&objectIds=&time=&geometry=&geometryType=esriGeometryEnvelope&inSR=&spatialRel=esriSpatialRelIntersects&distance=&units=esriSRUnit_Meter&relationParam=&outFields=*&returnGeometry=true&maxAllowableOffset=&geometryPrecision=&outSR=&havingClause=&gdbVersion=&historicMoment=&returnDistinctValues=false&returnIdsOnly=false&returnCountOnly=false&returnExtentOnly=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&returnZ=false&returnM=false&multipatchOption=xyFootprint&resultOffset=&resultRecordCount=&returnTrueCurves=false&returnExceededLimitFeatures=false&quantizationParameters=&returnCentroid=false&timeReferenceUnknownClient=false&sqlFormat=none&resultType=&featureEncoding=esriDefault&datumTransformation=&f=pjson"
      data_type = "Json"
    }
    "aadt_data_json" = {
      linked_service = "arcgis"
      relativeUrl = "O1JpcwDW8sjYuddV/arcgis/rest/services/Annual_Average_Daily_Traffic_TDA/FeatureServer/0/query?where=COUNTYDOT%3D86&objectIds=&time=&geometry=&geometryType=esriGeometryEnvelope&inSR=&spatialRel=esriSpatialRelIntersects&resultType=none&distance=0.0&units=esriSRUnit_Meter&relationParam=&returnGeodetic=false&outFields=*&returnGeometry=true&featureEncoding=esriDefault&multipatchOption=xyFootprint&maxAllowableOffset=&geometryPrecision=&outSR=&defaultSR=&datumTransformation=&applyVCSProjection=false&returnIdsOnly=false&returnUniqueIdsOnly=false&returnCountOnly=false&returnExtentOnly=false&returnQueryGeometry=false&returnDistinctValues=false&cacheHint=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&having=&resultOffset=&resultRecordCount=100000&returnZ=false&returnM=false&returnExceededLimitFeatures=true&quantizationParameters=&sqlFormat=none&f=pjson&token="
      data_type = "Json"
    }    
    "intersection_data_json" = {
      linked_service = "arcgis"
      relativeUrl = "O1JpcwDW8sjYuddV/arcgis/rest/services/Intersection_TDA/FeatureServer/0/query?where=1%3D1&outFields=*&outSR=4326&f=json"
      data_type = "Json"
    }
    "traffic_signal_locations_json" = {
      linked_service = "arcgis"
      relativeUrl = "O1JpcwDW8sjYuddV/arcgis/rest/services/Traffic_Signal_Locations_TDA/FeatureServer/0/query?where=COUNTYDOT%20%3D%20'86'&outFields=*&outSR=4326&f=json"
      data_type = "Json"
    } 
    "weather_data_json_2017" = {
      linked_service = "openmeteo"
      relativeUrl = "v1/archive?latitude=26.100412&longitude=-80.130704&start_date=2017-01-01&end_date=2017-12-31&hourly=temperature_2m,relativehumidity_2m,precipitation,rain,weathercode,windspeed_10m,winddirection_10m,windgusts_10m&temperature_unit=fahrenheit&windspeed_unit=mph&timezone=America%2FNew_York"
      data_type = "RestResource"
    }
    "weather_data_json_2018" = {
      linked_service = "openmeteo"
      relativeUrl = "v1/archive?latitude=26.100412&longitude=-80.130704&start_date=2018-01-01&end_date=2018-12-31&hourly=temperature_2m,relativehumidity_2m,precipitation,rain,weathercode,windspeed_10m,winddirection_10m,windgusts_10m&temperature_unit=fahrenheit&windspeed_unit=mph&timezone=America%2FNew_York"
      data_type = "Json"
    }
    "weather_data_json_2019" = {
      linked_service = "openmeteo"
      relativeUrl = "v1/archive?latitude=26.100412&longitude=-80.130704&start_date=2019-01-01&end_date=2019-12-31&hourly=temperature_2m,relativehumidity_2m,precipitation,rain,weathercode,windspeed_10m,winddirection_10m,windgusts_10m&temperature_unit=fahrenheit&windspeed_unit=mph&timezone=America%2FNew_York"
      data_type = "Json"
    }
    "weather_data_json_2020" = {
      linked_service = "openmeteo"
      relativeUrl = "v1/archive?latitude=26.100412&longitude=-80.130704&start_date=2020-01-01&end_date=2020-12-31&hourly=temperature_2m,relativehumidity_2m,precipitation,rain,weathercode,windspeed_10m,winddirection_10m,windgusts_10m&temperature_unit=fahrenheit&windspeed_unit=mph&timezone=America%2FNew_York"
      data_type = "Json"
    } 
    "weather_data_json_2021" = {
      linked_service = "openmeteo"
      relativeUrl = "v1/archive?latitude=26.100412&longitude=-80.130704&start_date=2021-01-01&end_date=2021-12-31&hourly=temperature_2m,relativehumidity_2m,precipitation,rain,weathercode,windspeed_10m,winddirection_10m,windgusts_10m&temperature_unit=fahrenheit&windspeed_unit=mph&timezone=America%2FNew_York"
      data_type = "Json"
    }
    "weather_data_json_2022" = {
      linked_service = "openmeteo"
      relativeUrl = "v1/archive?latitude=26.100412&longitude=-80.130704&start_date=2022-01-01&end_date=2022-12-31&hourly=temperature_2m,relativehumidity_2m,precipitation,rain,weathercode,windspeed_10m,winddirection_10m,windgusts_10m&temperature_unit=fahrenheit&windspeed_unit=mph&timezone=America%2FNew_York"
      data_type = "Json"
    } 
    "weather_data_json_2023" = {
      linked_service = "openmeteo"
      relativeUrl = "@concat('v1/archive?latitude=26.100412&longitude=-80.130704&hourly=temperature_2m,relativehumidity_2m,precipitation,rain,weathercode,windspeed_10m,winddirection_10m,windgusts_10m&temperature_unit=fahrenheit&windspeed_unit=mph&timezone=America%2FNew_York&start_date=2023-01-01&end_date=',formatDateTime(utcnow(), 'yyyy-MM-dd'))"
      data_type = "Json"
    }   
    "weather_data_json_all" = {
      linked_service = "openmeteo"
      relativeUrl = "@concat('v1/archive?latitude=26.100412&longitude=-80.130704&hourly=temperature_2m,relativehumidity_2m,precipitation,rain,weathercode,windspeed_10m,winddirection_10m,windgusts_10m&temperature_unit=fahrenheit&windspeed_unit=mph&timezone=America%2FNew_York&start_date=2017-01-01&end_date=',formatDateTime(utcnow(), 'yyyy-MM-dd'))"
      data_type = "Json"
    }   
  }

  custom_data_rest = {
    "FLARIS_Intersections" = {
      linked_service = "flarisRestService"
      relativeUrl = "arcgis/rest/services/sso/ssogis_flaris/FeatureServer/3/query?where=DOT_CNTY_CD%3D86&objectIds=&time=&geometry=&geometryType=esriGeometryEnvelope&inSR=&spatialRel=esriSpatialRelIntersects&distance=&units=esriSRUnit_Foot&relationParam=&outFields=*&returnGeometry=true&maxAllowableOffset=&geometryPrecision=&outSR=&havingClause=&gdbVersion=&historicMoment=&returnDistinctValues=false&returnIdsOnly=false&returnCountOnly=false&returnExtentOnly=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&returnZ=false&returnM=false&multipatchOption=xyFootprint&resultOffset={offset}&resultRecordCount=5000&returnTrueCurves=false&returnExceededLimitFeatures=false&quantizationParameters=&returnCentroid=false&timeReferenceUnknownClient=false&sqlFormat=none&resultType=&featureEncoding=esriDefault&datumTransformation=&f=pjson"
      data_type = "RestResource"
    } 
    "crash_data_json_2017" = {
      linked_service = "flarisRestService"
      relativeUrl = "arcgis/rest/services/sso/ssogis/FeatureServer/11/query?where=DOT_CNTY_CD%3D86+AND+CALENDAR_YEAR%3D2017&objectIds=&time=&geometry=&geometryType=esriGeometryEnvelope&inSR=&spatialRel=esriSpatialRelIntersects&distance=&units=esriSRUnit_Foot&relationParam=&outFields=*&returnGeometry=true&maxAllowableOffset=5&geometryPrecision=&outSR=&havingClause=&gdbVersion=&historicMoment=&returnDistinctValues=false&returnIdsOnly=false&returnCountOnly=false&returnExtentOnly=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&returnZ=false&returnM=false&multipatchOption=xyFootprint&resultOffset={offset}&resultRecordCount=5000&returnTrueCurves=false&returnExceededLimitFeatures=false&quantizationParameters=&returnCentroid=false&timeReferenceUnknownClient=false&sqlFormat=none&resultType=&featureEncoding=esriDefault&datumTransformation=&f=pjson"
      data_type = "RestResource"
    } 
    "crash_data_json_2018" = {
      linked_service = "flarisRestService"
      relativeUrl = "arcgis/rest/services/sso/ssogis/FeatureServer/11/query?where=DOT_CNTY_CD%3D86+AND+CALENDAR_YEAR%3D2018&objectIds=&time=&geometry=&geometryType=esriGeometryEnvelope&inSR=&spatialRel=esriSpatialRelIntersects&distance=&units=esriSRUnit_Foot&relationParam=&outFields=*&returnGeometry=true&maxAllowableOffset=5&geometryPrecision=&outSR=&havingClause=&gdbVersion=&historicMoment=&returnDistinctValues=false&returnIdsOnly=false&returnCountOnly=false&returnExtentOnly=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&returnZ=false&returnM=false&multipatchOption=xyFootprint&resultOffset={offset}&resultRecordCount=5000&returnTrueCurves=false&returnExceededLimitFeatures=false&quantizationParameters=&returnCentroid=false&timeReferenceUnknownClient=false&sqlFormat=none&resultType=&featureEncoding=esriDefault&datumTransformation=&f=pjson"
      data_type = "RestResource"
    } 
    "crash_data_json_2019" = {
      linked_service = "flarisRestService"
      relativeUrl = "arcgis/rest/services/sso/ssogis/FeatureServer/11/query?where=DOT_CNTY_CD%3D86+AND+CALENDAR_YEAR%3D2019&objectIds=&time=&geometry=&geometryType=esriGeometryEnvelope&inSR=&spatialRel=esriSpatialRelIntersects&distance=&units=esriSRUnit_Foot&relationParam=&outFields=*&returnGeometry=true&maxAllowableOffset=5&geometryPrecision=&outSR=&havingClause=&gdbVersion=&historicMoment=&returnDistinctValues=false&returnIdsOnly=false&returnCountOnly=false&returnExtentOnly=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&returnZ=false&returnM=false&multipatchOption=xyFootprint&resultOffset={offset}&resultRecordCount=5000&returnTrueCurves=false&returnExceededLimitFeatures=false&quantizationParameters=&returnCentroid=false&timeReferenceUnknownClient=false&sqlFormat=none&resultType=&featureEncoding=esriDefault&datumTransformation=&f=pjson"
      data_type = "RestResource"
    } 
    "crash_data_json_2020" = {
      linked_service = "flarisRestService"
      relativeUrl = "arcgis/rest/services/sso/ssogis/FeatureServer/11/query?where=DOT_CNTY_CD%3D86+AND+CALENDAR_YEAR%3D2020&objectIds=&time=&geometry=&geometryType=esriGeometryEnvelope&inSR=&spatialRel=esriSpatialRelIntersects&distance=&units=esriSRUnit_Foot&relationParam=&outFields=*&returnGeometry=true&maxAllowableOffset=5&geometryPrecision=&outSR=&havingClause=&gdbVersion=&historicMoment=&returnDistinctValues=false&returnIdsOnly=false&returnCountOnly=false&returnExtentOnly=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&returnZ=false&returnM=false&multipatchOption=xyFootprint&resultOffset={offset}&resultRecordCount=5000&returnTrueCurves=false&returnExceededLimitFeatures=false&quantizationParameters=&returnCentroid=false&timeReferenceUnknownClient=false&sqlFormat=none&resultType=&featureEncoding=esriDefault&datumTransformation=&f=pjson"
      data_type = "RestResource"
    } 
    "crash_data_json_2021" = {
      linked_service = "flarisRestService"
      relativeUrl = "arcgis/rest/services/sso/ssogis/FeatureServer/11/query?where=DOT_CNTY_CD%3D86+AND+CALENDAR_YEAR%3D2021&objectIds=&time=&geometry=&geometryType=esriGeometryEnvelope&inSR=&spatialRel=esriSpatialRelIntersects&distance=&units=esriSRUnit_Foot&relationParam=&outFields=*&returnGeometry=true&maxAllowableOffset=5&geometryPrecision=&outSR=&havingClause=&gdbVersion=&historicMoment=&returnDistinctValues=false&returnIdsOnly=false&returnCountOnly=false&returnExtentOnly=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&returnZ=false&returnM=false&multipatchOption=xyFootprint&resultOffset={offset}&resultRecordCount=5000&returnTrueCurves=false&returnExceededLimitFeatures=false&quantizationParameters=&returnCentroid=false&timeReferenceUnknownClient=false&sqlFormat=none&resultType=&featureEncoding=esriDefault&datumTransformation=&f=pjson"
      data_type = "RestResource"
    } 
    "crash_data_json_2022" = {
      linked_service = "flarisRestService"
      relativeUrl = "arcgis/rest/services/sso/ssogis/FeatureServer/11/query?where=DOT_CNTY_CD%3D86+AND+CALENDAR_YEAR%3D2022&objectIds=&time=&geometry=&geometryType=esriGeometryEnvelope&inSR=&spatialRel=esriSpatialRelIntersects&distance=&units=esriSRUnit_Foot&relationParam=&outFields=*&returnGeometry=true&maxAllowableOffset=5&geometryPrecision=&outSR=&havingClause=&gdbVersion=&historicMoment=&returnDistinctValues=false&returnIdsOnly=false&returnCountOnly=false&returnExtentOnly=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&returnZ=false&returnM=false&multipatchOption=xyFootprint&resultOffset={offset}&resultRecordCount=5000&returnTrueCurves=false&returnExceededLimitFeatures=false&quantizationParameters=&returnCentroid=false&timeReferenceUnknownClient=false&sqlFormat=none&resultType=&featureEncoding=esriDefault&datumTransformation=&f=pjson"
      data_type = "RestResource"
    }
    "crash_data_json_all" = {
      linked_service = "flarisRestService"
      relativeUrl = "arcgis/rest/services/sso/ssogis/FeatureServer/11/query?where=DOT_CNTY_CD%3D86&objectIds=&time=&geometry=&geometryType=esriGeometryEnvelope&inSR=&spatialRel=esriSpatialRelIntersects&distance=&units=esriSRUnit_Foot&relationParam=&outFields=*&returnGeometry=true&maxAllowableOffset=5&geometryPrecision=&outSR=&havingClause=&gdbVersion=&historicMoment=&returnDistinctValues=false&returnIdsOnly=false&returnCountOnly=false&returnExtentOnly=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&returnZ=false&returnM=false&multipatchOption=xyFootprint&resultOffset={offset}&resultRecordCount=5000&returnTrueCurves=false&returnExceededLimitFeatures=false&quantizationParameters=&returnCentroid=false&timeReferenceUnknownClient=false&sqlFormat=none&resultType=&featureEncoding=esriDefault&datumTransformation=&f=pjson"
      data_type = "RestResource"
    }
  } 

  raw_data = {
    "adl_bikes_data_json" = {
      fileName   = "bikeroutes.json"
      folderPath = "fdos"
      fileSystem = "raw"
      data_type  = "Json"
    }    
    "adl_boundaries_data_json" = {
      fileName = "boundaries.json"
      folderPath = "fdos"
      fileSystem = "raw"
      data_type  = "Json"
    }
    "adl_active_projects_data_json" = {
      fileName = "active_projects.json"
      folderPath = "fdos"
      fileSystem = "raw"
      data_type  = "Json"
    }
    "adl_aadt_data_json" = {
      fileName = "aadt.json"
      folderPath = "fdos"
      fileSystem = "raw"
      data_type  = "Json"
    }
    "adl_intersection_data_json" = {
      fileName = "intersection.json"
      folderPath = "fdos"
      fileSystem = "raw"
      data_type  = "Json"
    }
    "adl_intersection_floris_data_json" = {
      fileName = "intersection_floris.json"
      folderPath = "fdos"
      fileSystem = "raw"
      data_type  = "Json"
    }
    "adl_traffic_signal_locations_json" = {
      fileName = "trafficsignal.json"
      folderPath = "fdos"
      fileSystem = "raw"
      data_type  = "Json"
    }
    "adl_crash_data_json_2022" = {
      fileName = "crash2022.json"
      folderPath = "fdos"
      fileSystem = "raw"
      data_type  = "Json"
    }
    "adl_crash_data_json_2021" = {
      fileName = "crash2021.json"
      folderPath = "fdos"
      fileSystem = "raw"
      data_type  = "Json"
    }
    "adl_crash_data_json_2020" = {
      fileName = "crash2020.json"
      folderPath = "fdos"
      fileSystem = "raw"
      data_type  = "Json"
    }
    "adl_crash_data_json_2019" = {
      fileName = "crash2019.json"
      folderPath = "fdos"
      fileSystem = "raw"
      data_type  = "Json"
    }
    "adl_crash_data_json_2018" = {
      fileName = "crash2018.json"
      folderPath = "fdos"
      fileSystem = "raw"
      data_type  = "Json"
    } 
    "adl_crash_data_json_2017" = {
      fileName = "crash2017.json"
      folderPath = "fdos"
      fileSystem = "raw"
      data_type  = "Json"
    } 
    "adl_crash_data_json_all" = {
      fileName = "crash_all.json"
      folderPath = "fdos"
      fileSystem = "raw"
      data_type  = "Json"
    } 
    "adl_FLARIS_Intersections_json" = {
      fileName = "flaris_inter.json"
      folderPath = "fdos"
      fileSystem = "raw"
      data_type  = "Json"
    }    
    "adl_FLARIS_Intersections_csv" = {
      fileName = "flaris_inter.csv"
      folderPath = "fdos"
      fileSystem = "standardized"
      data_type  = "DelimitedText"
    }    
    "adl_FLARIS_geometry_csv" = {
      fileName = "flaris_geo.csv"
      folderPath = "fdos"
      fileSystem = "standardized"
      data_type  = "DelimitedText"
    }
    "adl_crash_data_csv_all" = {
      fileName = "crash_all.csv"
      folderPath = "crash"
      fileSystem = "standardized"
      data_type  = "DelimitedText"
    }
    "adl_weather_data_json_2017" = {
      fileName = "weather2017.json"
      folderPath = "weather"
      fileSystem = "raw"
      data_type  = "Json"
    }   
    "adl_weather_data_json_2018" = {
      fileName = "weather2018.json"
      folderPath = "weather"
      fileSystem = "raw"
      data_type  = "Json"
    }     
    "adl_weather_data_json_2019" = {
      fileName = "weather2019.json"
      folderPath = "weather"
      fileSystem = "raw"
      data_type  = "Json"
    }  
    "adl_weather_data_json_2020" = {
      fileName = "weather2020.json"
      folderPath = "weather"
      fileSystem = "raw"
      data_type  = "Json"
    }
    "adl_weather_data_json_2021" = {
      fileName = "weather2021.json"
      folderPath = "weather"
      fileSystem = "raw"
      data_type  = "Json"
    } 
    "adl_weather_data_json_2022" = {
      fileName = "weather2022.json"
      folderPath = "weather"
      fileSystem = "raw"
      data_type  = "Json"
    }
    "adl_weather_data_json_2023" = {
      fileName = "weather2023.json"
      folderPath = "weather"
      fileSystem = "raw"
      data_type  = "Json"
    }    
    "adl_weather_data_json_all" = {
      fileName = "weather_all.json"
      folderPath = "weather"
      fileSystem = "raw"
      data_type  = "Json"
    } 
  }
  
   data_flow = {
     "data_flow_flaris_i" = {
       fileName   = "data_flow_flaris_i.json"
       source_link = "adl_FLARIS_Intersections_json"
       sink_link  = "adl_FLARIS_Intersections_csv"
       script_lines = [ "source(output(",
 "          exceededTransferLimit as boolean,",
 "          features as (attributes as (AADT_MAJOR as integer, AADT_MAJOR_ROADWAY_ID as string, AADT_MINOR as integer, AADT_MINOR_ROADWAY_ID as string, COMPLEX_INTERSECTION_IND as boolean, CRASH_INTERSECT_CATEGORY_SN as string, DOT_CNTY_CD as short, DOT_GEOG_DIST_CD as short, EV_DAILY_TRAFFIC as integer, EXTRACT_DATE as long, EXT_NUM_SEG as short, GEOMETRY_TYPE as boolean, GEOMETRY_TYPE_ID as short, INTERCHANGE_IND as string, INTERSECTING_ROADWAYID_MPS as string, INTERSECTING_ROAD_NAMES as string, INTERSECTION_KEY as integer, INTERSECTION_MIN_NODE_ID as integer, INTERSECTION_TYPE_ID as string, INT_NUM_SEG as short, MAP_SOURCE as string, MAX_LANES_NO as short, NUM_LEG_ID as short, OBJECTID as integer, ON_OFF_SYSTEM_IND as string, OTHER_SIGN_IND as string, PXID as integer, SIGNALIZED_IND as boolean, STOP_CONTROL_IND as boolean, TOT_NUM_LEG as short, TOT_NUM_NODES as short, TOT_NUM_SEG as short, URBAN_IND as boolean, USPS_CITY_PRIMARY_ID as short, X_UTM as double, YIELD_CONTROL_IND as boolean, Y_UTM as double), geometry as (paths as double[][][]))[],",
 "          fields as (alias as string, length as short, name as string, type as string)[],",
 "          geometryType as string,",
 "          globalIdFieldName as string,",
 "          objectIdFieldName as string,",
 "          spatialReference as (latestWkid as short, wkid as short)",
 "     ),",
 "     allowSchemaDrift: false,",
 "     validateSchema: true,",
 "     limit: 500,",
 "     ignoreNoFilesFound: false,",
 "     documentForm: 'documentPerLine') ~> source1",
 "source1 foldDown(unroll(features),",
 "     mapColumn(",
 "          features",
 "     ),",
 "     skipDuplicateMapInputs: false,",
 "     skipDuplicateMapOutputs: false) ~> flatten1",
 "flatten1 sink(allowSchemaDrift: true,",
 "     validateSchema: false,",
 "     umask: 0022,",
 "     preCommands: [],",
 "     postCommands: [],",
 "     skipDuplicateMapInputs: true,",
 "     skipDuplicateMapOutputs: true,",
 "     mapColumn(",
 "          OBJECTID = features.attributes.OBJECTID,",
 "          INTERSECTION_KEY = features.attributes.INTERSECTION_KEY,",
 "          PXID = features.attributes.PXID,",
 "          COMPLEX_INTERSECTION_IND = features.attributes.COMPLEX_INTERSECTION_IND,",
 "          INTERSECTION_TYPE_ID = features.attributes.INTERSECTION_TYPE_ID,",
 "          INTERCHANGE_IND = features.attributes.INTERCHANGE_IND,",
 "          ON_OFF_SYSTEM_IND = features.attributes.ON_OFF_SYSTEM_IND,",
 "          DOT_GEOG_DIST_CD = features.attributes.DOT_GEOG_DIST_CD,",
 "          DOT_CNTY_CD = features.attributes.DOT_CNTY_CD,",
 "          USPS_CITY_PRIMARY_ID = features.attributes.USPS_CITY_PRIMARY_ID,",
 "          INTERSECTING_ROADWAYID_MPS = features.attributes.INTERSECTING_ROADWAYID_MPS,",
 "          INTERSECTING_ROAD_NAMES = features.attributes.INTERSECTING_ROAD_NAMES,",
 "          INT_NUM_SEG = features.attributes.INT_NUM_SEG,",
 "          EXT_NUM_SEG = features.attributes.EXT_NUM_SEG,",
 "          TOT_NUM_SEG = features.attributes.TOT_NUM_SEG,",
 "          TOT_NUM_LEG = features.attributes.TOT_NUM_LEG,",
 "          TOT_NUM_NODES = features.attributes.TOT_NUM_NODES,",
 "          MAX_LANES_NO = features.attributes.MAX_LANES_NO,",
 "          NUM_LEG_ID = features.attributes.NUM_LEG_ID,",
 "          INTERSECTION_MIN_NODE_ID = features.attributes.INTERSECTION_MIN_NODE_ID,",
 "          X_UTM = features.attributes.X_UTM,",
 "          Y_UTM = features.attributes.Y_UTM,",
 "          EV_DAILY_TRAFFIC = features.attributes.EV_DAILY_TRAFFIC,",
 "          AADT_MAJOR = features.attributes.AADT_MAJOR,",
 "          AADT_MAJOR_ROADWAY_ID = features.attributes.AADT_MAJOR_ROADWAY_ID,",
 "          AADT_MINOR = features.attributes.AADT_MINOR,",
 "          AADT_MINOR_ROADWAY_ID = features.attributes.AADT_MINOR_ROADWAY_ID,",
 "          GEOMETRY_TYPE_ID = features.attributes.GEOMETRY_TYPE_ID,",
 "          GEOMETRY_TYPE = features.attributes.GEOMETRY_TYPE,",
 "          CRASH_INTERSECT_CATEGORY_SN = features.attributes.CRASH_INTERSECT_CATEGORY_SN,",
 "          URBAN_IND = features.attributes.URBAN_IND,",
 "          SIGNALIZED_IND = features.attributes.SIGNALIZED_IND,",
 "          STOP_CONTROL_IND = features.attributes.STOP_CONTROL_IND,",
 "          YIELD_CONTROL_IND = features.attributes.YIELD_CONTROL_IND,",
 "          OTHER_SIGN_IND = features.attributes.OTHER_SIGN_IND,",
 "          MAP_SOURCE = features.attributes.MAP_SOURCE,",
 "          EXTRACT_DATE = features.attributes.EXTRACT_DATE",
 "     )) ~> sink1"]
     }
     "data_flow_flaris_g" = {
       fileName   = "data_flow_flaris_g.json"
       source_link = "adl_FLARIS_Intersections_json"
       sink_link  = "adl_FLARIS_geometry_csv"
       script_lines = ["source(output(",
 "          exceededTransferLimit as boolean,",
 "          features as (attributes as (AADT_MAJOR as integer, AADT_MAJOR_ROADWAY_ID as string, AADT_MINOR as integer, AADT_MINOR_ROADWAY_ID as string, COMPLEX_INTERSECTION_IND as boolean, CRASH_INTERSECT_CATEGORY_SN as string, DOT_CNTY_CD as short, DOT_GEOG_DIST_CD as short, EV_DAILY_TRAFFIC as integer, EXTRACT_DATE as long, EXT_NUM_SEG as short, GEOMETRY_TYPE as boolean, GEOMETRY_TYPE_ID as short, INTERCHANGE_IND as string, INTERSECTING_ROADWAYID_MPS as string, INTERSECTING_ROAD_NAMES as string, INTERSECTION_KEY as integer, INTERSECTION_MIN_NODE_ID as integer, INTERSECTION_TYPE_ID as string, INT_NUM_SEG as short, MAP_SOURCE as string, MAX_LANES_NO as short, NUM_LEG_ID as short, OBJECTID as integer, ON_OFF_SYSTEM_IND as string, OTHER_SIGN_IND as string, PXID as integer, SIGNALIZED_IND as boolean, STOP_CONTROL_IND as boolean, TOT_NUM_LEG as short, TOT_NUM_NODES as short, TOT_NUM_SEG as short, URBAN_IND as boolean, USPS_CITY_PRIMARY_ID as short, X_UTM as double, YIELD_CONTROL_IND as boolean, Y_UTM as double), geometry as (paths as double[][][]))[],",
 "          fields as (alias as string, length as short, name as string, type as string)[],",
 "          geometryType as string,",
 "          globalIdFieldName as string,",
 "          objectIdFieldName as string,",
 "          spatialReference as (latestWkid as short, wkid as short)",
 "     ),",
 "     allowSchemaDrift: false,",
 "     validateSchema: true,",
 "     limit: 500,",
 "     ignoreNoFilesFound: false,",
 "     documentForm: 'documentPerLine') ~> source1",
 "source1 foldDown(unroll(features),",
 "     mapColumn(",
 "          features",
 "     ),",
 "     skipDuplicateMapInputs: false,",
 "     skipDuplicateMapOutputs: false) ~> flatten1",
 "flatten1 foldDown(unroll(features.geometry.paths),",
 "     mapColumn(",
 "          OBJECTID = features.attributes.OBJECTID,",
 "          paths = features.geometry.paths",
 "     ),",
 "     skipDuplicateMapInputs: false,",
 "     skipDuplicateMapOutputs: false) ~> flatten2",
 "flatten2 foldDown(unroll(paths, paths),",
 "     mapColumn(",
 "          OBJECTID,",
 "          paths = paths",
 "     ),",
 "     skipDuplicateMapInputs: false,",
 "     skipDuplicateMapOutputs: false) ~> flatten3",
 "flatten3 sink(allowSchemaDrift: true,",
 "     validateSchema: false,",
 "     umask: 0022,",
 "     preCommands: [],",
 "     postCommands: [],",
 "     skipDuplicateMapInputs: true,",
 "     skipDuplicateMapOutputs: true,",
 "     mapColumn(",
 "          OBJECTID,",
 "          paths",
 "     )) ~> sink1"]
     } 
     "data_flow_crash" = {
       fileName   = "data_flow_crash.json"
       source_link = "adl_crash_data_json_all"
       sink_link  = "adl_crash_data_csv_all"
       script_lines = ["source(output(",
                "          features as (attributes as (AADT_SOURCE as string, ACCLANE as string, ACCSIDRD as string, AGENCY_TYPE_TXT as string, AGE_65_69_IND as boolean, AGE_65_PLUS_IND as boolean, AGE_70_74_IND as boolean, AGE_75_79_IND as boolean, AGE_80_PLUS_IND as boolean, AGE_TEEN_IND as boolean, AGGRESSIVE_DRIVING_IND as boolean, ALCINVCD as short, ARBM_ROADSIDE as string, ARBM_ROAD_STATUS as string, AVERAGE_DAILY_TRAFFIC as integer, BICYCLIST_RELATED_IND as boolean, CALENDAR_YEAR as short, CARSTACD as short, CASE_NUMBER as string, CNTOFLANES as short, COMMERCIAL_VEHICLE_IND as boolean, COUNTY_TXT as string, CRASH_CLASS_IND_MC as string, CRASH_DATE as long, CRASH_NUMBER as integer, CRASH_TIME as short, CRRATECD as short, CRSH_REF_NODE_ID as boolean, CRSH_XTMREF_NOD_ID as boolean, CRSH_XTRREFNODB_ID as boolean, D1_FRST_DR_ACTN_CD as short, D1_FRST_DR_ACTN_CD_TXT as string, D2_FRST_DR_ACTN_CD as short, D2_FRST_DR_ACTN_CD_TXT as string, DAYOWEEK as short, DHSCNTYCTY as short, DHSMV_CTY_CD as short, DHSRDSYS as short, DISTRACTED_DRIVER_IND as boolean, DOT_CNTY_CD as short, DOT_GEOG_DIST_CD as short, DRIVER_ACTION_MC as string, DRIVER_PEDEST_CONDIT_IND_MC as string, DSTNC_TOXTRNOD_NUM as double, DST_TOXTRMNODB_NUM as double, ENVIRNMT1 as short, ENVIRNMT1_TXT as string, ENVIRNMT2 as short, ENVIRNMT2_TXT as string, ENVIRNMT3 as short, ENVIRNMT3_TXT as string, ENVIRONMENT_CONDITION_MC as string, EVNT_WTHR_COND_CD as short, EXTRACT_DATE as long, FRST_HARM_LOC_CD as short, FUNCLASS as short, GEO_URBAN_RURAL_IND as string, IMPAIRED_BICYCLIST_IND as boolean, IMPAIRED_DRIVER_IND as boolean, IMPAIRED_PEDESTRIAN_IND as boolean, IMPCT_TYP_CD as short, INJSEVER as short, INTCT_TYP_CD as short, INTERSECTION_IND as boolean, INT_ROADWAY_NAME as string, INVSTGT_AGCY_CD as short, IN_TOWN_FLAG as boolean, JCT_CD as short, LANE_DEPARTURE_IND as boolean, LATITUDE as double, LAW_ENFRC_PRSNT_CD as short, LGHT_COND_CD as short, LINK_ID as boolean, LOCMP as double, LOC_WTHN_ZONE_CD as short, LONGITUDE as double, MAP_SOURCE as string, MOST_HARM_EVNT_CD as short, MOTORCYCLE_INVOLVED_IND as boolean, NEAREST_NODE_FROM_CRASH as short, NO_BELT_AGE_13_17_IND as boolean, NO_BELT_AGE_1_4_IND as boolean, NO_BELT_AGE_5_12_IND as boolean, NO_BELT_IND as boolean, NUMBER_OF_BICYCLISTS as short, NUMBER_OF_INJURED as short, NUMBER_OF_KILLED as short, NUMBER_OF_PEDESTRIANS as short, NUMBER_OF_SERIOUS_INJURIES as short, NUMBER_OF_VEHICLES as short, OBJECTID as integer, OFFICER_LATITUDE as double, OFFICER_LONGITUDE as double, ON_ROADWAY_NAME as string, PEDESTRIAN_BICYCLIST_IND as boolean, PEDESTRIAN_RELATED_IND as boolean, RCI_AVG_PERC_TRUCK_TRAFF as double, RCI_HORIZ_CURVE_CD as string, RCI_MEDIAN_WIDTH_FT as double, RCI_SHOULDER_TYPE_1 as short, RCI_SHOULDER_TYPE_1_TXT as string, RCI_SHOULDER_TYPE_2 as short, RCI_SHOULDER_TYPE_2_TXT as string, RCI_SHOULDER_TYPE_3 as short, RCI_SHOULDER_TYPE_3_TXT as string, RCI_SHOULDER_WIDTH_1_FT as double, RCI_SHOULDER_WIDTH_2_FT as double, RCI_SHOULDER_WIDTH_3_FT as double, RCI_SURFACE_WIDTH_FT as double, RDWY_ALIGN_CD as short, RDWY_GRDE_CD as short, RD_SRFC_COND_CD as short, REFDIRECT as string, REFDISTANCE_MI as double, ROADCOND1 as short, ROADCOND1_TXT as string, ROADCOND2 as short, ROADCOND2_TXT as string, ROADCOND3 as short, ROADCOND3_TXT as string, ROADWAYID as integer, ROAD_CONDITION_MC as string, SAFETYLAT as double, SAFETYLON as double, SCHL_BUS_REL_CD as short, SITELOCA as short, SKID_NUMBER as short, SKID_TEST_DATE as long, SPEEDING_AGGRESSIVE_IND as boolean, SPEEDING_IND as boolean, SPEED_LIMIT as short, STATE_ROAD_NUMBER as string, TOTAL_DRIVERS as short, TOTAL_PERSONS as short, TRAFFIC_CONTROL_MC as string, TRAF_WAY_CD as short, TRAVDIR as string, TYPESHLD as short, US_ROAD_NUMBER as string, V1TRAFCTL as short, V1TRAFCTL_TXT as string, V1_TRAF_WAY_CD as short, V1_TRAF_WAY_CD_TXT as string, V2TRAFCTL as short, V2TRAFCTL_TXT as string, V2_TRAF_WAY_CD as short, V2_TRAF_WAY_CD_TXT as string, VHCL_MOVE_CD as short, WEEKDAY_TXT as string, WORKZONE_IND as boolean, WRK_PRSNT_CD as short, WRK_ZONE_TYP_CD as short, WRONGWAY_IND as boolean, XID as long, X_COORDINATE as double, Y_COORDINATE as double), geometry as (x as integer, y as integer))[],",
                "          fields as (alias as string, length as short, name as string, type as string)[],",
                "          geometryType as string,",
                "          globalIdFieldName as string,",
                "          hasM as boolean,",
                "          objectIdFieldName as string,",
                "          spatialReference as (latestWkid as short, wkid as short)",
                "     ),",
                "     allowSchemaDrift: true,",
                "     validateSchema: false,",
                "     ignoreNoFilesFound: false,",
                "     documentForm: 'documentPerLine') ~> source1",
                "source1 foldDown(unroll(features),",
                "     mapColumn(",
                "          features",
                "     ),",
                "     skipDuplicateMapInputs: false,",
                "     skipDuplicateMapOutputs: false) ~> flatten1",
                "flatten1 sink(allowSchemaDrift: true,",
                "     validateSchema: false,",
                "     umask: 0022,",
                "     preCommands: [],",
                "     postCommands: [],",
                "     skipDuplicateMapInputs: true,",
                "     skipDuplicateMapOutputs: true,",
                "     mapColumn(",
                "          AADT_SOURCE = features.attributes.AADT_SOURCE,",
                "          ACCLANE = features.attributes.ACCLANE,",
                "          ACCSIDRD = features.attributes.ACCSIDRD,",
                "          AGENCY_TYPE_TXT = features.attributes.AGENCY_TYPE_TXT,",
                "          AGE_65_69_IND = features.attributes.AGE_65_69_IND,",
                "          AGE_65_PLUS_IND = features.attributes.AGE_65_PLUS_IND,",
                "          AGE_70_74_IND = features.attributes.AGE_70_74_IND,",
                "          AGE_75_79_IND = features.attributes.AGE_75_79_IND,",
                "          AGE_80_PLUS_IND = features.attributes.AGE_80_PLUS_IND,",
                "          AGE_TEEN_IND = features.attributes.AGE_TEEN_IND,",
                "          AGGRESSIVE_DRIVING_IND = features.attributes.AGGRESSIVE_DRIVING_IND,",
                "          ALCINVCD = features.attributes.ALCINVCD,",
                "          ARBM_ROADSIDE = features.attributes.ARBM_ROADSIDE,",
                "          ARBM_ROAD_STATUS = features.attributes.ARBM_ROAD_STATUS,",
                "          AVERAGE_DAILY_TRAFFIC = features.attributes.AVERAGE_DAILY_TRAFFIC,",
                "          BICYCLIST_RELATED_IND = features.attributes.BICYCLIST_RELATED_IND,",
                "          CALENDAR_YEAR = features.attributes.CALENDAR_YEAR,",
                "          CARSTACD = features.attributes.CARSTACD,",
                "          CASE_NUMBER = features.attributes.CASE_NUMBER,",
                "          CNTOFLANES = features.attributes.CNTOFLANES,",
                "          COMMERCIAL_VEHICLE_IND = features.attributes.COMMERCIAL_VEHICLE_IND,",
                "          COUNTY_TXT = features.attributes.COUNTY_TXT,",
                "          CRASH_CLASS_IND_MC = features.attributes.CRASH_CLASS_IND_MC,",
                "          CRASH_DATE = features.attributes.CRASH_DATE,",
                "          CRASH_NUMBER = features.attributes.CRASH_NUMBER,",
                "          CRASH_TIME = features.attributes.CRASH_TIME,",
                "          CRRATECD = features.attributes.CRRATECD,",
                "          CRSH_REF_NODE_ID = features.attributes.CRSH_REF_NODE_ID,",
                "          CRSH_XTMREF_NOD_ID = features.attributes.CRSH_XTMREF_NOD_ID,",
                "          CRSH_XTRREFNODB_ID = features.attributes.CRSH_XTRREFNODB_ID,",
                "          D1_FRST_DR_ACTN_CD = features.attributes.D1_FRST_DR_ACTN_CD,",
                "          D1_FRST_DR_ACTN_CD_TXT = features.attributes.D1_FRST_DR_ACTN_CD_TXT,",
                "          D2_FRST_DR_ACTN_CD = features.attributes.D2_FRST_DR_ACTN_CD,",
                "          D2_FRST_DR_ACTN_CD_TXT = features.attributes.D2_FRST_DR_ACTN_CD_TXT,",
                "          DAYOWEEK = features.attributes.DAYOWEEK,",
                "          DHSCNTYCTY = features.attributes.DHSCNTYCTY,",
                "          DHSMV_CTY_CD = features.attributes.DHSMV_CTY_CD,",
                "          DHSRDSYS = features.attributes.DHSRDSYS,",
                "          DISTRACTED_DRIVER_IND = features.attributes.DISTRACTED_DRIVER_IND,",
                "          DOT_CNTY_CD = features.attributes.DOT_CNTY_CD,",
                "          DOT_GEOG_DIST_CD = features.attributes.DOT_GEOG_DIST_CD,",
                "          DRIVER_ACTION_MC = features.attributes.DRIVER_ACTION_MC,",
                "          DRIVER_PEDEST_CONDIT_IND_MC = features.attributes.DRIVER_PEDEST_CONDIT_IND_MC,",
                "          DSTNC_TOXTRNOD_NUM = features.attributes.DSTNC_TOXTRNOD_NUM,",
                "          DST_TOXTRMNODB_NUM = features.attributes.DST_TOXTRMNODB_NUM,",
                "          ENVIRNMT1 = features.attributes.ENVIRNMT1,",
                "          ENVIRNMT1_TXT = features.attributes.ENVIRNMT1_TXT,",
                "          ENVIRNMT2 = features.attributes.ENVIRNMT2,",
                "          ENVIRNMT2_TXT = features.attributes.ENVIRNMT2_TXT,",
                "          ENVIRNMT3 = features.attributes.ENVIRNMT3,",
                "          ENVIRNMT3_TXT = features.attributes.ENVIRNMT3_TXT,",
                "          ENVIRONMENT_CONDITION_MC = features.attributes.ENVIRONMENT_CONDITION_MC,",
                "          EVNT_WTHR_COND_CD = features.attributes.EVNT_WTHR_COND_CD,",
                "          EXTRACT_DATE = features.attributes.EXTRACT_DATE,",
                "          FRST_HARM_LOC_CD = features.attributes.FRST_HARM_LOC_CD,",
                "          FUNCLASS = features.attributes.FUNCLASS,",
                "          GEO_URBAN_RURAL_IND = features.attributes.GEO_URBAN_RURAL_IND,",
                "          IMPAIRED_BICYCLIST_IND = features.attributes.IMPAIRED_BICYCLIST_IND,",
                "          IMPAIRED_DRIVER_IND = features.attributes.IMPAIRED_DRIVER_IND,",
                "          IMPAIRED_PEDESTRIAN_IND = features.attributes.IMPAIRED_PEDESTRIAN_IND,",
                "          IMPCT_TYP_CD = features.attributes.IMPCT_TYP_CD,",
                "          INJSEVER = features.attributes.INJSEVER,",
                "          INTCT_TYP_CD = features.attributes.INTCT_TYP_CD,",
                "          INTERSECTION_IND = features.attributes.INTERSECTION_IND,",
                "          INT_ROADWAY_NAME = features.attributes.INT_ROADWAY_NAME,",
                "          INVSTGT_AGCY_CD = features.attributes.INVSTGT_AGCY_CD,",
                "          IN_TOWN_FLAG = features.attributes.IN_TOWN_FLAG,",
                "          JCT_CD = features.attributes.JCT_CD,",
                "          LANE_DEPARTURE_IND = features.attributes.LANE_DEPARTURE_IND,",
                "          LATITUDE = features.attributes.LATITUDE,",
                "          LAW_ENFRC_PRSNT_CD = features.attributes.LAW_ENFRC_PRSNT_CD,",
                "          LGHT_COND_CD = features.attributes.LGHT_COND_CD,",
                "          LINK_ID = features.attributes.LINK_ID,",
                "          LOCMP = features.attributes.LOCMP,",
                "          LOC_WTHN_ZONE_CD = features.attributes.LOC_WTHN_ZONE_CD,",
                "          LONGITUDE = features.attributes.LONGITUDE,",
                "          MAP_SOURCE = features.attributes.MAP_SOURCE,",
                "          MOST_HARM_EVNT_CD = features.attributes.MOST_HARM_EVNT_CD,",
                "          MOTORCYCLE_INVOLVED_IND = features.attributes.MOTORCYCLE_INVOLVED_IND,",
                "          NEAREST_NODE_FROM_CRASH = features.attributes.NEAREST_NODE_FROM_CRASH,",
                "          NO_BELT_AGE_13_17_IND = features.attributes.NO_BELT_AGE_13_17_IND,",
                "          NO_BELT_AGE_1_4_IND = features.attributes.NO_BELT_AGE_1_4_IND,",
                "          NO_BELT_AGE_5_12_IND = features.attributes.NO_BELT_AGE_5_12_IND,",
                "          NO_BELT_IND = features.attributes.NO_BELT_IND,",
                "          NUMBER_OF_BICYCLISTS = features.attributes.NUMBER_OF_BICYCLISTS,",
                "          NUMBER_OF_INJURED = features.attributes.NUMBER_OF_INJURED,",
                "          NUMBER_OF_KILLED = features.attributes.NUMBER_OF_KILLED,",
                "          NUMBER_OF_PEDESTRIANS = features.attributes.NUMBER_OF_PEDESTRIANS,",
                "          NUMBER_OF_SERIOUS_INJURIES = features.attributes.NUMBER_OF_SERIOUS_INJURIES,",
                "          NUMBER_OF_VEHICLES = features.attributes.NUMBER_OF_VEHICLES,",
                "          OBJECTID = features.attributes.OBJECTID,",
                "          OFFICER_LATITUDE = features.attributes.OFFICER_LATITUDE,",
                "          OFFICER_LONGITUDE = features.attributes.OFFICER_LONGITUDE,",
                "          ON_ROADWAY_NAME = features.attributes.ON_ROADWAY_NAME,",
                "          PEDESTRIAN_BICYCLIST_IND = features.attributes.PEDESTRIAN_BICYCLIST_IND,",
                "          PEDESTRIAN_RELATED_IND = features.attributes.PEDESTRIAN_RELATED_IND,",
                "          RCI_AVG_PERC_TRUCK_TRAFF = features.attributes.RCI_AVG_PERC_TRUCK_TRAFF,",
                "          RCI_HORIZ_CURVE_CD = features.attributes.RCI_HORIZ_CURVE_CD,",
                "          RCI_MEDIAN_WIDTH_FT = features.attributes.RCI_MEDIAN_WIDTH_FT,",
                "          RCI_SHOULDER_TYPE_1 = features.attributes.RCI_SHOULDER_TYPE_1,",
                "          RCI_SHOULDER_TYPE_1_TXT = features.attributes.RCI_SHOULDER_TYPE_1_TXT,",
                "          RCI_SHOULDER_TYPE_2 = features.attributes.RCI_SHOULDER_TYPE_2,",
                "          RCI_SHOULDER_TYPE_2_TXT = features.attributes.RCI_SHOULDER_TYPE_2_TXT,",
                "          RCI_SHOULDER_TYPE_3 = features.attributes.RCI_SHOULDER_TYPE_3,",
                "          RCI_SHOULDER_TYPE_3_TXT = features.attributes.RCI_SHOULDER_TYPE_3_TXT,",
                "          RCI_SHOULDER_WIDTH_1_FT = features.attributes.RCI_SHOULDER_WIDTH_1_FT,",
                "          RCI_SHOULDER_WIDTH_2_FT = features.attributes.RCI_SHOULDER_WIDTH_2_FT,",
                "          RCI_SHOULDER_WIDTH_3_FT = features.attributes.RCI_SHOULDER_WIDTH_3_FT,",
                "          RCI_SURFACE_WIDTH_FT = features.attributes.RCI_SURFACE_WIDTH_FT,",
                "          RDWY_ALIGN_CD = features.attributes.RDWY_ALIGN_CD,",
                "          RDWY_GRDE_CD = features.attributes.RDWY_GRDE_CD,",
                "          RD_SRFC_COND_CD = features.attributes.RD_SRFC_COND_CD,",
                "          REFDIRECT = features.attributes.REFDIRECT,",
                "          REFDISTANCE_MI = features.attributes.REFDISTANCE_MI,",
                "          ROADCOND1 = features.attributes.ROADCOND1,",
                "          ROADCOND1_TXT = features.attributes.ROADCOND1_TXT,",
                "          ROADCOND2 = features.attributes.ROADCOND2,",
                "          ROADCOND2_TXT = features.attributes.ROADCOND2_TXT,",
                "          ROADCOND3 = features.attributes.ROADCOND3,",
                "          ROADCOND3_TXT = features.attributes.ROADCOND3_TXT,",
                "          ROADWAYID = features.attributes.ROADWAYID,",
                "          ROAD_CONDITION_MC = features.attributes.ROAD_CONDITION_MC,",
                "          SAFETYLAT = features.attributes.SAFETYLAT,",
                "          SAFETYLON = features.attributes.SAFETYLON,",
                "          SCHL_BUS_REL_CD = features.attributes.SCHL_BUS_REL_CD,",
                "          SITELOCA = features.attributes.SITELOCA,",
                "          SKID_NUMBER = features.attributes.SKID_NUMBER,",
                "          SKID_TEST_DATE = features.attributes.SKID_TEST_DATE,",
                "          SPEEDING_AGGRESSIVE_IND = features.attributes.SPEEDING_AGGRESSIVE_IND,",
                "          SPEEDING_IND = features.attributes.SPEEDING_IND,",
                "          SPEED_LIMIT = features.attributes.SPEED_LIMIT,",
                "          STATE_ROAD_NUMBER = features.attributes.STATE_ROAD_NUMBER,",
                "          TOTAL_DRIVERS = features.attributes.TOTAL_DRIVERS,",
                "          TOTAL_PERSONS = features.attributes.TOTAL_PERSONS,",
                "          TRAFFIC_CONTROL_MC = features.attributes.TRAFFIC_CONTROL_MC,",
                "          TRAF_WAY_CD = features.attributes.TRAF_WAY_CD,",
                "          TRAVDIR = features.attributes.TRAVDIR,",
                "          TYPESHLD = features.attributes.TYPESHLD,",
                "          US_ROAD_NUMBER = features.attributes.US_ROAD_NUMBER,",
                "          V1TRAFCTL = features.attributes.V1TRAFCTL,",
                "          V1TRAFCTL_TXT = features.attributes.V1TRAFCTL_TXT,",
                "          V1_TRAF_WAY_CD = features.attributes.V1_TRAF_WAY_CD,",
                "          V1_TRAF_WAY_CD_TXT = features.attributes.V1_TRAF_WAY_CD_TXT,",
                "          V2TRAFCTL = features.attributes.V2TRAFCTL,",
                "          V2TRAFCTL_TXT = features.attributes.V2TRAFCTL_TXT,",
                "          V2_TRAF_WAY_CD = features.attributes.V2_TRAF_WAY_CD,",
                "          V2_TRAF_WAY_CD_TXT = features.attributes.V2_TRAF_WAY_CD_TXT,",
                "          VHCL_MOVE_CD = features.attributes.VHCL_MOVE_CD,",
                "          WEEKDAY_TXT = features.attributes.WEEKDAY_TXT,",
                "          WORKZONE_IND = features.attributes.WORKZONE_IND,",
                "          WRK_PRSNT_CD = features.attributes.WRK_PRSNT_CD,",
                "          WRK_ZONE_TYP_CD = features.attributes.WRK_ZONE_TYP_CD,",
                "          WRONGWAY_IND = features.attributes.WRONGWAY_IND,",
                "          XID = features.attributes.XID,",
                "          X_COORDINATE = features.attributes.X_COORDINATE,",
                "          Y_COORDINATE = features.attributes.Y_COORDINATE",
                "     )) ~> sink1"]
     } 
  }  

}