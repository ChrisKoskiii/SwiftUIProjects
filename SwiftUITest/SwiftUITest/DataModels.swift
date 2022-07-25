//
//  DataModels.swift
//  SwiftUITest
//
//  Created by Christopher Koski on 7/22/22.
//

//I have included CodingKeys to conver the snake_case to camelCase

import Foundation

struct SendConfirmResetPass: Codable {
  var newpassword1: String
  var newpassword2: String
  var uid: String
  var token: String
}

struct SendGoogleTokenId: Codable {
  var provider: String = "google-oauth2"
  var code: String
}

struct SendProfile: Codable {
  var firstName: String
  var lastName: String
  var email: String
  var birthDate: String?
  var height: Float?
  var smoker: Bool
  var country: Int?
  var measuringSystem: Int
  
  enum CodingKeys: String, CodingKey {
    case firstName = "first_name"
    case lastName = "last_name"
    case birthDate = "birth_date"
    case measuringSystem = "measuring_system"
    case email, height, smoker, country
  }
}

struct SendUserProfile: Codable {
  var birthDate: String?
  var country: Int?
  var gender: Int?
  var height: Int?
  var smoker: Bool
  var measuringSystem: Int
  
  enum CodingKeys: String, CodingKey {
    case birthDate = "birth_date"
    case measuringSystem = "measuring_system"
    case country, gender, height, smoker
  }
}

struct ResultSimpleCountry: Codable {
  let id: Int?
  let value: String?
}

struct ResultListCountries: Codable {
  let countries: [ResultSimpleCountry]?
}

struct ResultSimpleGender: Codable {
  let id: Int?
  let value: String?
}

struct ResultListGender: Codable {
  let genders: [ResultSimpleGender]?
}

struct ResultSimpleFavorites: Codable {
  let name: String?
  let value: String?
  let color: String?
  let desc: String?
}

struct ResultFavorites: Codable {
  let params: [ResultSimpleFavorites]?
}

struct ResultProfile: Codable {
  let firstName: String?
  let lastName: String?
  let email: String?
  let image: String?
  
  enum CodingKeys: String, CodingKey {
    case firstName = "first_name"
    case lastName = "last_name"
    case email, image
  }
}

struct CurrentLocale: Codable {
  let locale: String
}

struct SendEmail: Codable {
  let email: String
}

struct SendUser: Codable {
  var email: String
  var password: String
}

struct SendRefresh: Codable {
  var refresh: String
}

struct SendDevice: Codable {
  var deviceUUID: String
  var osName: String
  var osVersion: String
  var deviceModel: String
  var appVersion: String
  
  enum CodingKeys: String, CodingKey {
    case deviceUUID = "device_uuid"
    case osName = "os_name"
    case osVersion = "os_version"
    case deviceModel = "device_model"
    case appVersion = "app_version"
  }
}

struct SendRefreshToken: Codable {
  var token: SendRefresh
  var device: SendDevice
}

struct SendLogin: Codable {
  var user: SendUser
  var device: SendDevice
}

struct ResultUserProfile: Codable {
  let birthDate: String?
  let country: Int?
  let gender: Int?
  let height: Float?
  let smoker: Bool?
  let measuringSystem: Int?
  
  enum CodingKeys: String, CodingKey {
    case birthDate = "birth_date"
    case measuringSystem = "measuring_system"
    case country, gender, height, smoker
  }
}

struct ResultPolicy: Codable {
  let policy: String?
}

struct ResultExist: Codable {
  let exist: Bool?
}

struct ResultToken: Codable {
  let access: String?
  let refresh: String?
}

struct ResultTokenFromGoogle: Codable {
  let token: String?
  let refresh: String?
}

struct ResultFirstTimeStamp: Codable {
  let timestamp: String?
}

struct ResultDeleteUser: Codable {
  let delete: String?
}

struct ResultAnalyze: Codable {
  let bmi: [String]?
  let obesityLevel: [String]?
  let idealWeight: Float?
  let baseMetabolism: Int?
  let caloriesToLowWeight: Int?
  let waistToHipProportion: Float?
  let passportAge: Int?
  let commonRiskLevel: [String]?
  let prognosticAge: Int?
  let fatPercent: [String]?
  let bodyType: String?
  let unfilled: String?
//  let diseaseRisk: [ResultDiseaseRisk]?
//  let commonRecommendations: [ResultCommonRecommendations]?
  
  enum CodingKeys: String, CodingKey {
    case obesityLevel = "obesity_level"
    case idealWeight = "ideal_weight"
    case baseMetabolism = "base_metabolism"
    case caloriesToLowWeight = "calories_to_low_weight"
    case waistToHipProportion = "waist_to_hip_proportion"
    case passportAge = "passport_age"
    case commonRiskLevel = "common_risk_level"
    case prognosticAge = "prognostic_age"
    case fatPercent = "fat_percent"
    case bodyType = "body_type"
//    case diseaseRisk = "disease_risk"
//    case commonRecommendations = "common_recommendations"
    case bmi, unfilled
  }
}
