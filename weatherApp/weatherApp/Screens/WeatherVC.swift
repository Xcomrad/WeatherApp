
import UIKit
import CoreLocation

final class WeatherVC: UIViewController {
    
    private var locationManager = CLLocationManager()
    private let weatherService = WeatherService()
    private var weatherData: WeatherData?
    
    private lazy var degreeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 35, weight: .regular)
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 50, height: 100)
        layout.minimumLineSpacing = 30
        layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemIndigo
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(WeatherCell.self, forCellWithReuseIdentifier: WeatherCell.reuseId)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupView()
        setupConstraints()
        
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



extension WeatherVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherData?.hourly.relativeHumidity2m.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCell.reuseId, for: indexPath) as! WeatherCell
        update(indexPath.row, cell)
        return cell
    }
}



extension WeatherVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            weatherService.getWeatherData(latitude: lastLocation.coordinate.latitude, longitude: lastLocation.coordinate.longitude) { [weak self] weather in
                DispatchQueue.main.async {
                    guard let weather else { return }
                    self?.weatherData = weather
                    self?.collectionView.reloadData()
                }
            }
        }
        locationManager.stopUpdatingLocation()
    }
}



extension WeatherVC {
    // MARK: - Update
    func update(_ indexPath: Int, _ cell: WeatherCell) {
        if let weatherData = weatherData {
            let currentTemp = weatherData.current.temperature2m
            let time = weatherData.hourly.time[indexPath]
            let temperature = weatherData.hourly.temperature2m[indexPath]
            let humidity = weatherData.hourly.relativeHumidity2m[indexPath]
            let windSpeed = weatherData.hourly.windSpeed10m[indexPath]
            
            degreeLabel.text = "Сейчас \(currentTemp)°C"
            cell.update(time: time, temperature: temperature, humidity: humidity, windSpeed: windSpeed)
        }
    }
}



extension WeatherVC {
    
    func setup() {
        view.backgroundColor = .systemIndigo
    }
    
    func setupView() {
        view.addSubview(degreeLabel)
        view.addSubview(collectionView)
    }
    
    func setupConstraints() {
        
        degreeLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(view).inset(50)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(degreeLabel.snp.top).inset(50)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(view)
        }
    }
}
