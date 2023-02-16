workspace {

    model {
        user = person "Henrik" "A user of the Garmin GTFS notification app"
        garminApp = softwareSystem "Garmin Watch App" "Provides personalized public transit notifications. Allow user to query next public transit from current location to predefined destination."
        garminConnect = softwareSystem "Garmin IO Connect" "Controls application installation and configuration"
        gtfsAPI = softwaresystem "RejsePlanen API" "GTFS data API. Provides lines, stops, departuer and arrival times, connections etc." "Existing System"
        gisService = softwaresystem "GIS Distance API"  "Provides distance and walking time estimates from user location to nearest departure point." "Existing System"
        
        user -> garminApp "Uses app to query next transit connection."
        garminApp -> user "Notifies user on transit option within personal preference"
        user -> garminConnect "Configures location, time and route preferences."
        garminApp -> gtfsAPI "Gets GTFS data on request."
        garminApp -> gisService "Query walking estimates"
        garminConnect -> garminApp "Transfer configuration."
        garminConnect -> gtfsAPI "Gets GTFS information for configuration."
        
    }

    views {
        systemContext garminApp "SystemContext" {
            include *
            autoLayout
        }

        styles {
            element "Software System" {
                background #1168bd
                color #ffffff
            }
            
            
            element "Person" {
                shape person
                background #08427b
                color #ffffff
            }
            
            
            element "Existing System" {
                background #999999
                color #ffffff
            }
        }
    }
}
