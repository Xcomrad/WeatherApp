
import UIKit

final class WeatherVC: UIViewController {
    
    private lazy var degreeLabel: UILabel = {
       let label = UILabel()
        label.text = "25 C"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 50, height: 100)
        layout.minimumLineSpacing = 30
        layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemIndigo
        
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
    }
    
    func setup() {
        title = "Погода"
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



extension WeatherVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCell.reuseId, for: indexPath) as! WeatherCell
        return cell
    }
}
