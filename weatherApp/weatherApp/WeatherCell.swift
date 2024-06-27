
import UIKit

final class WeatherCell: UICollectionViewCell {
    
    static var reuseId = "WeatherCell"
    
    private lazy var verticalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        return stack
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
    
    func setup() {
        contentView.backgroundColor = .systemGray6
        contentView.layer.cornerRadius = 20
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 4
    }
    
    func setupView() {
        contentView.addSubview(verticalStackView)
    }
    
    func setupConstraints() {
        verticalStackView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
}
