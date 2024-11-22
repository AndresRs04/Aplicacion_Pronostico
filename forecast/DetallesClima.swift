import SwiftUI
import Foundation

struct DetallesClima: View {
    
    @Binding var resultados: [ForecastDay]
    @Binding var nombreCiudad: String
    var index: Int
    
    var body: some View {
        ZStack {
            Color.init(establecerColorDeFondo(code: resultados[index].day.condition.code))
                .ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center) {
                    Spacer()
                    
                    // Nombre de la Ciudad
                    Text("\(nombreCiudad)")
                        .font(.system(size: 35, weight: .bold))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 3)
                        .padding(.bottom, 5)
                    
                    // Fecha
                    Text("\(Date(timeIntervalSince1970: TimeInterval(resultados[index].date_epoch)).formatted(date: .complete, time: .omitted))")
                        .font(.system(size: 18))
                        .foregroundColor(.white.opacity(0.7))
                        .padding(.bottom, 10)
                    
                    // Icono del Clima
                    Text(obtenerIconoDelClima(code: resultados[index].day.condition.code))
                        .font(.system(size: 110))
                        .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 3)
                        .padding(.bottom, 15)
                    
                    // Temperatura
                    Text("\(Int(resultados[index].day.avgtemp_c))°C")
                        .font(.system(size: 50, weight: .bold))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 3)
                        .padding(.bottom, 10)
                    
                    // Descripción del clima
                    Text("\(resultados[index].day.condition.text)")
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 3)
                        .padding(.bottom, 30)
                    
                    // Sección de estadísticas
                    VStack(spacing: 20) {
                        // HStack de estadísticas
                        HStack(spacing: 20) {
                            estadisticaView(titulo: "Max Wind", valor: "\(Int(resultados[index].day.maxwind_kph))", unidad: "km/h")
                            estadisticaView(titulo: "Precipitation", valor: "\(Int(resultados[index].day.totalprecip_mm))", unidad: "mm")
                        }
                        
                        HStack(spacing: 20) {
                            estadisticaView(titulo: "Chance of Rain", valor: "\(resultados[index].day.daily_chance_of_rain)%", unidad: "showers")
                            estadisticaView(titulo: "UV Index", valor: "\(Int(resultados[index].day.uv))", unidad: "index")
                        }
                        
                        HStack(spacing: 20) {
                            estadisticaView(titulo: "Humidity", valor: "\(resultados[index].day.avghumidity)%", unidad: "currently")
                            estadisticaView(titulo: "Visibility", valor: "\(Int(resultados[index].day.avgvis_km))", unidad: "km")
                        }
                    }
                    .padding(.top, 20)
                    .padding(.horizontal, 20) // Espaciado horizontal para las tarjetas
                }
            }
        }
        .navigationTitle("Detalles del Clima")
    }
    
    // Vista reutilizable para mostrar las estadísticas de clima
    @ViewBuilder
    func estadisticaView(titulo: String, valor: String, unidad: String) -> some View {
        VStack {
            Text(titulo)
                .foregroundColor(.white.opacity(0.7))
                .font(.system(size: 14))
            
            Text(valor)
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 3)
            
            Text(unidad)
                .foregroundColor(.white.opacity(0.7))
                .font(.system(size: 14))
        }
        .frame(width: 150, height: 150, alignment: .center)
        .background(Color.white.opacity(0.1).blur(radius: 15)) // Fondo difuso
        .cornerRadius(20) // Bordes redondeados
        .shadow(radius: 10) // Sombra suave
    }
}
