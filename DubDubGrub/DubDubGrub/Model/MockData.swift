//
//  MockData.swift
//  DubDubGrub
//
//  Created by Christopher Koski on 8/10/22.
//

import CloudKit

struct MockData {
  
  static var location: CKRecord {
    let record = CKRecord(recordType: "DDGLocation")
    record[DDGLocation.kName]        = "Chris's Bar and Grill"
    record[DDGLocation.kAddress]     = "123 Main Street"
    record[DDGLocation.kDescription] = "This is a test description! This is a test description! This is a test description! This is a test description! "
    record[DDGLocation.kWebsiteURL]  = "https://christopherkoski.com"
    record[DDGLocation.kLocation]    = CLLocation(latitude: 37.331516, longitude: -121.891054)
    record[DDGLocation.kPhoneNumber] = "561-601-8125"
    return record
  }
  
}
