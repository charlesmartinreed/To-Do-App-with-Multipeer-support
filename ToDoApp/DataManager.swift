//
//  DataManager.swift
//  ToDoApp
//
//  Created by Charles Martin Reed on 8/28/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import Foundation

public class DataManager {
    // get the Document Directory
    // fileprivate because it's only available in this file
    static fileprivate func getDocumentDirectory() -> URL {
        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            return url
        } else {
            fatalError("Unable to access document directory")
        }
    }
    
    // Save any kind of codeable objects - should be to save any type of data directly to disk
    //<T:Encodable> means it can take ANY type object, as long as its a Codable conforming one
    static func save <T:Encodable> (_ object: T, with fileName:String) {
        let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory: false)
        
        let encoder = JSONEncoder()
        
        do {
            //gives us a data object
            let data = try encoder.encode(object)
            //check whether or not the file already exists, if not, save it to the documents directory
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
                FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    // Load any kid of codeable objects
    static func load <T:Decodable> (_ fileName: String, with type:T.Type) -> T {
        let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory: false)
        
        //does the file exist?
        if !FileManager.default.fileExists(atPath: url.path) {
            fatalError("File not found at path: \(url.path)")
        }
        
        //grab the data object and return it
        if let data = FileManager.default.contents(atPath: url.path) {
            do {
                let model = try JSONDecoder().decode(type, from: data)
                return model
            } catch {
                fatalError(error.localizedDescription)
            }
        } else {
            fatalError("Data unavailable at path: \(url.path)")
        }
    }
    
    // Load the data from a file
    static func loadData (_ fileName: String) -> Data? {
        let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory: false)
        
        //does the file exist?
        if !FileManager.default.fileExists(atPath: url.path) {
            fatalError("File not found at path: \(url.path)")
        }
        
        //grab the data object and return it
        if let data = FileManager.default.contents(atPath: url.path) {
           return data
        } else {
            fatalError("Data unavailable at path: \(url.path)")
        }
    }
    
    // Load all files from a directory - loadData just loads ONE file
    static func loadAll <T: Decodable> (_ type: T.Type) -> [T] {
        do {
            //grab the files in our document directory
            let files = try FileManager.default.contentsOfDirectory(atPath: getDocumentDirectory().path)
            
            //this array will hold our values pulled from document directory
            var modelObjects = [T]()
            
            //iterate over the files array and use the results to add the objects to the modelObjects array
            for fileName in files {
                modelObjects.append(load(fileName, with: type))
            }
            
            return modelObjects
        } catch {
            fatalError("Could not load any files")
        }
    }
    
    
    //Delete a file
    static func delete (_ fileName: String) {
        let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory: false)
        
        //check whether or not the file exists in the documentary
        if FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.removeItem(at: url)
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
}
