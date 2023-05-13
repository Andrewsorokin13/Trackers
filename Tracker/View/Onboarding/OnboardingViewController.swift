import UIKit

final class OnboardingViewController: UIViewController {
    //MARK: -  UI elements
    private lazy var backgroundImageView: UIImageView = {
        UIImageView()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraint()
    }
    
    //MARK: - Set UI elements
    private func setConstraint() {
        view.addSubview(backgroundImageView)
        
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.image = UIImage(named: "Onboarding")
        backgroundImageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
