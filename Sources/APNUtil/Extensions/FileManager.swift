//
//  FileManager.swift
//  APNUtil
//
//  Created by Aaron Nance on 8/29/18.
//  Copyright © 2018 Nance. All rights reserved.
//

import Foundation

public extension FileManager {
    
    static func pathFor(file: String, subDir: String?) -> URL {
        
        let paths = FileManager.default.urls(for: .documentDirectory,
                                             in: .userDomainMask)
        
        var filePath = paths[0]
        
        if  let subDir = subDir, !subDir.isEmpty {
            filePath = filePath.appendingPathComponent(subDir)
        }
        
        filePath = filePath.appendingPathComponent(file)
        
        return filePath
        
    }
    
    private static func pathFor(subDir: String) -> URL? {
        
        let fileManager = FileManager.default
        
        var subDirURL: URL?
        
        if let docDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            subDirURL =  docDir.appendingPathComponent("\(subDir)")
            
            if !fileManager.fileExists(atPath: subDirURL!.path) {
                do {
                    
                    try createSubDir(subDirURL!.path)
                    
                }
                catch {
                    
                    loud("\(#function)\nError creating subdirectory:\n\(error)")
                    
                }
            }
        }
        
        return subDirURL
        
    }
    
    static func pathsForAllFilesIn(subDir: String) -> [URL] {
        var pathURLs = [URL]()
        
        let paths = pathsForContentsOf(subDir: subDir)
        
        for path in paths {
            if path.isFileURL {
                pathURLs.append(path)
            }
        }
        
        return pathURLs
        
    }
    
    private static func pathsForContentsOf(subDir: String) -> [URL] {
        
        var pathURLs = [URL]()
        
        do {
            guard let subDir = pathFor(subDir: subDir)
                else { return pathURLs }
            
            let contents = try FileManager.default.contentsOfDirectory(atPath: subDir.path)
            
            for item in contents {
                
                let url = subDir.appendingPathComponent(item)
                
                pathURLs.append(url)
            }
            
        }
        catch { loud("\(#function)\nError retrieving path URLs: \(error)") }
        
        return pathURLs
        
    }
    
    static func createSubDir(_ subDir: String) throws {
        
        let fileManager = FileManager.default
        
        if let docDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let filePath =  docDir.appendingPathComponent("\(subDir)")
            
            if !fileManager.fileExists(atPath: filePath.path) {
                
                try fileManager.createDirectory(atPath: filePath.path, withIntermediateDirectories: true, attributes: nil)
                
            }
            
        }
        
    }
    
    static func cleanFilePath(_ path: String) -> String {
        
        path.replacingOccurrences(of: #"/+"#,
                                  with: "/",
                                  options: .regularExpression)
    
    }
    
    static func deleteAllFilesInSubDir(_ subDir: String) {
        
        if subDir.isEmpty { return /*EXIT*/ }
        
        let urls = pathsForContentsOf(subDir: subDir)
        
        if urls.isEmpty { return /*EXIT*/ }
        
        for url in urls {
            
            do { try FileManager.default.removeItem(at: url) }
            catch { loud("\(#function)\nError deleting file\(url): \n\(error)") }
            
        }
        
    }
    
}
