locals {
  linked_custom_service = {
    "fdot"         = "https://gis.fdot.gov/"
    "arcgis"       = "https://services1.arcgis.com/"
  }
  custom_data = {
    "bikes_data_json" = {
      linked_service = "arcgis"
      relativeUrl = "O1JpcwDW8sjYuddV/arcgis/rest/services/USBikeRoutesFlorida/FeatureServer/0/query?where=%20(FDOTCOID%20%3D%2086%20OR%20FDOTCOID%20%3D%2067)%20&outFields=*&outSR=4326&f=json"
    }    
    "boundaries_data_json" = {
      linked_service = "arcgis"
      relativeUrl = "O1JpcwDW8sjYuddV/arcgis/rest/services/Florida_County_Boundaries_with_FDOT_Districts/FeatureServer/0/query?where=FDOTCountyCode%20%3D%20%2786%27&outFields=*&outSR=4326&f=json"
    }
    "aadt_data_json" = {
      linked_service = "arcgis"
      relativeUrl = "O1JpcwDW8sjYuddV/arcgis/rest/services/Annual_Average_Daily_Traffic_TDA/FeatureServer/0/query?where=COUNTYDOT%3D86&objectIds=&time=&geometry=&geometryType=esriGeometryEnvelope&inSR=&spatialRel=esriSpatialRelIntersects&resultType=none&distance=0.0&units=esriSRUnit_Meter&relationParam=&returnGeodetic=false&outFields=*&returnGeometry=true&featureEncoding=esriDefault&multipatchOption=xyFootprint&maxAllowableOffset=&geometryPrecision=&outSR=&defaultSR=&datumTransformation=&applyVCSProjection=false&returnIdsOnly=false&returnUniqueIdsOnly=false&returnCountOnly=false&returnExtentOnly=false&returnQueryGeometry=false&returnDistinctValues=false&cacheHint=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&having=&resultOffset=&resultRecordCount=100000&returnZ=false&returnM=false&returnExceededLimitFeatures=true&quantizationParameters=&sqlFormat=none&f=pjson&token="
    }    
    "intersection_data_json" = {
      linked_service = "arcgis"
      relativeUrl = "O1JpcwDW8sjYuddV/arcgis/rest/services/Intersection_TDA/FeatureServer/0/query?where=1%3D1&outFields=*&outSR=4326&f=json"
    }
    "traffic_signal_locations_json" = {
      linked_service = "arcgis"
      relativeUrl = "O1JpcwDW8sjYuddV/arcgis/rest/services/Traffic_Signal_Locations_TDA/FeatureServer/0/query?where=COUNTYDOT%20%3D%20'86'&outFields=*&outSR=4326&f=json"
    }    
    "crash_data_json_2022" = {
      linked_service = "fdot"
      relativeUrl = "arcgis/rest/services/sso/ssogis/FeatureServer/11/query?where=DOT_CNTY_CD%3D86+AND+CALENDAR_YEAR%3D2022&objectIds=&time=&geometry=&geometryType=esriGeometryEnvelope&inSR=&spatialRel=esriSpatialRelIntersects&distance=&units=esriSRUnit_Foot&relationParam=&outFields=*&returnGeometry=true&maxAllowableOffset=5&geometryPrecision=&outSR=&havingClause=&gdbVersion=&historicMoment=&returnDistinctValues=false&returnIdsOnly=false&returnCountOnly=false&returnExtentOnly=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&returnZ=false&returnM=false&multipatchOption=xyFootprint&resultOffset=0&resultRecordCount=500000&returnTrueCurves=false&returnExceededLimitFeatures=false&quantizationParameters=&returnCentroid=false&timeReferenceUnknownClient=false&sqlFormat=none&resultType=&featureEncoding=esriDefault&datumTransformation=&f=pjson"
    }
    "crash_data_json_2021" = {
      linked_service = "fdot"
      relativeUrl = "arcgis/rest/services/sso/ssogis/FeatureServer/11/query?where=DOT_CNTY_CD%3D86+AND+CALENDAR_YEAR%3D2021&objectIds=&time=&geometry=&geometryType=esriGeometryEnvelope&inSR=&spatialRel=esriSpatialRelIntersects&distance=&units=esriSRUnit_Foot&relationParam=&outFields=*&returnGeometry=true&maxAllowableOffset=5&geometryPrecision=&outSR=&havingClause=&gdbVersion=&historicMoment=&returnDistinctValues=false&returnIdsOnly=false&returnCountOnly=false&returnExtentOnly=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&returnZ=false&returnM=false&multipatchOption=xyFootprint&resultOffset=0&resultRecordCount=500000&returnTrueCurves=false&returnExceededLimitFeatures=false&quantizationParameters=&returnCentroid=false&timeReferenceUnknownClient=false&sqlFormat=none&resultType=&featureEncoding=esriDefault&datumTransformation=&f=pjson"
    }
    "crash_data_json_2020" = {
      linked_service = "fdot"
      relativeUrl = "arcgis/rest/services/sso/ssogis/FeatureServer/11/query?where=DOT_CNTY_CD%3D86+AND+CALENDAR_YEAR%3D2020&objectIds=&time=&geometry=&geometryType=esriGeometryEnvelope&inSR=&spatialRel=esriSpatialRelIntersects&distance=&units=esriSRUnit_Foot&relationParam=&outFields=*&returnGeometry=true&maxAllowableOffset=5&geometryPrecision=&outSR=&havingClause=&gdbVersion=&historicMoment=&returnDistinctValues=false&returnIdsOnly=false&returnCountOnly=false&returnExtentOnly=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&returnZ=false&returnM=false&multipatchOption=xyFootprint&resultOffset=0&resultRecordCount=500000&returnTrueCurves=false&returnExceededLimitFeatures=false&quantizationParameters=&returnCentroid=false&timeReferenceUnknownClient=false&sqlFormat=none&resultType=&featureEncoding=esriDefault&datumTransformation=&f=pjson"
    }
    "crash_data_json_2019" = {
      linked_service = "fdot"
      relativeUrl = "arcgis/rest/services/sso/ssogis/FeatureServer/11/query?where=DOT_CNTY_CD%3D86+AND+CALENDAR_YEAR%3D2019&objectIds=&time=&geometry=&geometryType=esriGeometryEnvelope&inSR=&spatialRel=esriSpatialRelIntersects&distance=&units=esriSRUnit_Foot&relationParam=&outFields=*&returnGeometry=true&maxAllowableOffset=5&geometryPrecision=&outSR=&havingClause=&gdbVersion=&historicMoment=&returnDistinctValues=false&returnIdsOnly=false&returnCountOnly=false&returnExtentOnly=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&returnZ=false&returnM=false&multipatchOption=xyFootprint&resultOffset=0&resultRecordCount=500000&returnTrueCurves=false&returnExceededLimitFeatures=false&quantizationParameters=&returnCentroid=false&timeReferenceUnknownClient=false&sqlFormat=none&resultType=&featureEncoding=esriDefault&datumTransformation=&f=pjson"
    }    
    "crash_data_json_2018" = {
      linked_service = "fdot"
      relativeUrl = "arcgis/rest/services/sso/ssogis/FeatureServer/11/query?where=DOT_CNTY_CD%3D86+AND+CALENDAR_YEAR%3D2018&objectIds=&time=&geometry=&geometryType=esriGeometryEnvelope&inSR=&spatialRel=esriSpatialRelIntersects&distance=&units=esriSRUnit_Foot&relationParam=&outFields=*&returnGeometry=true&maxAllowableOffset=5&geometryPrecision=&outSR=&havingClause=&gdbVersion=&historicMoment=&returnDistinctValues=false&returnIdsOnly=false&returnCountOnly=false&returnExtentOnly=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&returnZ=false&returnM=false&multipatchOption=xyFootprint&resultOffset=0&resultRecordCount=500000&returnTrueCurves=false&returnExceededLimitFeatures=false&quantizationParameters=&returnCentroid=false&timeReferenceUnknownClient=false&sqlFormat=none&resultType=&featureEncoding=esriDefault&datumTransformation=&f=pjson"
    }
    "crash_data_json_2017" = {
      linked_service = "fdot"
      relativeUrl = "arcgis/rest/services/sso/ssogis/FeatureServer/11/query?where=DOT_CNTY_CD%3D86+AND+CALENDAR_YEAR%3D2017&objectIds=&time=&geometry=&geometryType=esriGeometryEnvelope&inSR=&spatialRel=esriSpatialRelIntersects&distance=&units=esriSRUnit_Foot&relationParam=&outFields=*&returnGeometry=true&maxAllowableOffset=5&geometryPrecision=&outSR=&havingClause=&gdbVersion=&historicMoment=&returnDistinctValues=false&returnIdsOnly=false&returnCountOnly=false&returnExtentOnly=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&returnZ=false&returnM=false&multipatchOption=xyFootprint&resultOffset=0&resultRecordCount=500000&returnTrueCurves=false&returnExceededLimitFeatures=false&quantizationParameters=&returnCentroid=false&timeReferenceUnknownClient=false&sqlFormat=none&resultType=&featureEncoding=esriDefault&datumTransformation=&f=pjson"
    }    
  }
  raw_data = {
    "adl_bikes_data_json" = {
      fileName = "bikeroutes.json"
      folderPath = "fdos"
      fileSystem = "raw"
    }    
    "adl_boundaries_data_json" = {
      fileName = "boundaries.json"
      folderPath = "fdos"
      fileSystem = "raw"
    }
    "adl_aadt_data_json" = {
      fileName = "aadt.json"
      folderPath = "fdos"
      fileSystem = "raw"
    }
    "adl_intersection_data_json" = {
      fileName = "intersection.json"
      folderPath = "fdos"
      fileSystem = "raw"
    }
    "adl_traffic_signal_locations_json" = {
      fileName = "trafficsignal.json"
      folderPath = "fdos"
      fileSystem = "raw"
    }
    "adl_crash_data_json_2022" = {
      fileName = "crash2022.json"
      folderPath = "fdos"
      fileSystem = "raw"
    }
    "adl_crash_data_json_2021" = {
      fileName = "crash2021.json"
      folderPath = "fdos"
      fileSystem = "raw"
    }
    "adl_crash_data_json_2020" = {
      fileName = "crash2020.json"
      folderPath = "fdos"
      fileSystem = "raw"
    }
    "adl_crash_data_json_2019" = {
      fileName = "crash2019.json"
      folderPath = "fdos"
      fileSystem = "raw"
    }
    "adl_crash_data_json_2018" = {
      fileName = "crash2018.json"
      folderPath = "fdos"
      fileSystem = "raw"
    }                
  }
}