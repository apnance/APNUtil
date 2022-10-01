//
//  Report.swift
//  APNUtil
//
//  Created by Aaron Nance on 3/26/20.
//  Copyright © 2020 Aaron Nance. All rights reserved.
//

import Foundation

/// A catchall `Struct` for centralizing the formatting of data of various types into various forms.
public struct Report {
        
    /// Formats data left padded columns with headers.  Data is left padded to a width equal to the width of
    /// the header string for its column.
    ///
    /// - important: the width of the columns is dictated by the width (i.e. character count) of each header
    /// element.
    ///
    /// ```
    /// //Example:
    /// headers  = ["Column1", "  Col2", "  Last Column"]
    /// data     = [[1,2,3],
    ///             [400,500,600]]
    /// print(columnate(data, headers: headers, dataPadType: .center))
    ///
    /// //Results:
    /// ===========================
    ///
    /// Column1  Col2  Last Column
    /// ---------------------------
    ///     1      2         3
    ///    400    500       600
    /// ===========================
    /// ```
    ///
    /// - returns: String formatted report.
    public static func columnate<T: CustomStringConvertible,
                                 U: CustomStringConvertible> (_ rows: [[T]],
                                                              headers: [U],
                                                              title: String = "",
                                                              dataPadType: String.PaddingType = .left) -> String {
        
        let title       = title.isEmpty ?  "" : "\(title)\n"
        var header      = ""
        var data        = ""
        var footnote    = ""
        var colWidths   = [Int]()
        
        func separator(_ char: Character = "-") -> String { String(repeating: char, count: header.count) }
        
        // Headers
        if headers.count > 0 {
            
            assert(headers.count == rows[0].count,
                   "Header count(\(headers.count)) and data count(\(rows[0].count)) must be equal but are not.")
            
            header = "\n"
            
            for columnHead in headers {
                
                let text = columnHead.description
                colWidths.append(text.count)
                
                header += "\(text)"
                
            }
            
            header = header + "\n"
            
        }
        
        // Row Data
        for rowData in rows {
            
            for (i, datum) in rowData.enumerated() {
                
                let colWidth = colWidths[i]
                
                if colWidth < datum.description.count {
                    
                    footnote = """
                                
                                
                                Note:
                                    *Some data has been truncated because its character count
                                     exceeded column width.
                                
                                    *Add whitespace to header(s) of column(s) with truncated
                                     data to increase column width and prevent this truncation.
                                """
                    
                }
                
                switch dataPadType {
                
                    case .left:
                        data += datum.leftPadded(toLength: colWidth, withPad: " ")
                        
                    case .right:
                        data += datum.rightPadded(toLength: colWidth, withPad: " ")
                        
                    case .center:
                        data += datum.centerPadded(toLength: colWidth, withPad: " ")
                    
                }
                
            }
            
            data += "\n"
            
        }
        
        return  """
                \(separator("="))
                \(title)\
                \(header)
                \(separator())
                \(data.trimmingCharacters(in: .newlines))\
                \(footnote)
                \(separator("="))
                """
        
    }
    
    /// Formats data left padded columns with headers.  Data is left padded to a width equal to the width of
    /// the header string for its column.
    ///
    /// - important: the width of the columns is dictated by the width (i.e. character count) of the widest
    /// string in each column, including header columns.
    ///
    /// ```
    /// //Example:
    /// headers  = ["Column1", "  Col2", "  Last Column"]
    /// data     = [[1,2,3],
    ///             [400,500,600]]
    /// print(columnate(data, headers: headers, dataPadType: .center))
    ///
    /// //Results:
    /// ===========================
    ///
    /// Column1  Col2  Last Column
    /// ---------------------------
    ///     1      2         3
    ///    400    500       600
    /// ===========================
    /// ```
    ///
    /// - returns: String formatted report.
    public static func columnateAutoWidth<T: CustomStringConvertible,
                                          U: CustomStringConvertible> (_ rows: [[T]],
                                                                       headers: [U],
                                                                       title: String = "",
                                                                       dataPadType: String.PaddingType = .left) -> String {
        
        let title       = title.isEmpty ?  "" : "\(title)\n"
        var header      = ""
        var data        = ""
        var colWidths   = Array(repeating: 0, count: headers.count)
        
        func separator(_ char: Character = "-") -> String { String(repeating: char, count: header.count) }
        
        
        // Column Widths
        for (i, columnHead) in headers.enumerated() {
            
            colWidths[i] = columnHead.description.count + 2
            
        }
        
        for row in rows {
            
            for (i, col) in row.enumerated() {
                
                let currWidth = col.description.count + 2
                
                if i < colWidths.count {
                    
                    colWidths[i] = max(colWidths[i], currWidth)
                    
                } else {
                    
                    colWidths.append(currWidth)
                    
                }
                
            }
            
        }
        
        // Headers
        if headers.count > 0 {
            
            assert(headers.count == rows[0].count,
                   "Header count(\(headers.count)) and data count(\(rows[0].count)) must be equal but are not.")
            
            header = "\n"
            
            for (i, columnHead) in headers.enumerated() {
                
                let text = columnHead.description.centerPadded(toLength: colWidths[i])
                
                header += "\(text)"
                
            }
            
            header = header + "\n"
            
        }
        
        // Row Data
        for rowData in rows {
            
            for (i, datum) in rowData.enumerated() {
                
                let colWidth = colWidths[i]
                
                switch dataPadType {
                
                    case .left:
                        data += datum.leftPadded(toLength: colWidth,
                                                 withPad: " ")
                        
                    case .right:
                        data += datum.rightPadded(toLength: colWidth,
                                                  withPad: " ")
                        
                    case .center:
                        data += datum.centerPadded(toLength: colWidth,
                                                   withPad: " ")
                    
                }
                
            }
            
            data += "\n"
            
        }
        
        return  """
                \(separator("="))
                \(title)\
                \(header)\
                \(separator())
                \(data.trimmingCharacters(in: .newlines))
                \(separator("="))
                """
        
    }
    
    /// Prints the report out in text suitable for pasting into a .csv file.
    public static func csv(_ rows: [[CustomStringConvertible]],
                           title: String = "",
                           headers: [CustomStringConvertible],
                           delimiter: String = ",") -> String {
        
        var data = title
        if data != "" { data += "\n" }
        
        var combined = Array(repeating: headers, count: rows.count + 1)
        
        for (i, row) in rows.enumerated() { combined[i + 1] = row }
        
        for row in combined {
            
            for col in row {
                
                data += col.description
                data += delimiter
                
            }
            
            data = data.snip()
            
            data += "\n"
            
        }
        
        return data
        
    }
    
}

extension Report {
    
    /// Writes a CSV report to /tmp/*appName*_*fileSuffix*/_v*version*.csv
    /// - note: For configuring app to write files to Mac HD, see:
    ///         https://stackoverflow.com/questions/47267238/write-to-a-file-xcode-macos
    @discardableResult static public func write(data: [[String]],
                                                headers: [String],
                                                fileSuffix: String,
                                                versionOverride version: String?) -> String {
        
        let report = csv(data, headers: headers).replacingOccurrences(of: "÷", with: "/")
        
        let appName     = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") ?? Bundle.main.object(forInfoDictionaryKey: "CFBundleName") ?? "Bundle_Name_Not_Found"
        let appVersion  = version ?? "\(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") ?? "")"
        let fileName    = "\(appName)_\(fileSuffix)_v\(appVersion).csv"
        let filePath    = "/tmp/\(appName)/"
        
        FileWriter.writeToTmp(text: report, filePath: filePath, fileName: fileName)
        
        return report
        
    }
    
}
