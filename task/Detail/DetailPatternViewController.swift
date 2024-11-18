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
    static let groupString = NSLocalizedString("detail.groupString", comment: "Group")
    static let editBarButtonImageName = "rectangle.and.pencil.and.ellipsis.rtl"
    static let defaultImage = UIImage(named: "abstract-factory")
    static let numberOfComponentsforPickerCategories = 1
    static let endEditingBarButoonImage = "checkmark.circle"
    static let imageForChangingDescriptionSign =  ChangeImage(image: UIImage(systemName:"rectangle.and.pencil.and.ellipsis.rtl")?.withTintColor(UIColor(.black), renderingMode: .alwaysOriginal))
    static let imageForChangingNameSign =  ChangeImage(image: UIImage(systemName:"rectangle.and.pencil.and.ellipsis.rtl")?.withTintColor(UIColor(.black), renderingMode: .alwaysOriginal))
    static let imageForChangingCategorySign = ChangeImage(image: UIImage(systemName: "arrowshape.down")?.withTintColor(UIColor(.black), renderingMode: .alwaysOriginal))
    static let selectPhotoString = NSLocalizedString("detail.selectPhotoString", comment: "Change photo")
    static let emptyPatternModel = PatternsModel(patternImage:Image(withImage: UIImage(resource: .abstractFactory)), patternName: "", patternDescription: "", category: .Поведенческие, isFavorite: false, numberOfViews: 0)
}

protocol DetailPatternDisplayLogic: UIViewController {
    var router: HomeRouterProtocol? {get set}
    var presenter: DetailPresentationProtocol? {get set}
}

class DetailPatternViewController: UIViewController, DetailPatternDisplayLogic {
    var router: (any HomeRouterProtocol)?
    var presenter: DetailPresentationProtocol? 
    
    
    //MARK: - Data Properties
    private var defaultImage: UIImage = UIImage(resource: .abstractFactory)
    var model: PatternsModel?
    
    var closure: ((PatternsModel)->())?
    private var editingMode = false {
        didSet {
            self.navigationItem.rightBarButtonItem = editingMode ?  UIBarButtonItem(image:  UIImage(systemName: Constants.endEditingBarButoonImage)!.withTintColor(UIColor(.black), renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(endEditing)) :
            UIBarButtonItem(image:  UIImage(systemName: Constants.editBarButtonImageName)!.withTintColor(UIColor(.black), renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(edit))
        }
    }
    //MARK: - UI properties
    private let imagePicker = ImagePicker()
    
    private let opentoChangeCategoryImage = Constants.imageForChangingCategorySign
    private let opentoChangeNameImage = Constants.imageForChangingNameSign
    private let opentoChangeDescriptionImage = Constants.imageForChangingDescriptionSign
    private let patternImage = UIButton ()
    private let zoomingPhoto = ScrollViewForZoom()
    private let favoriteImage = UIImageView()
    private let patternDescriptionTextView = UITextView()
    private let patternNameTextView = UITextView()
    private let changeTypeButton = DropDownButton()
    
    // MARK: - Init/deinit
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
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
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        patternDescriptionTextView.resignFirstResponder()
        patternNameTextView.resignFirstResponder()
    }
    
    //MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setUpAction()
        addViews()
        makeConstraints()
        setupViews()
        setUpNavBar()
        keyboardSetUp()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        model?.category = changeTypeButton.currentType
        model?.patternImage = Image(withImage: patternImage.currentImage ?? defaultImage )
        changeTypeButton.removeFromSuperview()
        closure?(model ?? Constants.emptyPatternModel)
    }
}
private extension DetailPatternViewController {
    
    //MARK: - addViews
    
    private func addViews() {
        view.addSubview(zoomingPhoto)
        view.addSubview(patternNameTextView)
        view.addSubview(patternDescriptionTextView)
        view.addSubview(favoriteImage)
        view.addSubview(opentoChangeNameImage)
        view.addSubview(opentoChangeCategoryImage)
        view.addSubview(opentoChangeDescriptionImage)
        view.addSubview(changeTypeButton)
    }
    
    //MARK: - makeConstraints
    
