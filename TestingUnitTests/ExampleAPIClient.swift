//
//  ExampleApiClient.swift
//  TestingUnitTests
//
//  Created by Ievgen Keba on 12/12/16.
//  Copyright © 2016 Harman Inc. All rights reserved.
//

import Foundation

class ExampleAPIClient {
    
    let endPoint = "http://swapi.co/api/people/1/"
    
    lazy var sharedSession = URLSession.shared
    var completion: ((_ jsonData: Dictionary<String, AnyObject>) -> Void)?
    
    func fetchExample(_ completion: @escaping (_ jsonData: Dictionary<String, AnyObject>) -> Void) {
        guard let URL = URL(string: endPoint) else {
            return
        }
        self.completion = completion
        let task = sharedSession.dataTask(with: URL, completionHandler: parseServerData)
        task.resume()
    }
    
    func parseServerData(_ data: Data?, response: URLResponse?, error: Error?) -> Void {
        
        guard error == nil else {
            print("ERROR: Unable to connect to server: \(error!.localizedDescription)")
            return
        }
        
        guard let data = data else {
            // Obtain information from response
            print("Failed to download data from server.")
            return
        }
        
        do {
            let dictionaries = try parseJSONData(data, options: []) as! Dictionary<String, AnyObject>
            completion?(dictionaries)
        } catch {
            print("Unexpected data format provided by server.")
        }
    }
    
    func parseJSONData(_ data: Data, options opt: JSONSerialization.ReadingOptions) throws -> Any {
        return try JSONSerialization.jsonObject(with: data, options: opt) as Any
    }
}
