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
            NavigationView {  
                
            
        VStack {

            Spacer()
            Text("\(nombreCiudad)")
                .font(.system(size: 35))
                .foregroundStyle(.white)
                .bold()
                .padding(.bottom, 1)
            Text("\(Date().formatted(date: .complete, time: .omitted))")
                .font(.system(size: 18))
            Text(iconoDelClima)
                .font(.system(size: 140))
                .shadow(radius: 75)
            Text("\(tempActual)°C")
                .font(.system(size: 60))
                .foregroundStyle(.white)
                .bold()
            Text("\(condicionTexto)")
                .font(.system(size: 20))
                .foregroundStyle(.white)
            Spacer()
            Spacer()
            Spacer()
            Text("Pronóstico por Hora")
                .font(.system(size: 18))
                .foregroundStyle(.white)
                .bold()
                .shadow(color: .black.opacity(0.2), radius: 1, x:0, y:2)
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    Spacer()
                    ForEach(pronosticoPorHora) { forecast in
                        VStack{
                            Text("\(obtenerHora(time: forecast.time))")
                                .shadow(color: .black.opacity(0.2), radius: 1, x:0, y: 2)
                            Text("\(obtenerIconoDelClima(code: forecast.condition.code))")
                                .shadow(color: .black.opacity(0.2), radius: 1, x:0, y: 2)
                            Text("\(Int(forecast.temp_c))°C")
                                .shadow(color: .black.opacity(0.2), radius: 1, x:0, y: 2)
                        }
                        .frame(width: 50, height: 90)
                    }
                    Spacer()
                    Spacer()
                }
                .background(Color.white.blur(radius: 75).opacity(0.35))
                .cornerRadius(15)
                
            }
            Text("Pronóstico de 3 Días")
                .font(.system(size: 20))
                .foregroundStyle(.white)
                .bold()
            List (resultados) { forecast in
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
                .listRowBackground(Color.white.blur(radius: 75).opacity(0.5))
            }
            .contentMargins(.vertical, 0)
            .scrollContentBackground(.hidden)
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
            Spacer()
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
                      nombreCiudad = weather.location.name
                      resultados = weather.forecast.forecastday
                      
                      var index = 0
              
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

