//
//  Funciones.swift
//  forecast
//
//  Created by alumno on 11/20/24.
//


import SwiftUI
import Foundation


func obtenerIconoDelClima(code: Int) -> String {
    var iconoDelClima = "☀️"
    switch code {
    case 1000:
        iconoDelClima = "☀️"
        break
    case 1003:
        iconoDelClima = "🌤️"
        break
    case 1273, 1276, 1279, 1282:
        iconoDelClima = "⛈️"
        break
    case 1087:
        iconoDelClima = "🌩️"
        break
    case 1147, 1135, 1030, 1009, 1006:
        iconoDelClima = "☁️"
        break
    case 1264, 1261, 1258, 1252, 1249, 1201, 1198, 1195, 1192, 1189, 1186, 1183, 1180, 1171, 1168, 1153, 1150, 1072, 1063:
        iconoDelClima = "🌧️"
    case 1255, 1246, 1243, 1240, 1237, 1225, 1222, 1219, 1216, 1213, 1210, 1207, 1204, 1117, 1114, 1069, 1066:
        iconoDelClima = "🌨️"
        break
    default:
        iconoDelClima = "☀️"
        break
    }
    print(code)
    return iconoDelClima
    
}

func establecerColorDeFondo (code: Int) -> Color {
    let azulCielo = Color.init(red: 135/255, green: 206/255, blue: 235/255)
    let gris = Color.init(red: 47/255, green: 79/255, blue: 79/255)
    var colorDeFondo = gris
    
    switch code {
    case 1000, 1003:
        colorDeFondo = azulCielo
    default:
        break
    }
    return colorDeFondo
}



func obtenerFecha(epoch: Int) -> String {
    return Date(timeIntervalSince1970:
                    TimeInterval(epoch)).formatted(Date.FormatStyle()
                        .weekday(.abbreviated))
}

func obtenerFecha(time: String) -> String {
    
    return ""
}
