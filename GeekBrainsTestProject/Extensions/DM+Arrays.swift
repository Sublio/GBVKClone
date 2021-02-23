//
//  DM+Arrays.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 21.02.2021.
//

import Foundation

extension Array {

    func uniqueElementsFrom(array: [String]) -> [String] {
      // Create an empty Set to track unique items
      var set = Set<String>()
      let result = array.filter {
        guard !set.contains($0) else {
          // If the set already contains this object, return false
          // so we skip it
          return false
        }
        // Add this item to the set since it will now be in the array
        set.insert($0)
        // Return true so that filtered array will contain this item.
        return true
      }
      return result
    }
}
