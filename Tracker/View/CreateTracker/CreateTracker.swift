import UIKit

protocol ReloadCoolectionView: AnyObject {
    func reloadCollection()
}

final class CreateTracker: UIViewController {
    
    //MARK: - UI elements
    private lazy var createWontButton: UIButton = {
        UIButton.systemButton(with: UIImage(), target: self, action: #selector(newRegularWont))
    }()
    
    private lazy var irregularEvent: UIButton = {
        UIButton.systemButton(with: UIImage(), target: self, action: #selector(newIrregularEvent))
    }()
    
    private lazy var titleLabel: UILabel = {
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
        let vc = EventViewController()
        let eventViewModel = EventViewModel(model: Constant.Event.newRegularEvent)
        vc.setViewModel(viewModel: eventViewModel, title: eventViewModel.title)
        let navigationVC = UINavigationController(rootViewController: vc)
        present(navigationVC, animated: true)
    }
    
    @objc
    private func newIrregularEvent() {
        let vc = EventViewController()
        let eventViewModel = EventViewModel(model: Constant.Event.newIrRegularEvent)
        vc.setViewModel(viewModel: eventViewModel, title: eventViewModel.title)
        let navigationVC = UINavigationController(rootViewController: vc)
        present(navigationVC, animated: true)
    }
}

//MARK: - Set constraints
private extension CreateTracker {
    private func addUIElements() {
        view.addSubview(createWontButton)
        view.addSubview(irregularEvent)
        navigationItem.title = "Создание трекера"
        view.backgroundColor = .YPWhiteDay
    }
    
    private func setConstraint() {
        //Create Wont Buttun
        createWontButton.translatesAutoresizingMaskIntoConstraints = false
        createWontButton.setTitle("Привычка", for: .normal)
        createWontButton.titleLabel?.font = UIFont.sfProMedium(size: 16)
        createWontButton.backgroundColor = .YPBlackDay
        createWontButton.tintColor = .YPWhiteDay
        createWontButton.layer.cornerRadius = 16

        //Create Wont Irregular event
        irregularEvent.translatesAutoresizingMaskIntoConstraints = false
        irregularEvent.setTitle("Нерегулярные событие", for: .normal)
        irregularEvent.titleLabel?.font = UIFont.sfProMedium(size: 16)
        irregularEvent.backgroundColor = .YPBlackDay
        irregularEvent.tintColor = .YPWhiteDay
        irregularEvent.layer.cornerRadius = 16
        
        NSLayoutConstraint.activate([
            //
            createWontButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            createWontButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            createWontButton.heightAnchor.constraint(equalToConstant: 60),
            createWontButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            //
            irregularEvent.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            irregularEvent.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            irregularEvent.heightAnchor.constraint(equalToConstant: 60),
            irregularEvent.topAnchor.constraint(equalTo: createWontButton.bottomAnchor, constant: 16)
        ])
    }
}
