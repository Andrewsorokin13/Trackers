import UIKit

final class TrackersViewController: UIViewController {
    //MARK: - UI elements
    private lazy var notificationView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var infoImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.sfProMedium(size: 12)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var SearchHorizontalStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 14
        return stack
    }()
    
    private let headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLable: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.sfProBold(size: 34)
        title.textColor = .YPBlackDay
        title.text = "Трекеры"
        return title
    }()
    
    private lazy var addTrackerButton: UIButton = {
        let button = UIButton.systemButton(with: UIImage(systemName: "plus")!, target: self, action: #selector(addNewTracker))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .YPBlackDay
        return button
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.preferredDatePickerStyle = .compact
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ru_Ru")
        datePicker.calendar.firstWeekday = 2
        datePicker.clipsToBounds = true
        datePicker.tintColor = UIColor.YPBlue
        datePicker.addTarget(self, action: #selector(filterselectDate), for: .valueChanged)
        return datePicker
    }()
    
    
    private lazy var searchTextField: UISearchTextField = {
        let searchTextField = UISearchTextField()
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.backgroundColor = .YPBackgroundDay
        searchTextField.textColor = .YPBlackDay
        searchTextField.layer.cornerRadius = 16
        searchTextField.delegate = self
        searchTextField.heightAnchor.constraint(equalToConstant: 36).isActive = true
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.YPGray
        ]
        let attributesPlaceholder = NSAttributedString(string: "Поиск", attributes: attributes)
        searchTextField.attributedPlaceholder = attributesPlaceholder
        return searchTextField
    }()
    
    private lazy var cancelsearchTextFieldButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Отмена", for: .normal)
        button.tintColor = .YPBlue
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        button.isHidden = true
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let viewFlowLayout = UICollectionViewFlowLayout()
        viewFlowLayout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        viewFlowLayout.itemSize = CGSize(width: 60, height: 60)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewFlowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    //MARK: Private property
    private let mocManager = MocSaveManager.shared
    private var filteredСategories: [TrackerCategory] = []
    private var category: [TrackerCategory] = []
    private var completedTrackers: [TrackerRecord] = []
    private var currentDate: Date?
    private var trackerMockManagerObserver: NSObjectProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addElement()
        settingsCollectionView()
        setConstraint()
        
        
        trackerMockManagerObserver = NotificationCenter.default.addObserver(forName: MocSaveManager.didChangeNotification,
                                                                            object: nil,
                                                                            queue: .main,
                                                                            using: { [weak self ] _ in
            guard let self = self else { return }
            self.filteredСategories = mocManager.readTrackerCategory()
            self.reloadData()
        })
        isNotification()
    }
    
    @objc
    private func addNewTracker() {
        let vc = CreateTracker()
        let navigationVC = UINavigationController(rootViewController: vc)
        present(navigationVC, animated: true)
    }
    
    @objc
    private func filterselectDate() {
        filterCategpry()
    }
    
    private func isNotification() {
        if category.isEmpty {
            showNotificationView(imageName: "emptyCollection", title: "Что будем отслеживать?")
        }else if filteredСategories.isEmpty  {
            showNotificationView(imageName: "emptyFilterCollection", title: "Ничего не найдено")
        } else  {
            notificationView.isHidden = true
        }
    }
    
    private func showNotificationView(imageName: String, title: String) {
        notificationView.isHidden = false
        infoImageView.image = UIImage(named: imageName)
        infoLabel.text = title
    }
}

//MARK: - Conform UITextFieldDelegate
extension TrackersViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        filterCategpry()
        
        return true
    }
    
    private func filterCategpry() {
        let calendar = Calendar.current
        let selectDay = calendar.component(.weekday, from: datePicker.date)
        let text = searchTextField.text?.lowercased() ?? ""
        
        filteredСategories = category.compactMap { category in
            let tracker = category.tracer.filter { tracker in
                let filterTextField = text.isEmpty || tracker.title.lowercased().contains(text)
                
                let filterDatePicker = tracker.schedule?.contains{
                    $0.weekNumber == selectDay
                } == true
                
                return filterTextField && filterDatePicker
            }
            
            if tracker.isEmpty {
                return nil
            }
            
            return  TrackerCategory(header: category.header,
                                    tracer: tracker )
        }
        collectionView.reloadData()
        isNotification()
    }
    
    private func isTrackerCompleted(id: UUID) -> Bool {
        let calendar = Calendar.current
        return completedTrackers.contains { tracker in
            let date = calendar.isDate(tracker.date, inSameDayAs: datePicker.date)
            let id = tracker.id == id
            return id && date
        }
    }
}

