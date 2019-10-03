//
//  RepresentativeController.swift
//  Representative-master
//
//  Created by Eric Lanza on 1/16/19.
//  Copyright © 2019 DevMtnStudent. All rights reserved.
//

import Foundation


struct SharedConstant {
    fileprivate static let baseURL = "http://whoismyrepresentative.com/getall_reps_bystate.php"
    fileprivate static let searchComponet = "sens"
    fileprivate static let state = "state"
    fileprivate static let output = "output"
    fileprivate static let json = "json"
}
    
class RepresentativeController {
 
    static func searchRepresientatives(forState state: String, completion: @escaping (([Representive]) -> Void)) {
        guard let baseURL = URL(string: SharedConstant.baseURL) else {completion([]); return}
       
        guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
            else {completion([]); return}
        let stateQuery = URLQueryItem(name: SharedConstant.state, value: state.lowercased())
        let jsonQuery = URLQueryItem(name: SharedConstant.output, value: SharedConstant.json)
        
        components.queryItems = [stateQuery, jsonQuery]
        
        guard let finalURL = components.url else {
            print("compnets have an issue")
            completion([])
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion([])
                return
            }
            guard let data = data,
                let responseDataString = String(data: data, encoding: .ascii),
                let fixedData = responseDataString.data(using: .utf8) else {
                print("data error ")
                completion([])
                return
            }
            let jsonDecoder = JSONDecoder()
            
            do {
                let representive = try jsonDecoder.decode([String: [Representive]].self, from: fixedData)
                let newArray = representive["results"]
                completion(newArray ?? [])
            } catch {
                print("error with data")
                completion([])
                return
            }
        
        }
        dataTask.resume()
    }
    
} // end of class


