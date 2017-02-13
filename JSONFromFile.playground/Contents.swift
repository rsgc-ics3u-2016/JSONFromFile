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
// Purpose: Open a JSON file included in the playground and return the contents of the file as a String
func getJSON(forResource resource : String, ofType type : String) -> String? {

    // Obtain the path to file in the playground bundle
    if let path = Bundle.main.path(forResource: resource, ofType: type) {
        
        // Read the raw data in the file
        if let data = FileManager.default.contents(atPath: path) {
            
            // Convert the raw data to a string
            if let content = String(data: data, encoding: String.Encoding.utf8) {
                
                return content
                
            } else {
                
                // Error
                print("Could not convert the raw data to a string")
                return nil
            }
            
        } else {
            
            // Error
            print("Could not read data from file.")
            return nil
        }
        
    } else {
        
        // Error
        print("File path not found.")
        return nil
    }
    
}

// Attempt to get the JSON data from the file
if let json = getJSON(forResource: "ac-in-toronto", ofType: "json") {

    // Now parse the JSON into Swift-native data structures... add your code below
    print(json)
    
} else {
    
    // Error
    print("Could not get JSON data from the file.")
}