//MARK: - CollectionView setting
extension TrackersViewController {
    func settingsCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TrackersUICollectionCell.self, forCellWithReuseIdentifier: TrackersUICollectionCell.reuseIdentifier)
        collectionView.register(HeaderViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderViewCell.reuseIdentifier)
        collectionView.backgroundColor = .white
        reloadData()
    }
    
    private func reloadData() {
        category = mocManager.readTrackerCategory()
        filterselectDate()
        collectionView.reloadData()
        isNotification()
    }
}

//MARK: - Conform UICollectionViewDelegate & UICollectionViewDataSource
extension TrackersViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredСategories[section].tracer.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrackersUICollectionCell.reuseIdentifier, for: indexPath) as? TrackersUICollectionCell
        else { return UICollectionViewCell() }
        let data = filteredСategories[indexPath.section].tracer
        let tracker = data[indexPath.row]
        let completedDay = completedTrackers.filter{ $0.id == tracker.id}.count
        cell.delegate = self
        cell.cellConfigurate(tracker: tracker, isComplete: isTrackerCompleted(id: tracker.id), indexPath: indexPath,  completedDay: completedDay)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderViewCell.reuseIdentifier, for: indexPath) as? HeaderViewCell
        else {
            return UICollectionReusableView()
        }
        let title = filteredСategories[indexPath.section].header
        header.configurateHeader(header: title) 
        return header
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return filteredСategories.count
    }
}

//MARK: - Conform TrackerCellDelegate
extension TrackersViewController: TrackerCellDelegate {
    func completeTracker(id: UUID, indexPath: IndexPath) {
        let tracker = TrackerRecord(id: id, date: datePicker.date)
        completedTrackers.append(tracker)
        collectionView.reloadItems(at: [indexPath])
    }
    
    func uncopleteTracker(id: UUID, indexPath: IndexPath) {
        completedTrackers.removeAll { tracker in
            let day = Calendar.current.isDate(tracker.date, inSameDayAs: datePicker.date)
            return tracker.id == id && day
        }
        collectionView.reloadItems(at: [indexPath])
    }
}

//MARK: - Conform UICollectionViewDelegateFlowLayout
extension TrackersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2.2
        return CGSize(width: width , height: 180)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width, height: 30)
    }
}


//MARK: - Set UI elements
private extension TrackersViewController {
    private func addElement() {
        //Main View
        view.addSubview(headerView)
        view.addSubview(collectionView)
        view.backgroundColor = .YPWhiteDay
        view.addSubview(notificationView)
        //info View
        notificationView.addSubview(infoImageView)
        notificationView.addSubview(infoLabel)
        //Header View
        headerView.addSubview(titleLable)
        headerView.addSubview(addTrackerButton)
        headerView.addSubview(datePicker)
        headerView.addSubview(SearchHorizontalStackView)
        
        //Search StackView
        SearchHorizontalStackView.addArrangedSubview(searchTextField)
        SearchHorizontalStackView.addArrangedSubview(cancelsearchTextFieldButton)
    }
    
    private func setConstraint(){
        NSLayoutConstraint.activate([
            // Header View
            headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 13),
            headerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15),
            
            //Add Tracker Button
            addTrackerButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 4),
            addTrackerButton.topAnchor.constraint(equalTo: headerView.topAnchor),
            
            //Header Title Lable
            titleLable.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            titleLable.topAnchor.constraint(equalTo: addTrackerButton.bottomAnchor, constant: 8),
            
            //Date Picker
            datePicker.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            datePicker.centerYAnchor.constraint(equalTo: titleLable.centerYAnchor),
            datePicker.heightAnchor.constraint(equalToConstant: 34),
            datePicker.widthAnchor.constraint(equalToConstant: 100),
            
            //Search StackView
            SearchHorizontalStackView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            SearchHorizontalStackView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            SearchHorizontalStackView.heightAnchor.constraint(equalToConstant: 30),
            SearchHorizontalStackView.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 2),
            
            //CollectionView
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            //Info View
            notificationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            notificationView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            notificationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            notificationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            //info ImageView
            infoImageView.heightAnchor.constraint(equalToConstant: 80),
            infoImageView.widthAnchor.constraint(equalToConstant: 80),
            infoImageView.centerYAnchor.constraint(equalTo: notificationView.centerYAnchor),
            infoImageView.centerXAnchor.constraint(equalTo: notificationView.centerXAnchor),
            
            //info Label
            infoLabel.topAnchor.constraint(equalTo: infoImageView.bottomAnchor, constant: 8),
            infoLabel.leadingAnchor.constraint(equalTo: notificationView.leadingAnchor, constant: 16),
            infoLabel.trailingAnchor.constraint(equalTo: notificationView.trailingAnchor, constant: -16),
            infoLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
