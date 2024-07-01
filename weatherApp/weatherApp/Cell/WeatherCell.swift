
import UIKit

final class WeatherCell: UICollectionViewCell {
    
    static var reuseId = "WeatherCell"
    
    private lazy var verticalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private lazy var timeLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private lazy var humidityLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private lazy var windSpeedLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
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
    
    //MARK: - Update
    func update(time: String, temperature: Double, humidity: Int, windSpeed: Double) {
            timeLabel.text = "Время: \(time)"
            temperatureLabel.text = "Темпаратура: \(temperature)°C"
            humidityLabel.text = "Влажность: \(humidity)%"
            windSpeedLabel.text = "Ветер: \(windSpeed) м/c"
        }
}



extension WeatherCell {
    
    func setup() {
        backgroundColor = .systemGray6
        layer.cornerRadius = 20
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowRadius = 5
    }
    
    func setupView() {
        contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(timeLabel)
        verticalStackView.addArrangedSubview(temperatureLabel)
        verticalStackView.addArrangedSubview(humidityLabel)
        verticalStackView.addArrangedSubview(windSpeedLabel)
    }
    
    func setupConstraints() {
        verticalStackView.snp.makeConstraints { make in
            make.edges.equalTo(self).inset(10)
        }
    }
}
