//
//  Model.swift
//  lecture8
//
//  Created by admin on 08.02.2021.
//

import Foundation


public struct Model: Codable{
    let dt: Int?
    let timezone: String?
    let hourly: [Current]?
    let daily: [Daily]?
    let current: Current?
    let name: String?
}

struct Current: Codable {
    let dt: Int?
    let temp: Double?
    let feels_like: Double?
    let weather: [Weather]?
}

struct Daily: Codable {
    let dt: Int?
    let weather: [Weather]?
    let temp: Temp?
    let feels_like: Temp?
    
    
}

struct Temp: Codable {
    let day: Double?
}

struct Weather: Codable {
    let main: String?
    let description: String?
}


