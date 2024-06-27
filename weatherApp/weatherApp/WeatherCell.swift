
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
        label.text = "Дата 28.06.2024"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var teperetureLabel: UILabel = {
       let label = UILabel()
        label.text = "Температура 25 C"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private lazy var humidityLabel: UILabel = {
       let label = UILabel()
        label.text = "Влажность 16 %"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private lazy var windSpeedLabel: UILabel = {
       let label = UILabel()
        label.text = "Ветер 3 м/с"
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
}



extension WeatherCell {
    
    func setup() {
        self.backgroundColor = .systemGray6
        self.layer.cornerRadius = 20
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.layer.shadowRadius = 5
    }
    
    func setupView() {
        contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(timeLabel)
        verticalStackView.addArrangedSubview(teperetureLabel)
        verticalStackView.addArrangedSubview(humidityLabel)
        verticalStackView.addArrangedSubview(windSpeedLabel)
    }
    
    func setupConstraints() {
        verticalStackView.snp.makeConstraints { make in
            make.edges.equalTo(self).inset(10)
        }
    }
}
