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
    "weather_data_json_2017" = {
      linked_service = "openmeteo"
      relativeUrl = "v1/archive?latitude=26.100412&longitude=-80.130704&start_date=2017-01-01&end_date=2017-12-31&hourly=temperature_2m,relativehumidity_2m,precipitation,rain,weathercode,windspeed_10m,winddirection_10m,windgusts_10m&temperature_unit=fahrenheit&windspeed_unit=mph&timezone=America%2FNew_York"
      data_type = "RestResource"
    }
    "weather_data_json_2018" = {
      linked_service = "openmeteo"
      relativeUrl = "v1/archive?latitude=26.100412&longitude=-80.130704&start_date=2018-01-01&end_date=2018-12-31&hourly=temperature_2m,relativehumidity_2m,precipitation,rain,weathercode,windspeed_10m,winddirection_10m,windgusts_10m&temperature_unit=fahrenheit&windspeed_unit=mph&timezone=America%2FNew_York"
      data_type = "RestResource"
    }
    "weather_data_json_2019" = {
      linked_service = "openmeteo"
      relativeUrl = "v1/archive?latitude=26.100412&longitude=-80.130704&start_date=2019-01-01&end_date=2019-12-31&hourly=temperature_2m,relativehumidity_2m,precipitation,rain,weathercode,windspeed_10m,winddirection_10m,windgusts_10m&temperature_unit=fahrenheit&windspeed_unit=mph&timezone=America%2FNew_York"
      data_type = "RestResource"
    }
    "weather_data_json_2020" = {
      linked_service = "openmeteo"
      relativeUrl = "v1/archive?latitude=26.100412&longitude=-80.130704&start_date=2020-01-01&end_date=2020-12-31&hourly=temperature_2m,relativehumidity_2m,precipitation,rain,weathercode,windspeed_10m,winddirection_10m,windgusts_10m&temperature_unit=fahrenheit&windspeed_unit=mph&timezone=America%2FNew_York"
      data_type = "RestResource"
    } 
    "weather_data_json_2021" = {
      linked_service = "openmeteo"
      relativeUrl = "v1/archive?latitude=26.100412&longitude=-80.130704&start_date=2021-01-01&end_date=2021-12-31&hourly=temperature_2m,relativehumidity_2m,precipitation,rain,weathercode,windspeed_10m,winddirection_10m,windgusts_10m&temperature_unit=fahrenheit&windspeed_unit=mph&timezone=America%2FNew_York"
      data_type = "RestResource"
    }
    "weather_data_json_2022" = {
      linked_service = "openmeteo"
      relativeUrl = "v1/archive?latitude=26.100412&longitude=-80.130704&start_date=2022-01-01&end_date=2022-12-31&hourly=temperature_2m,relativehumidity_2m,precipitation,rain,weathercode,windspeed_10m,winddirection_10m,windgusts_10m&temperature_unit=fahrenheit&windspeed_unit=mph&timezone=America%2FNew_York"
      data_type = "RestResource"
    } 
    "weather_data_json_2023" = {
      linked_service = "openmeteo"
      relativeUrl = "v1/archive?latitude=26.100412&longitude=-80.130704&start_date=2023-01-01&end_date=2023-12-31&hourly=temperature_2m,relativehumidity_2m,precipitation,rain,weathercode,windspeed_10m,winddirection_10m,windgusts_10m&temperature_unit=fahrenheit&windspeed_unit=mph&timezone=America%2FNew_York"
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
  }  

}