//
//  FileManager+Extension.swift
//  BuDeJie
//
//  Created by he on 2017/8/14.
//  Copyright © 2017年 hezongjiang. All rights reserved.
//

import Foundation



extension FileManager {
    
    var documentDirectory: String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    }
    
    var cachesDirectory: String {
        return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
    }
    
    /// 获取文件大小
    ///
    /// - Parameter filePath: 文件路径
    /// - Returns: 文件大小
    func fileSize(atPath filePath: String, completion: @escaping (_ totalSize: UInt) -> ()) {
        
        if !fileExists(atPath: filePath) { return }
        
        DispatchQueue.global().async {
            
            guard let subPaths = self.subpaths(atPath: filePath) else { return }
            
            var totalSize: UInt = 0
            
            if subPaths.count > 0 {
                
                for subPath in subPaths {
                    
                    let path = filePath + "/" + subPath
                    totalSize += ((try? self.attributesOfItem(atPath: path))?[.size] as? UInt ?? 0)
                }
                
            } else {
                
                totalSize = (try? self.attributesOfItem(atPath: filePath))?[.size] as? UInt ?? 0
            }
            
            DispatchQueue.main.async {
                
                completion(totalSize)
            }
        }
    }
    
    /// 删除文件
    ///
    /// - Parameter filePath: 文件路径
    func deleteFile(atPath filePath: String) {
        
        if !fileExists(atPath: filePath) { return }
        
        try? removeItem(atPath: filePath)
    }
    
}
