import UIKit

final class CreateTracker: UIViewController {
    
    //MARK: - UI elements
    private lazy var createWontButtun: UIButton = {
        UIButton.systemButton(with: UIImage(), target: self, action: #selector(newRegularWont))
    }()
    
    private lazy var irregularEvent: UIButton = {
        UIButton.systemButton(with: UIImage(), target: self, action: #selector(newIrregularEvent))
    }()
    
    private lazy var titleLable: UILabel = {
        UILabel()
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addUIElements()
        setConstraint()
       
    }
    
    //MARK: - Action button
    @objc
    private func newRegularWont() {
        let vc = NewRegularWontViewController()
        let navigationVC = UINavigationController(rootViewController: vc)
        present(navigationVC, animated: true)
    }
    
    @objc
    private func newIrregularEvent() {
//        let vc = NewIrregularEventViewController()
//        let navigationVC = UINavigationController(rootViewController: vc)
//        present(navigationVC, animated: true)
    }
}


//MARK: - Set constraints
private extension CreateTracker {
    private func addUIElements() {
        view.addSubview(createWontButtun)
        view.addSubview(irregularEvent)
        
        navigationItem.title = "Создание трекера"
        view.backgroundColor = .YPWhiteDay
    }
    
    private func setConstraint() {
        //Create Wont Buttun
        createWontButtun.translatesAutoresizingMaskIntoConstraints = false
        createWontButtun.setTitle("Привычка", for: .normal)
        createWontButtun.titleLabel?.font = UIFont.sfProMedium(size: 16)
        createWontButtun.backgroundColor = .YPBlackDay
        createWontButtun.tintColor = .YPWhiteDay
        createWontButtun.layer.cornerRadius = 16
        
        
        //Create Wont Irregular event
        irregularEvent.translatesAutoresizingMaskIntoConstraints = false
        irregularEvent.setTitle("Нерегулярные событие", for: .normal)
        irregularEvent.titleLabel?.font = UIFont.sfProMedium(size: 16)
        irregularEvent.backgroundColor = .YPBlackDay
        irregularEvent.tintColor = .YPWhiteDay
        irregularEvent.layer.cornerRadius = 16
        
        NSLayoutConstraint.activate([
            
            createWontButtun.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            createWontButtun.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            createWontButtun.heightAnchor.constraint(equalToConstant: 60),
            createWontButtun.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            irregularEvent.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            irregularEvent.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            irregularEvent.heightAnchor.constraint(equalToConstant: 60),
            irregularEvent.topAnchor.constraint(equalTo: createWontButtun.bottomAnchor, constant: 16)
        ])
    }
}
