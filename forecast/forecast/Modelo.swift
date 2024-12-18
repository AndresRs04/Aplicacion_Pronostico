//
//  Modelo.swift
//  forecast
//
//  Created by alumno on 11/20/24.
//

import Foundation
import SwiftUI

struct Weather: Codable {
    var location: Location
    var forecast: Forecast
}

struct Location: Codable {
    var name: String
}

struct Forecast: Codable {
    var forecastday: [ForecastDay]
}

struct ForecastDay: Codable, Identifiable {
    var date_epoch: Int
    var id: Int {date_epoch}
    var day: Day
}

struct Day: Codable {
    var avgtemp_c: Double
    var hour: [Hora]
    var condition: Condition
}

struct Condition: Codable {
    var text: String
    var code: Int
}

struct Hora: Codable, Identifiable {
    var time_epoch: Int
    var time: String
    var temp_c: Double
    var condition: Condition
    var id: Int {time_epoch}
}
