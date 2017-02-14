/*:
 
 # Parsing JSON From a Local File
 
 "This JSON dataset identifies public locations and cooling centres in the City of Toronto that offer an air-conditioned space for temporary relief on heat alert and extreme heat alert days."
 
 [Source](http://www1.toronto.ca/wps/portal/contentonly?vgnextoid=e7356d1900531510VgnVCM10000071d60f89RCRD&vgnextchannel=1a66e03bb8d1e310VgnVCM10000071d60f89RCRD)
 
 ## Your goal
 
 The code below loads a JSON file contained within this playground.
 
 Use optional binding (with *if let* statements or *guard let* statements inside a function) to parse the raw JSON data into Swift-native data structures.
 
 A good first step is to examine the data contained inside the file, and by hand, make a plan for what Swift-native data types you will parse the data into.
 
 Then, write the code to do the parsing.
 
 */

import Foundation

// getJSON
//
// Purpose: Open a JSON file included in the playground Resources folder and return the contents of the file as JSON data
func getJSON(forResource resource : String, ofType type : String) -> Data? {
    
    
    // Obtain the path to file in the playground bundle
    guard let path = Bundle.main.path(forResource: resource, ofType: type) else {
        
        // Early exit from function with error
        print("File path not found.")
        return nil
        
    }
    
    // Read the raw data in the file
    guard let data = FileManager.default.contents(atPath: path) else {
        
        // Early exit from function with error
        print("Could not read data from file.")
        return nil
    }

    // Return the JSON data
    return data
    
}

// CoolingCentre
//
// Purpose: Store information we care about from the JSON file.
struct CoolingCentre {
    
    // Properties... add more as needed based on your analysis of the JSON data
    var address : String
    
}

// parseJSON
//
// Purpose: Parse a String containing JSON data and return a Swift-native data structure containing relevant data
func parse(_ JSON : Data) -> [CoolingCentre]? {
    
    // Create an empty array of the structure that will contain data about a cooling centre
    var parsedData : [CoolingCentre] = []
    
    // Begin parsing the cooling centre data
    // De-serializing JSON can throw errors, so should be inside a do-catch structure
    do {
        
        // Get the raw list of JSON objects as an array of Any objects
        let allCoolingCentres = try JSONSerialization.jsonObject(with: JSON, options: JSONSerialization.ReadingOptions.allowFragments) as! [Any]
        
        // Now iterate over the list of Any objects and try to cast each object to a dictionary
        for centre in allCoolingCentres {
            
            // Try to cast this cooling centre to a dictionary
            guard let thisCentre = centre as? [String : Any] else {
                
                // Error, early exit
                print("Could not cast Any object to a [String : Any] Dictionary.")
                return nil
            }
            
            // Try to cast the address from the JSON data into a String
            guard let address = thisCentre["address"] as? String else {
                
                // Error, early exit
                print("Could not obtain address information for current cooling centre.")
                return nil
            }

            // TODO... Add additional lines to parse the rest of the cooling centre JSON data.
            
            // Now we have the information needed from the JSON object, so add to our list of parsed data
            // TODO: You'll need to update the CoolingCentre struct and modify the line below.
            parsedData.append(CoolingCentre(address: address))
            
        }
        
    } catch let error as NSError {
        
        // Print the error message
        print("Failed to parse JSON: \(error.localizedDescription)")
        return nil
        
    }
    
    // Return the array of cooling centre data
    return parsedData
    
}

// Attempt to get the JSON data from the file
if let json = getJSON(forResource: "ac-in-toronto", ofType: "json") {
    
    // Now parse the JSON into Swift-native data structures...
    if let centres = parse(json) {
        
        // At this point, if this code were in a "full project" you could take the data and present it in a user interface
        print(centres)
        
    }
    
} else {
    
    // Error
    print("Could not get JSON data from the file.")
}