    private func makeConstraints() {
      
        patternImage.translatesAutoresizingMaskIntoConstraints = false
        patternNameTextView.translatesAutoresizingMaskIntoConstraints = false
        favoriteImage.translatesAutoresizingMaskIntoConstraints = false
        patternDescriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        zoomingPhoto.translatesAutoresizingMaskIntoConstraints = false
        opentoChangeNameImage.translatesAutoresizingMaskIntoConstraints = false
        opentoChangeCategoryImage.translatesAutoresizingMaskIntoConstraints = false
        opentoChangeDescriptionImage.translatesAutoresizingMaskIntoConstraints = false
        changeTypeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            zoomingPhoto.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4),
            zoomingPhoto.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            zoomingPhoto.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            zoomingPhoto.heightAnchor.constraint(equalToConstant: 200),
                        
            patternNameTextView.topAnchor.constraint(equalTo: zoomingPhoto.bottomAnchor, constant: 20),
            patternNameTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            patternNameTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            patternNameTextView.heightAnchor.constraint(equalToConstant: 50),
            
            changeTypeButton.topAnchor.constraint(equalTo: patternNameTextView.bottomAnchor, constant: 20),
            changeTypeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            changeTypeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            changeTypeButton.heightAnchor.constraint(equalToConstant: 30),
            
            patternDescriptionTextView.topAnchor.constraint(equalTo: changeTypeButton.bottomAnchor, constant: 30),
            patternDescriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            patternDescriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            patternDescriptionTextView.heightAnchor.constraint(equalToConstant: 250),
            
            opentoChangeDescriptionImage.topAnchor.constraint(equalTo: patternDescriptionTextView.topAnchor,constant: 10),
            opentoChangeDescriptionImage.rightAnchor.constraint(equalTo: patternDescriptionTextView.rightAnchor,constant: -10),
            opentoChangeDescriptionImage.heightAnchor.constraint(equalToConstant: 25),
            
            opentoChangeNameImage.topAnchor.constraint(equalTo: patternNameTextView.topAnchor,constant: 10),
            opentoChangeNameImage.rightAnchor.constraint(equalTo: patternNameTextView.rightAnchor,constant: -10),
            opentoChangeNameImage.heightAnchor.constraint(equalToConstant: 20),
            
