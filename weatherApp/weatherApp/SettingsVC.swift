
import UIKit

final class SettingsVC: UIViewController {
    
    lazy var unitLabel: UILabel = {
        let label = UILabel()
        label.text = "Градусы"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    lazy var segmentControl: UISegmentedControl = {
        let items = ["Цельсий", "Фаренгейт"]
        let control = UISegmentedControl(items: items)
        control.backgroundColor = .systemGray6
        control.selectedSegmentIndex = 0
        control.layer.cornerRadius = 8
        control.layer.shadowColor = UIColor.white.cgColor
        control.layer.shadowOffset = CGSize(width: 0, height: 2)
        control.layer.shadowRadius = 4
        control.layer.shadowOpacity = 0.3
        control.layer.masksToBounds = false
        control.addTarget(self, action: #selector(switchControl), for: .touchUpInside)
        return control
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupViews()
        setupConstraints()
    }
    
    //MARK: - Action
    @objc func switchControl() {
        //let index = segmentControl.selectedSegmentIndex
        // logic
    }
}



extension SettingsVC {
    
    func setup() {
        view.backgroundColor = .systemIndigo
    }
    
    func setupViews() {
        view.addSubview(unitLabel)
        view.addSubview(segmentControl)
        
    }
    
    func setupConstraints() {
        unitLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.leading.equalTo(view.snp.leading).inset(20)
        }
        
        segmentControl.snp.makeConstraints { make in
            make.top.equalTo(unitLabel.snp.top).inset(40)
            make.leading.trailing.equalTo(view).inset(20)
        }
    }
}
