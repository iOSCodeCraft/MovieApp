//
//  CacheManager.swift
//  MovieApp
//
//  Created by manya on 04/03/24.
//

import Foundation

protocol CacheManager {
    func saveDataToCache<T: Encodable>(for key: UserDefaultKeys, _ data: T)
    func loadCachedData<T: Decodable>(for key: UserDefaultKeys, result: T.Type) -> T?
}

extension CacheManager {
    
    func saveDataToCache<T: Encodable>(for key: UserDefaultKeys, _ data: T) {
           do {
               let encoder = JSONEncoder()
               let encodedData = try encoder.encode(data)
               UserDefaults.standard.set(encodedData, forKey: key.rawValue)
           } catch {
               print("Error encoding data: \(error.localizedDescription)")
           }
       }

    func loadCachedData<T: Decodable>(for key: UserDefaultKeys, result: T.Type) -> T? {
        if let cachedData = UserDefaults.standard.data(forKey: key.rawValue) {
               do {
                   let decoder = JSONDecoder()
                   let decodedData = try decoder.decode(result.self, from: cachedData)
                   return decodedData
               } catch {
                   print("Error decoding cached data: \(error.localizedDescription)")
                   return nil
               }
           }
           return nil
       }
    
    func cleanupCache(for key: UserDefaultKeys) {
        UserDefaults.standard.set(nil, forKey: key.rawValue)
    }
}