            favoriteImage.topAnchor.constraint(equalTo: zoomingPhoto.bottomAnchor, constant: 35),
            favoriteImage.trailingAnchor.constraint(equalTo: patternNameTextView.leadingAnchor,constant: -2),
            favoriteImage.heightAnchor.constraint(equalToConstant: 18),
            favoriteImage.widthAnchor.constraint(equalToConstant: 18),
        ])
    }
    
    // MARK: - SetUp Delegates
    private func setUpDelegates() {
        patternDescriptionTextView.delegate = self
        patternNameTextView.delegate = self
    }
    
    // MARK: - SetUp NavBar
    private func setUpNavBar() {
        self.navigationItem.rightBarButtonItem = editingMode ?
        UIBarButtonItem(image:  UIImage(systemName: Constants.endEditingBarButoonImage)!.withTintColor(UIColor(.black), renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(endEditing)) :
        UIBarButtonItem(image:  UIImage(systemName: Constants.editBarButtonImageName)!.withTintColor(UIColor(.black), renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(edit))
    }
    
    //MARK: - setupViews
    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        patternImage.setImage(model?.patternImage.getImage(), for: .disabled)
        patternImage.setTitle("", for: .disabled)
        patternImage.setTitle(Constants.selectPhotoString, for: .normal)
        patternImage.setImage(nil, for: .normal)
        patternImage.isEnabled = false
        patternImage.contentMode = .scaleAspectFit
        patternImage.setTitleColor(.black, for: .normal)
        patternImage.titleLabel?.font = .systemFont(ofSize: 28)
        patternImage.backgroundColor = .white
        
        zoomingPhoto.setUpButton(patternImage)
        zoomingPhoto.layer.borderColor = UIColor.systemGray5.cgColor
        zoomingPhoto.layer.borderWidth = 1
        zoomingPhoto.layer.cornerRadius = 10
        
        patternDescriptionTextView.text = presenter?.capitalizingFirstLetter(model?.patternDescription ?? Constants.emptyPatternModel.patternDescription)
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
        patternNameTextView.font = .systemFont(ofSize: 24)
        patternNameTextView.text = model?.patternName
        patternNameTextView.isEditable = editingMode
        patternNameTextView.keyboardType = UIKeyboardType.default
        patternNameTextView.returnKeyType = UIReturnKeyType.default
        patternNameTextView.layer.borderWidth = 1
        patternNameTextView.layer.cornerRadius = 9
        patternNameTextView.layer.borderColor = UIColor.systemGray5.cgColor
        patternNameTextView.layer.shadowColor = UIColor.gray.cgColor
        patternNameTextView.layer.shadowOpacity = 0.9
        patternNameTextView.layer.shadowOffset = CGSize(width: 1, height: 1)
        
        changeTypeButton.isUserInteractionEnabled = false
        changeTypeButton.backgroundColor = .white
        changeTypeButton.setTitleColor(.black, for: .normal)
        changeTypeButton.layer.borderWidth = 1
        changeTypeButton.layer.cornerRadius = 9
        changeTypeButton.layer.borderColor = UIColor.systemGray5.cgColor
        changeTypeButton.titleLabel?.font = .systemFont(ofSize: 18)
        changeTypeButton.setTitle(Constants.groupString + (model?.category.description ?? Constants.emptyPatternModel.category.description), for: .normal)
        changeTypeButton.currentType = model?.category ?? Constants.emptyPatternModel.category
        changeTypeButton.showOpenArrowImage(open: editingMode)
        
        opentoChangeNameImage.isHidden = !editingMode
        opentoChangeDescriptionImage.isHidden = !editingMode
        
        favoriteImage.image = model?.isFavorite ?? Constants.emptyPatternModel.isFavorite ? UIImage(named: Constants.redHeartImage) : UIImage()
        }
    
    private func setUpAction() {
        patternImage.addTarget(self, action: #selector(selectPhotoButtonPressed), for: .touchUpInside)
    }
    
    // MARK: - Select Photo
    @objc private func selectPhotoButtonPressed() {
        if editingMode {
            imagePicker.showImagePicker(in: self) { [weak self]
                image in
                self?.patternImage.setImage(image, for: .disabled)
            }
        }
    }
    
    //MARK: - Editing Button Pressed
    
     @objc private func edit() {
        print("EDITING")
        editingMode.toggle()
        patternDescriptionTextView.isEditable = editingMode
        opentoChangeNameImage.isHidden = !editingMode
        opentoChangeDescriptionImage.isHidden = !editingMode
        patternNameTextView.isEditable = editingMode
        changeTypeButton.isUserInteractionEnabled = editingMode
        patternImage.isEnabled.toggle()
        changeTypeButton.showOpenArrowImage(open: editingMode)
        changeTypeButton.currentType = model?.category ?? Constants.emptyPatternModel.category
         defaultImage = model?.patternImage.getImage() ?? Constants.emptyPatternModel.patternImage.getImage()!
    }
    
    @objc private func endEditing() {
        print("END EDITING")
        editingMode.toggle()
        opentoChangeNameImage.isHidden = !editingMode
        opentoChangeDescriptionImage.isHidden = !editingMode
        model?.patternDescription = patternDescriptionTextView.text
        model?.patternName = patternNameTextView.text
        patternDescriptionTextView.isEditable = editingMode
        patternNameTextView.isEditable = editingMode
        changeTypeButton.isUserInteractionEnabled = editingMode
        patternImage.isEnabled.toggle()
        changeTypeButton.showOpenArrowImage(open: editingMode)
        changeTypeButton.setType()
        changeTypeButton.dismissDropDown()
    }
    
    // MARK: - Keyboard setup
    
    private func keyboardSetUp() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification: )), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification: )), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification: )), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillChange(notification: Notification) {
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]) as? CGRect else { return }
        if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification  {
            patternNameTextView.isFirstResponder ? (view.frame.origin.y = 0) : (view.frame.origin.y = -keyboardRect.height)
        } else {
            view.frame.origin.y = 0
        }
    }
}
// MARK: - TextViewDelegate

extension DetailPatternViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
    }
}
