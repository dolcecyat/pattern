//
//  DetailPatternViewController.swift
//  taskwithUIView
//
//  Created by Анатолий Коробских on 03.10.2024.
//


import UIKit

private enum Constants {
    static let redHeartImage = "redHeart"
    static let greyHeartImage = "greyHeart"
    static let groupString = "Группа:\n"
    static let editBarButtonImageName = "rectangle.and.pencil.and.ellipsis.rtl"
    static let defaultImage = UIImage(named: "abstract-factory")
    static let numberOfComponentsforPickerCategories = 1
    static let endEditingBarButoonImage = "checkmark.circle"
}

protocol DetailPatternDisplayLogic: UIViewController {
    var router: HomeRouterProtocol? {get set}
    var presenter: DetailPresentationProtocol? {get set}
}

class DetailPatternViewController: UIViewController, DetailPatternDisplayLogic  {
    var router: (any HomeRouterProtocol)?
    var presenter: DetailPresentationProtocol? 
    
    
    //MARK: - Data Properties
    var model: PatternsModel = PatternsModel( patternImage: UIImage(resource: .abstractFactory),
                                              patternName: "",
                                              patternDescription: "",
                                              category: PatternsModel.PatternsCategory.Поведенческие,
                                              isFavorite: false,
                                              numberOfViews: 0)
    var closure: ((PatternsModel)->())?
    var editingMode = false {
        didSet {
            self.navigationItem.rightBarButtonItem = editingMode == true ? UIBarButtonItem(image:  UIImage(systemName: Constants.endEditingBarButoonImage)!.withTintColor(UIColor(.black), renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(endEditing)) : UIBarButtonItem(image:  UIImage(systemName: Constants.editBarButtonImageName)!.withTintColor(UIColor(.black), renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(edit))
        }
    }
    
    //MARK: - UI properties
    
    private let patternImage = UIImageView()
    private let favoriteImage = UIImageView()
    private let patternDescriptionTextView = UITextView()
    private let patternNameTextView = UITextView()
    private var patternTypeLabel = UILabel()
    private let groupPicker = UIPickerView()
    
    // MARK: - Init/deinit
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    // MARK: - SetUp
    
    private func setup() {
        let assembly = HomeAssembly()
        assembly.configurateDetailVC(self)
        
        groupPicker.delegate = self
        groupPicker.dataSource = self
        patternDescriptionTextView.delegate = self
        patternNameTextView.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        patternDescriptionTextView.resignFirstResponder()
        patternNameTextView.resignFirstResponder()
    }
    //MARK: - View lifecycle
    
    override func viewDidLoad(){
        super.viewDidLoad()
        setup()
        addViews()
        makeConstraints()
        setupViews()
        keyboardSetUp()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        closure?(model)
    }
}
private extension DetailPatternViewController {

    //MARK: - addViews
    
    func addViews() {
        view.addSubview(patternNameTextView)
        view.addSubview(patternTypeLabel)
        view.addSubview(patternDescriptionTextView)
        view.addSubview(patternImage)
        view.addSubview(favoriteImage)
        view.addSubview(groupPicker)
    }
    
    //MARK: - makeConstraints
    
    func makeConstraints() {
        patternImage.translatesAutoresizingMaskIntoConstraints = false
        patternTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        patternNameTextView.translatesAutoresizingMaskIntoConstraints = false
        favoriteImage.translatesAutoresizingMaskIntoConstraints = false
        patternDescriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        groupPicker.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        patternImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 110),
        patternImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
        patternImage.heightAnchor.constraint(equalToConstant: 200),
        patternImage.widthAnchor.constraint(equalToConstant: 325),
        
        patternNameTextView.topAnchor.constraint(equalTo: patternImage.bottomAnchor, constant: 20),
        patternNameTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
        patternNameTextView.heightAnchor.constraint(equalToConstant: 50),
        patternNameTextView.widthAnchor.constraint(equalToConstant: 320),
        
        
        patternTypeLabel.topAnchor.constraint(equalTo: patternNameTextView.bottomAnchor, constant: 20),
        patternTypeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
        
        patternDescriptionTextView.topAnchor.constraint(equalTo: patternTypeLabel.bottomAnchor, constant: 20),
        patternDescriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
        patternDescriptionTextView.widthAnchor.constraint(equalToConstant: 330),
        patternDescriptionTextView.heightAnchor.constraint(equalToConstant: 250),
        
        favoriteImage.topAnchor.constraint(equalTo: patternImage.bottomAnchor, constant: 35),
        favoriteImage.trailingAnchor.constraint(equalTo: patternNameTextView.leadingAnchor,constant: 0),
        favoriteImage.heightAnchor.constraint(equalToConstant: 18),
        favoriteImage.widthAnchor.constraint(equalToConstant: 18),
        
        groupPicker.topAnchor.constraint(equalTo: patternNameTextView.bottomAnchor, constant: 0),
        groupPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        groupPicker.widthAnchor.constraint(equalToConstant: 300),
        groupPicker.heightAnchor.constraint(equalToConstant: 100)])
    }
    
    //MARK: - setupViews
    
    func setupViews() {
        view.backgroundColor = .systemBackground
        self.navigationItem.rightBarButtonItem = editingMode == true ?
                                                                       UIBarButtonItem(image:  UIImage(systemName: Constants.endEditingBarButoonImage)!.withTintColor(UIColor(.black), renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(edit)) :
                                                                       UIBarButtonItem(image:  UIImage(systemName: Constants.editBarButtonImageName)!.withTintColor(UIColor(.black), renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(edit))
        
        patternImage.image = model.patternImage
        patternImage.contentMode = .scaleAspectFit
        patternImage.backgroundColor = .white
        patternImage.layer.cornerRadius = 10
        patternImage.layer.shadowColor = UIColor.gray.cgColor
        patternImage.layer.shadowOpacity = 0.9
        patternImage.layer.shadowOffset = CGSize(width: 1, height: 1)
        patternImage.layer.shadowRadius = 5

        patternDescriptionTextView.text = presenter?.capitalizingFirstLetter(model.patternDescription)
        patternDescriptionTextView.textColor = .black
        patternDescriptionTextView.font = UIFont.systemFont(ofSize: 20)
        patternDescriptionTextView.layer.borderWidth = 1
        patternDescriptionTextView.layer.cornerRadius = 9
        patternDescriptionTextView.layer.borderColor = UIColor.systemGray5.cgColor
        patternDescriptionTextView.layer.shadowColor = UIColor.gray.cgColor
        patternDescriptionTextView.layer.shadowOpacity = 0.9
        patternDescriptionTextView.layer.shadowOffset = CGSize(width: 1, height: 1)
        patternDescriptionTextView.keyboardType = UIKeyboardType.default
        patternDescriptionTextView.returnKeyType = UIReturnKeyType.default
        patternDescriptionTextView.contentOffset = .zero
        patternDescriptionTextView.isEditable = editingMode
        
        patternNameTextView.textAlignment = .left
        patternNameTextView.font = .systemFont(ofSize: 28)
        patternNameTextView.text = model.patternName
        patternNameTextView.isEditable = editingMode
        patternNameTextView.keyboardType = UIKeyboardType.default
        patternNameTextView.returnKeyType = UIReturnKeyType.default
        patternNameTextView.layer.borderWidth = 1
        patternNameTextView.layer.cornerRadius = 9
        patternNameTextView.layer.borderColor = UIColor.systemGray5.cgColor
        patternNameTextView.layer.shadowColor = UIColor.gray.cgColor
        patternNameTextView.layer.shadowOpacity = 0.9
        patternNameTextView.layer.shadowOffset = CGSize(width: 1, height: 1)
       
        patternTypeLabel.text = Constants.groupString + model.category.description
        patternTypeLabel.font = .systemFont(ofSize: 24)
        patternTypeLabel.textAlignment = .left
        patternTypeLabel.numberOfLines = 2
        patternImage.isHidden = editingMode
        
        groupPicker.isHidden = true
        
        favoriteImage.image = model.isFavorite ? UIImage(named: Constants.redHeartImage) : UIImage()
    }
    
    //MARK: - Editing Button Pressed

    @objc func edit() {
        print("EDITING")
        editingMode.toggle()
        print(editingMode)
        model.category = .Поведенческие
        patternTypeLabel.text = Constants.groupString + PatternsModel.PatternsCategory.Поведенческие.description
        patternDescriptionTextView.isEditable = editingMode
        patternNameTextView.isEditable = editingMode
        patternTypeLabel.isHidden.toggle()
        groupPicker.isHidden.toggle()
    }
    
    @objc func endEditing() {
        print("END EDITING")
        model.patternDescription = patternDescriptionTextView.text
        model.patternName = patternNameTextView.text
        edit()
    }
    // MARK: - Keyboard setup
    
    func keyboardSetUp() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification: )), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification: )), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification: )), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillChange(notification: Notification) {
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]) as? CGRect else { return }
        if   notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification  {
            patternNameTextView.isFirstResponder == true ? (view.frame.origin.y = 0) : (view.frame.origin.y = -keyboardRect.height)
        }else {
            view.frame.origin.y = 0
        }
    }
}
// MARK: - TextViewDelegate

extension DetailPatternViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
    }
}
// MARK: - UIPicker
extension DetailPatternViewController:  UIPickerViewDataSource,UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        Constants.numberOfComponentsforPickerCategories
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        presenter?.numberOfRowsInComponentInPickerView() ?? .zero
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        presenter?.titleForRowInPickerView(row: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let gategory = PatternsModel.PatternsCategory.allCases.first(where: { $0.sectionNumber == row })
        switch gategory {
        case .Поведенческие:
            model.category = gategory ?? model.category
            patternTypeLabel.text = Constants.groupString + (gategory?.description ?? PatternsModel.PatternsCategory.Поведенческие.description)
        case .Структурные:
            model.category = gategory ?? model.category
            patternTypeLabel.text = Constants.groupString + (gategory?.description ?? PatternsModel.PatternsCategory.Поведенческие.description)
        case .Порождающие:
            model.category = gategory ?? model.category
            patternTypeLabel.text = Constants.groupString + (gategory?.description ?? PatternsModel.PatternsCategory.Поведенческие.description)
        case .none:
            print(Errors.ChangingPickerCaseForPatternEditing)
        }
    }
}
