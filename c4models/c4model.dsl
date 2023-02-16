workspace {

    model {
        user = person "Henrik" "A user of the Garmin GTFS notification app"
       
        gtfsAPI = softwareSystem "RejsePlanen API" "GTFS data API. Provides lines, stops, departuer and arrival times, connections etc." "Existing System"
        gisService = softwareSystem "GIS Distance API"  "Provides distance and walking time estimates from user location to nearest departure point." "Existing System"
        garminConnect = softwareSystem "Garmin Connect" "Garmin smartphone application for distributing smartwatch applications" "Existing System" {
            garminConnectContainer = container "Garmin Connect Configuration" "Garmin application for installing the smartwatch app and providing simple configurations." "Monkey C SDK" "Container"
        }
        
        garminApp = softwareSystem "Garmin App" "Provides personalized public transit notifications. Allow user to query next public transit from current location to predefined destination." {
            garminWatchApp = container "Garmin Smartwatch app" "The smartwatch application that is the primary on-the-go way of interacting with the system." "Monkey C SDK" "Container"
            garminPosition = container "Garmin position" "The GPS based position funktionality" "Monkey C SDK" "Container"
            
            userPreferences = container "Database" "Stores user preferences (time/destination)" "Garmin SDK DB API" "Database"
        }
        
        
        user -> garminApp "Uses app to query next transit connection."
        
        garminApp -> user "Notifies user on transit option within personal preference"
        garminApp -> gtfsAPI "Gets GTFS data on request."
        garminApp -> gisService "Query walking estimates"
        
        user -> garminConnect "Install Garmin app on smartwatch."
        garminConnect -> garminApp "Installs Garmin App on smartwatch."
        
        garminConnectContainer -> gtfsAPI "Queries GTFS data when setting up user preferences"
        user -> garminConnectContainer "Configures public transit preferences"
        garminConnectContainer -> garminWatchApp "Transfers user configuration"
        garminWatchApp -> userPreferences "Store user preferences"
        garminPosition -> userPreferences "Check for preference location rules"
        garminPosition -> garminWatchApp "Notifies application about preference, time and location match"
        garminWatchApp -> user "Notifies user about next possible transit"
        garminWatchApp -> gisService "Estimates walking time and distance"
    }

    views {
        systemContext garminApp "SystemContext" {
            include *
            autoLayout
        }
        
        container garminApp "Containers" {
            include *
            autoLayout
        }

        styles {
            element "Software System" {
                background #1168bd
                color #ffffff
            }
            
            element "Container" {
                background #1168bd
                color #ffffff
            }
            
            element "Person" {
                shape person
                background #08427b
                color #ffffff
            }
            
            element "Database" {
                shape Cylinder
            }
            
            
            element "Existing System" {
                background #999999
                color #ffffff
            }
        }
    }
}
