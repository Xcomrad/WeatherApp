
import UIKit

final class WeatherVC: UIViewController {
    
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
        
        fetchWeather()
    }
    
    private func fetchWeather() {
        let latitude = 52.0609511
        let longitude = 23.7397570
        weatherService.getWeatherData(latitude: latitude, longitude: longitude) { [weak self] weather in
            DispatchQueue.main.async {
                guard let weather = weather else { return }
                self?.weatherData = weather
                self?.collectionView.reloadData()
            }
        }
    }
}



extension WeatherVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherData?.hourly.time.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCell.reuseId, for: indexPath) as! WeatherCell
        if let weatherData = weatherData {
            let currentTemp = weatherData.current.temperature_2m
            let time = weatherData.hourly.time[indexPath.row]
            let temperature = weatherData.hourly.temperature_2m[indexPath.row]
            let humidity = weatherData.hourly.relative_humidity_2m[indexPath.row]
            let windSpeed = weatherData.hourly.wind_speed_10m[indexPath.row]
            
            degreeLabel.text = "Сейчас \(currentTemp)°C"
            cell.update(time: time, temperature: temperature, humidity: humidity, windSpeed: windSpeed)
        }
        return cell
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
