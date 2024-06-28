
import Foundation

struct WeatherData: Codable {
    let current: CurrentWeather
    let hourly: HourlyWeather
}

struct CurrentWeather: Codable {
    let time: String
    let temperature2m: Double
    let windSpeed10m: Double
    
    enum CodingKeys: String, CodingKey {
        case time
        case temperature2m = "temperature_2m"
        case windSpeed10m = "wind_speed_10m"
    }
}

struct HourlyWeather: Codable {
    let time: [String]
    let windSpeed10m: [Double]
    let temperature2m: [Double]
    let relativeHumidity2m: [Int]
    
    enum CodingKeys: String, CodingKey {
        case time
        case windSpeed10m = "wind_speed_10m"
        case temperature2m = "temperature_2m"
        case relativeHumidity2m = "relative_humidity_2m"
    }
}
