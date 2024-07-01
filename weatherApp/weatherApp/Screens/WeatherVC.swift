
import UIKit
import CoreLocation

final class WeatherVC: UIViewController {
    
    private let rootView = WeatherView()
    private var locationManager = CLLocationManager()
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startLocationManager()
    }
    
    //MARK: - Location
    private func startLocationManager() {
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.startUpdatingLocation()
    }
}



extension WeatherVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            rootView.weatherService.getWeatherData(latitude: lastLocation.coordinate.latitude, longitude: lastLocation.coordinate.longitude) { weather in
                DispatchQueue.main.async {
                    guard let weather else { return }
                    self.rootView.weatherData = weather
                    self.rootView.collectionView.reloadData()
                }
            }
        }
        locationManager.stopUpdatingLocation()
    }
}




