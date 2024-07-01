
import UIKit

class WeatherView: UIView {
    
    let weatherService = WeatherService()
    var weatherData: WeatherData?
    
    private lazy var degreeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 35, weight: .regular)
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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



extension WeatherView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherData?.hourly.relativeHumidity2m.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCell.reuseId, for: indexPath) as! WeatherCell
        update(indexPath.row, cell)
        return cell
    }
}



extension WeatherView {
    
    func setup() {
        backgroundColor = .systemIndigo
    }
    
    func setupView() {
        addSubview(degreeLabel)
        addSubview(collectionView)
    }
    
    func setupConstraints() {
        
        degreeLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(self).inset(50)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(degreeLabel.snp.top).inset(50)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(self)
        }
    }
}
