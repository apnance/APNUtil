//
//  CodableArchiver.swift
//  APNUtil
//
//  Created by Aaron Nance on 3/19/18.
//  Copyright © 2018 Aaron Nance. All rights reserved.
//

import Foundation

public struct CodableArchiver {
    
    public static func archive<T: Codable>(_ codable: T,
                                           toFile file: String,
                                           inSubDir subDir: String?) {
        
        let url = FileManager.pathFor(file: file, subDir: subDir)
        
        let archiver = NSKeyedArchiver(requiringSecureCoding: true)
        
        do {
            
            if let subDir = subDir { try FileManager.createSubDir(subDir) }
            
            try archiver.encodeEncodable(codable, forKey: NSKeyedArchiveRootObjectKey)
            try archiver.encodedData.write(to: url)
            
        }
        catch { loud("\(#function)\n\nError archiving: Error\n\(error)") }
    }
    
    private static func unarchive<T: Decodable> (fileAtURL url: URL) -> T? {
        
        var unarchived: T?
        
        do {
            
            let data = try Data(contentsOf: url)
            
            let unarchiver = try! NSKeyedUnarchiver(forReadingFrom: data)
            
            unarchived = try unarchiver.decodeTopLevelDecodable(T.self, forKey: NSKeyedArchiveRootObjectKey)
            
            unarchiver.finishDecoding()
            
        }
        catch { loud("\(#function)\nError unarchiving: \(url)\n\(error)") }
        
        return unarchived
    }
    
    public static func unarchive<T: Decodable> (file: String, inSubDir subDir: String?) -> T? {
        
        let url = FileManager.pathFor(file: file, subDir: subDir)
        
        return unarchive(fileAtURL: url)

    }
    
    /// Attempts to unarchive all files in directory as T.
    public static func unarchive<T: Decodable> (subDir: String) -> [T]? {
        
        var unarchived = [T]()
        
        let urls = FileManager.pathsForAllFilesIn(subDir: subDir)
        if urls.isEmpty { return nil /*EXIT*/ }
        
        for url in urls {
            
            if let current: T = unarchive(fileAtURL: url) {
                unarchived.append(current)
            }
            
        }
        
        return unarchived.isEmpty ? nil : unarchived
        
    }
    
    /// Convenience method for checking for the existence of a specified file in a specified sub directory of the document direcotry of the file system.
    public static func archiveFileExistsFor(_ file: String,
                                            inSubDir subDir: String ) -> Bool {
        
        let path = FileManager.pathFor(file: file,
                                       subDir: subDir).absoluteString
        
        return FileManager.default.fileExists(atPath: path)
        
    }
}

public extension CodableArchiver {
    
    /// Returns an instance of type `T` from supplied `JSONString`.
    static func instanceFrom<T: Decodable>(jsonString string: JSONString) -> T? {
        
        let jsonData = Data(string.utf8)
        
        do {
           
            return try JSONDecoder().decode(T.self, from: jsonData) /*EXIT*/
            
        } catch {
            
            Utils.log("\(#function):\nError trying to unarchive file:\n\(error)")
            
        }
        
        return nil
        
    }
    
    /// Attempts to return an instance of type `T` from JSON located at `url`
    static func instanceFrom<T: Decodable>(url: URL) -> T? {
        
        if let data = try? Data(contentsOf: url) {
        
            let decoder = JSONDecoder()
            
            return try? decoder.decode(T.self, from: data) /*EXIT*/
            
        } else {
            
            Utils.log("Unable to decode Data as JSON.")
            
        }
        
        return nil
        
    }
    
    /// Attempts to create an instance of `T` from .json file.
    /// - parameter fileName: name of the file in the main bundle
    /// - parameter fileExtension: string containing the extension of the file in the main bundle.
    ///
    /// - returns: an instance of type`T?`
    static func instanceFromJsonFile<T:Decodable>(fileName name: String,
                                                  fileExtension ext: String) -> T? {

        let path = Bundle.main.url(forResource: name,
                                   withExtension: ext)

        let serialized = try! String(contentsOf: path!,
                                     encoding: String.Encoding.utf8)

        let instance:T? = instanceFrom(jsonString: serialized)
        
        return instance
        
    }

}

public extension Encodable {
    
    /// Returns standalone code to re-instantiate the encoded object.
    /// This method is intended for generating objects for testing.
    ///
    /// Note: the object type must be specified when pasting into code.
    func generateReInstantiationCode() -> String? {
        
        if let escaped = jsonStringSortedEscaped {
            
            let objType = String(describing: type(of: self))
            
            return """
                        // Generated By: \(#function)()
                        let decodedObj: \(objType) = CodableArchiver.instanceFrom(jsonString: \"\(escaped)\")!
                    """ // EXIT
            
        }
        
       return nil // EXIT
        
    }
    
    var jsonData: Data? {
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = []
        
        return try? encoder.encode(self)
        
    }
    
    var jsonString: String? {
        
        var jsonString: String?
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = []
        
        if let json = try? encoder.encode(self) {
            
            jsonString = String(data: json, encoding: String.Encoding.utf8)
            
        }
        
        return jsonString
        
    }
    
    var jsonStringSortedEscaped: String? {
        
        return jsonStringSorted?.replacingOccurrences(of: "\"", with: "\\\"")
        
    }
    
    var jsonStringSorted: String? {
        
        var jsonString: String?
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys]
        
        
        if let json = try? encoder.encode(self) {
            
            
            jsonString = String(data: json, encoding: String.Encoding.utf8)
            
        }
        
        return jsonString
        
    }
    
    var jsonStringPrettySorted: String? {

        var jsonString: String?
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

        
        if let json = try? encoder.encode(self) {
        
            
            jsonString = String(data: json, encoding: String.Encoding.utf8)
            
        }
        
        return jsonString
        
    }
}
