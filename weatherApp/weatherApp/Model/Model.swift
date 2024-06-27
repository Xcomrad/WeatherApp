
import Foundation

struct WeatherData: Codable {
    let current: CurrentWeather
    let hourly: HourlyWeather

    struct CurrentWeather: Codable {
        let time: String
        let temperature_2m: Double
        let wind_speed_10m: Double
    }

    struct HourlyWeather: Codable {
        let time: [String]
        let temperature_2m: [Double]
        let relative_humidity_2m: [Int]
        let wind_speed_10m: [Double]
    }
}
