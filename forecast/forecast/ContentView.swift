//
//  ContentView.swift
//  forecast
//
//  Created by alumno on 11/15/24.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    
    @State private var resultados = [ForecastDay]()
    @State var pronosticoPorHora = [Hora]()
    @State var colorDeFondo = Color.init(red: 135/255, green: 206/255, blue: 235/255)
    @State var iconoDelClima = "☀️"
    @State var tempActual = 0
    @State var condicionTexto = "Slightly Overcast"
    @State var nombreCiudad = "Washington"
    @State var cargando = true
    var body: some View {
        if cargando {
            ZStack {
                Color.init(colorDeFondo)
                    .ignoresSafeArea()
                ProgressView()
                    .scaleEffect(2, anchor: .center)
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: .infinity)
                    .task {
                        await obtenerEstadoDeclima()
                    }
            }
        } else {
            NavigationView{
                
                VStack {
                    
                    Spacer()
                    // Nombre de la ciudad
                    Text("\(nombreCiudad)")
                        .font(.system(size: 35, weight: .bold))
                        .foregroundStyle(.white)
                        .padding(.bottom, 8)
                        .padding(.top, 10)
                    
                    //Fecha y Hora
                    Text("\(Date().formatted(date: .complete, time: .omitted))")
                        .font(.system(size: 18))
                        .foregroundColor(.white.opacity(0.7))
                    
                    //Icono del Clima
                    Text(iconoDelClima)
                        .font(.system(size: 120))
                        .shadow(radius: 10)
                        .padding(.vertical,1)
                    
                    //Temperatura Actual
                    Text("\(tempActual)°C")
                        .font(.system(size: 50, weight: .bold))
                        .foregroundStyle(.white)
                        .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y:4)
                    
                    //Condición Clima
                    Text("\(condicionTexto)")
                        .font(.system(size: 22))
                        .foregroundStyle(.white)
                      
                    Spacer()
            
                    //Pronóstico por Hora
                    VStack(spacing: 8) {
                            Text("Pronóstico por Hora")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 16)
                                .padding(.top, 5)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(pronosticoPorHora) { forecast in
                                        VStack(spacing: 4) {
                                            Text("\(obtenerHora(time: forecast.time))")
                                                .font(.system(size: 14))
                                                .foregroundColor(.white)
                                                .bold()
                                            
                                            Text("\(obtenerIconoDelClima(code: forecast.condition.code))")
                                                .font(.system(size: 30))
                                                .foregroundColor(.white)
                                            
                                            Text("\(Int(forecast.temp_c))°C")
                                                .font(.system(size: 18))
                                                .foregroundColor(.white)
                                                .bold()
                                        }
                                        .frame(width: 70, height: 100)
                                        .background(Color.white.opacity(0.2))
                                        .cornerRadius(15)
                                        .padding(.vertical, 8)
                                    }
                                }
                                .padding(.horizontal, 16)
                            }
                            .padding(.bottom, 20)
                        }
                    
                    //Pronostico 3 Días
                    Text("Pronóstico de 3 Días")
                        .font(.system(size: 20))
                        .foregroundStyle(.white)
                        .bold()
                    List {
                        ForEach(Array(resultados.enumerated()), id: \.1.id ){
                            index, forecast in
                            
                        
                        NavigationLink {
                            DetallesClima(resultados: $resultados, nombreCiudad: $nombreCiudad, index: index)
                            
                        } label: {
                            
                            
                            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: nil) {
                                Text("\(obtenerFecha(epoch: forecast.date_epoch))")
                                    .frame(maxWidth: 50, alignment: .leading)
                                    .bold()
                                Text("\(obtenerIconoDelClima(code: forecast.day.condition.code))")
                                    .frame(maxWidth: 30, alignment: .leading)
                                Text("\(Int(forecast.day.avgtemp_c))°C")
                                Spacer()
                                Text("\(forecast.day.condition.text)")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                            
                        }
                        .listRowBackground(Color.white.blur(radius: 75).opacity(0.5))
                    }
                    .contentMargins(.vertical, 0)
                    .scrollContentBackground(.hidden)
                    .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
                    Spacer()
                    
                    // Footer App
                    Text("Información Proporcionada por Free Weather API")
                        .font(.system(size: 12))
                    
                }
                .background(colorDeFondo)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                
            }
        }
        
    }

    
    func obtenerEstadoDeclima () async {
        let solicitud = AF.request("http://api.weatherapi.com/v1/forecast.json?key=aa92633023c44229b4e172550241311&q=98101&days=3&aqi=no&alerts=no")
              solicitud.responseDecodable(of: Weather.self) { response in
                  switch response.result {
                  case.success(let weather):
                      var index = 0
                      nombreCiudad = weather.location.name
                      resultados = weather.forecast.forecastday
              
                      if Date(timeIntervalSince1970: TimeInterval(resultados[0].date_epoch)).formatted(Date.FormatStyle().weekday(.abbreviated)) !=
                          Date().formatted(Date.FormatStyle().weekday(.abbreviated)) {
                          index = 1
                      }
                          
                      tempActual = Int(resultados[index].day.avgtemp_c)
                      pronosticoPorHora = resultados[index].hour
                      colorDeFondo = establecerColorDeFondo(code: resultados[index].day.condition.code)
                      iconoDelClima = obtenerIconoDelClima(code: resultados[index].day.condition.code)
                      condicionTexto = resultados[index].day.condition.text
                      cargando = false
                  case.failure(let error):
            print(error)
            }
            
        }
    }
    
}

#Preview {
    ContentView()
}

