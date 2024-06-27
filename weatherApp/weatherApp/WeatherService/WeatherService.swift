
import Foundation
import Alamofire

class WeatherService {
    
    private let baseUrl = "https://api.open-meteo.com/v1/forecast"
        
        func getWeatherData(latitude: Double, longitude: Double, completion: @escaping (WeatherData?) -> Void) {
            let parameters: Parameters = [
                "latitude": latitude,
                "longitude": longitude,
                "current": "temperature_2m,wind_speed_10m",
                "hourly": "temperature_2m,relative_humidity_2m,wind_speed_10m"
            ]

            AF.request(baseUrl, parameters: parameters).responseDecodable(of: WeatherData.self) { response in
                switch response.result {
                case .success(let weatherData):
                    completion(weatherData)
                case .failure(let error):
                    print("Error: \(error)")
                    completion(nil)
                }
            }
        }
}
