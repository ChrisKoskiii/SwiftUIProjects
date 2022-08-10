//
//  CloudKit.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 8/9/22.
//

import SwiftUI
import CloudKit

class CloudKitUserBootCamp: ObservableObject {
  @Published var permissionStatus: Bool = false
  @Published var isSignedInToiCloud: Bool = false
  @Published var error: String = ""
  @Published var userName: String = ""
  
  init() {
    getiCloudStatus()
    requestPermission()
    fetchiCloudUserRecordID()
  }
  
  private func getiCloudStatus() {
    CKContainer.default().accountStatus { [weak self] returnedStatus, returnedError in
      DispatchQueue.main.async {
        switch returnedStatus {
        case .available:
          self?.isSignedInToiCloud = true
        case .couldNotDetermine:
          self?.error = CloudKitError.iCloudAccountNotDetermined.rawValue
        case .restricted:
          self?.error = CloudKitError.iCloudAccountRestricted.rawValue
        case .noAccount:
          self?.error = CloudKitError.iCloudAccountNotFound.rawValue
        default:
          self?.error = CloudKitError.iCloudAccountUnknown.rawValue
        }
      }
    }
  }
  
  enum CloudKitError: String, LocalizedError {
    case iCloudAccountNotFound
    case iCloudAccountNotDetermined
    case iCloudAccountRestricted
    case iCloudAccountUnknown
  }
  
  func requestPermission() {
    CKContainer.default().requestApplicationPermission([.userDiscoverability]) { [weak self] returnedStatus, returnedError in
      DispatchQueue.main.async {
        if returnedStatus == .granted {
          self?.permissionStatus = true
        }
      }
    }
  }
  
  func fetchiCloudUserRecordID() {
    CKContainer.default().fetchUserRecordID { [weak self] returnedID, returnedError in
      if let id = returnedID {
        self?.discoveriCloudUser(id: id)
      }
    }
  }
  
  func discoveriCloudUser(id: CKRecord.ID) {
    CKContainer.default().discoverUserIdentity(withUserRecordID: id) { [weak self] returnedIndentity, returnedError in
      DispatchQueue.main.async {
        if let name = returnedIndentity?.nameComponents?.givenName {
          self?.userName = name
        }
      }
    }
  }
}

struct CloudKit: View {
  @StateObject private var vm = CloudKitUserBootCamp()
    var body: some View {
      VStack {
        Text("IS SIGNED IN: \(vm.isSignedInToiCloud.description.uppercased())")
        Text(vm.error)
        Text("PERMISSION: \(vm.permissionStatus.description.uppercased())")
        Text("NAME: \(vm.userName)")
      }
    }
}

struct CloudKit_Previews: PreviewProvider {
    static var previews: some View {
        CloudKit()
    }
}
