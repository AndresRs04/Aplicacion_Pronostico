//
//  DetallesClima.swift
//  forecast
//
//  Created by alumno on 11/21/24.
//


import SwiftUI
import Foundation


struct DetallesClima: View {
    
    @Binding var resultados : [ForecastDay]
    @Binding var nombreCiudad: String
    var index: Int
    
    var body: some View {
        ZStack {
            Color.init(establecerColorDeFondo(code: resultados[index].day.condition.code))
                .ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack(alignment: .center) {
                    Spacer()
                    Text("\(nombreCiudad)")
                        .font(.system(size: 35))
                        .foregroundStyle(.white)
                        .bold()
                        .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y:2)
                        .padding(.bottom, 1)
                    Text("\(Date(timeIntervalSince1970:TimeInterval(resultados[index].date_epoch)).formatted(date: .complete, time: .omitted))")
                                            .font(.system(size: 16))
                                            .foregroundStyle(.white)
                                            .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                    Text(obtenerIconoDelClima(code: resultados[index].day.condition.code))
                                            .font(.system(size: 110))
                                            .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                    Text("\(Int(resultados[index].day.avgtemp_c))°C")
                                            .font(.system(size: 50))
                                            .foregroundStyle(.white)
                                            .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                    Text("\(resultados[index].day.condition.text)")
                                            .font(.system(size: 18))
                                            .foregroundStyle(.white)
                                            .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                    /*Text("Sensación de \(Int(resultados[index].hour[hour].feelslike_c))°C")
                                            .font(.system(size: 18))
                                            .foregroundStyle(.white.opacity(0.5))
                                            .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)*/
                    HStack(alignment: .center) {
                                 VStack {
                                     Text("Max Wind")
                                         .foregroundStyle(.white.opacity(0.5))
                                         .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                                     Text("\(Int(resultados[index].day.maxwind_kph))")
                                         .font(.system(size: 40))
                                         .foregroundStyle(.white)
                                         .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                                     Text("km/h")
                                         .foregroundStyle(.white.opacity(0.5))
                                         .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                                 }
                                 .frame(width: 150, height: 150, alignment: .center)
                                 .background(Color.white.blur(radius: 75).opacity(0.5))
                                 .cornerRadius(20)
                                 VStack {
                                     Text("Precipitation")
                                         .foregroundStyle(.white.opacity(0.5))
                                     Text("\(Int(resultados[index].day.totalprecip_mm))")
                                         .font(.system(size: 40))
                                         .foregroundStyle(.white)
                                         .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                                     Text("mm")
                                         .foregroundStyle(.white.opacity(0.5))
                                         .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                                 }
                                 .frame(width: 150, height: 150, alignment: .center)
                                 .background(Color.white.blur(radius: 75).opacity(0.5))
                                 .cornerRadius(20)
                             }
                             HStack(alignment: .center) {
                                 VStack {
                                     Text("Chance of rain")
                                         .foregroundStyle(.white.opacity(0.5))
                                     Text("\(resultados[index].day.daily_chance_of_rain)%")
                                         .font(.system(size: 40))
                                         .foregroundStyle(.white)
                                         .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                                     Text("showers")
                                         .foregroundStyle(.white.opacity(0.5))
                                         .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                                 }
                                 .frame(width: 150, height: 150, alignment: .center)
                                 .background(Color.white.blur(radius: 75).opacity(0.5))
                                 .cornerRadius(20)
                                 VStack {
                                     Text("UV Index")
                                         .foregroundStyle(.white.opacity(0.5))
                                     Text("\(Int(resultados[index].day.uv))")
                                         .font(.system(size: 40))
                                         .foregroundStyle(.white)
                                         .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                                     Text("index")
                                         .foregroundStyle(.white.opacity(0.5))
                                         .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                                 }
                                 .frame(width: 150, height: 150, alignment: .center)
                                 .background(Color.white.blur(radius: 75).opacity(0.5))
                                 .cornerRadius(20)
                             }
                             HStack(alignment: .center) {
                                 VStack {
                                     Text("Humidity")
                                         .foregroundStyle(.white.opacity(0.5))
                                     Text("\(resultados[index].day.avghumidity)%")
                                         .font(.system(size: 40))
                                         .foregroundStyle(.white)
                                         .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                                     Text("currently")
                                         .foregroundStyle(.white.opacity(0.5))
                                         .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                                 }
                                 .frame(width: 150, height: 150, alignment: .center)
                                 .background(Color.white.blur(radius: 75).opacity(0.5))
                                 .cornerRadius(20)
                                 VStack {
                                     Text("Visibility")
                                         .foregroundStyle(.white.opacity(0.5))
                                     Text("\(Int(resultados[index].day.avgvis_km))")
                                         .font(.system(size: 40))
                                         .foregroundStyle(.white)
                                         .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                                     Text("km")
                                         .foregroundStyle(.white.opacity(0.5))
                                         .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                                 }
                                 .frame(width: 150, height: 150, alignment: .center)
                                 .background(Color.white.blur(radius: 75).opacity(0.5))
                                 .cornerRadius(20)
                             }
                         }
                     })
                 }
        .navigationTitle("Detalles del Clima")
    }
}


