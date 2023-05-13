import UIKit

final class StatisticsViewController: UIViewController {
    
    //MARK: - UI elements
    private lazy var infoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var infoImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "emptyStatistics")
        return image
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.sfProMedium(size: 12)
        label.textAlignment = .center
        label.text = "Что будем отслеживать?"
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addUIElements()
        setConstraint()
        collectionView.isHidden = true
    }
}

//MARK: - Set UI elements
extension StatisticsViewController {
    private func addUIElements() {
        view.addSubview(collectionView)
        view.addSubview(infoLabel)
        view.addSubview(infoView)
        
        infoView.addSubview(infoImageView)
        infoView.addSubview(infoLabel)
        setNavigationTitle()
    }
    
    private func setNavigationTitle() {
        navigationController?.navigationBar.backgroundColor = .YPWhiteDay
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
    }
    
    private func setConstraint() {
        NSLayoutConstraint.activate([
            // statistics CollectionView
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            //Info View
            infoView.widthAnchor.constraint(equalTo: view.widthAnchor),
            infoView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            infoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            //info ImageView
            infoImageView.heightAnchor.constraint(equalToConstant: 80),
            infoImageView.widthAnchor.constraint(equalToConstant: 80),
            infoImageView.centerYAnchor.constraint(equalTo: infoView.centerYAnchor),
            infoImageView.centerXAnchor.constraint(equalTo: infoView.centerXAnchor),
            
            //info Label
            infoLabel.topAnchor.constraint(equalTo: infoImageView.bottomAnchor, constant: 8),
            infoLabel.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 16),
            infoLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -16),
            infoLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
