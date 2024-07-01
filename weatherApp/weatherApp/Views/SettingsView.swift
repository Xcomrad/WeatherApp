
import UIKit

final class SettingsView: UIView {
    
    var completionSwithTheme: (()->())?
    
    lazy var themeLabel: UILabel = {
        let label = UILabel()
        label.text = "Тема"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    lazy var segmentControlTheme: UISegmentedControl = {
        let items = ["Дневная", "Ночная"]
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = UserDefaults.standard.bool(forKey: "isDarkMode") ? 1 : 0
        control.backgroundColor = .systemGray6
        control.layer.cornerRadius = 8
        control.layer.shadowColor = UIColor.white.cgColor
        control.layer.shadowOffset = CGSize(width: 0, height: 2)
        control.layer.shadowRadius = 4
        control.layer.shadowOpacity = 0.3
        control.layer.masksToBounds = false
        control.addTarget(self, action: #selector(switchTheme), for: .valueChanged)
        return control
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Action
    @objc func switchTheme(_ sender: UISegmentedControl) {
        completionSwithTheme?()
    }
}



extension SettingsView {
    
    func setup() {
        backgroundColor = .systemIndigo
    }
    
    func setupViews() {
        addSubview(themeLabel)
        addSubview(segmentControlTheme)
        
    }
    
    func setupConstraints() {
        themeLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.leading.equalTo(self.snp.leading).inset(20)
        }
        
        segmentControlTheme.snp.makeConstraints { make in
            make.top.equalTo(themeLabel.snp.top).inset(30)
            make.leading.trailing.equalTo(self).inset(20)
        }
    }
}
