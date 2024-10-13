//
//  AddingViewController.swift
//  taskwithUIView
//
//  Created by Анатолий Коробских on 06.10.2024.
//


import UIKit
private enum Constants {
    static let defaultPickerViewCase = PatternsModel.PatternsCategory.Поведенческие
    static let numberOfComponentsforPickerCategories = 1
    static let defaultTextForNameTextField = "Введите название паттерна"
    static let addNameLabel = "Название паттерна"
    static let defaultTextForDescriptionTextView = "Введите описание паттерна"
    static let descriptionLabel = "Описание паттерна"
    static let addButtonLabel = "Добавить"
    static let defaultImage = UIImage(named: "abstract-factory")
}

protocol AddingDisplayLogic: UIViewController {
    var presenter: AddingPresentationProtocol? {get set}
}

class AddingViewController: UIViewController, AddingDisplayLogic  {
    
    //MARK: - MVP Properties
    
    var presenter:  AddingPresentationProtocol?
    
    //MARK: - UI properties
    let imagePicker = UIImagePickerController()
    
    private let groupPicker = UIPickerView()
    private let addNameLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let patternNameTextField = UITextField()
    private let descriptionTextView = UITextView()
    private let addButton = UIButton()
    private let patternImagePicker = UIButton()
    private var pickedPatternImage = UIImage()
    var closure: ((PatternsModel)->())?
    
    var model = PatternsModel(patternImage: UIImage(resource: .abstractFactory), patternName: "", patternDescription: "", category: .Поведенческие, isFavorite: false, numberOfViews: .zero)
    
    // MARK: - Init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        let assembly = HomeAssembly()
        assembly.configurateSecondVC(self)
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.mediaTypes = ["public.image"]
        groupPicker.delegate = self
        groupPicker.dataSource = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        descriptionTextView.resignFirstResponder()
        patternNameTextField.resignFirstResponder()
    }
    
    //MARK: - View lifecycle
    
    override func viewDidLoad(){
        super.viewDidLoad()
        addViews()
        makeConstraints()
        setupViews()
        setupAction()
        view.backgroundColor = .systemBackground
    }
    
}

private extension AddingViewController {
    
    //MARK: - addViews
    
    func addViews() {
        view.addSubview(groupPicker)
        view.addSubview(patternNameTextField)
        view.addSubview(addNameLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(descriptionTextView)
        view.addSubview(addButton)
        view.addSubview(patternImagePicker)
    }
    
    //MARK: - makeConstraints
    
    func makeConstraints() {
        groupPicker.translatesAutoresizingMaskIntoConstraints = false
        patternNameTextField.translatesAutoresizingMaskIntoConstraints = false
        addNameLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        patternImagePicker.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            groupPicker.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            groupPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            addNameLabel.topAnchor.constraint(equalTo: groupPicker.bottomAnchor, constant: -30),
            addNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            patternNameTextField.topAnchor.constraint(equalTo: addNameLabel.bottomAnchor,constant: 10),
            patternNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
//            patternNameTextField.heightAnchor.constraint(equalToConstant: 40),
            patternNameTextField.widthAnchor.constraint(equalToConstant: 350),
            
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: patternNameTextField.bottomAnchor, constant: 25),
            
            descriptionTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionTextView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 150),
            descriptionTextView.widthAnchor.constraint(equalToConstant: 350),
            
            patternImagePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            patternImagePicker.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 40),
            patternImagePicker.heightAnchor.constraint(equalToConstant: 60),
            patternImagePicker.widthAnchor.constraint(equalToConstant: 60),
            
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.topAnchor.constraint(equalTo: patternImagePicker.bottomAnchor, constant: 40),
            addButton.widthAnchor.constraint(equalToConstant: 150),
            addButton.heightAnchor.constraint(equalToConstant: 60)
            ])
    }
    
    //MARK: - setupViews
    
    func setupViews() {
        
        addNameLabel.text = Constants.addNameLabel
        addNameLabel.textAlignment = .center
        addNameLabel.font = .systemFont(ofSize: 22)
        
        patternNameTextField.placeholder = Constants.defaultTextForNameTextField
        patternNameTextField.font = UIFont.systemFont(ofSize: 15)
        patternNameTextField.borderStyle = UITextField.BorderStyle.roundedRect
        patternNameTextField.keyboardType = UIKeyboardType.default
        patternNameTextField.returnKeyType = UIReturnKeyType.done
        patternNameTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        patternNameTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        patternNameTextField.delegate = self
        
        descriptionLabel.text = Constants.descriptionLabel
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = .systemFont(ofSize: 22)
     
        descriptionTextView.text = Constants.defaultTextForDescriptionTextView
        descriptionTextView.keyboardDismissMode = .onDrag
        descriptionTextView.textColor = .placeholderText
        descriptionTextView.font = UIFont.systemFont(ofSize: 15)
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.cornerRadius = 9
        descriptionTextView.layer.borderColor = UIColor.systemGray5.cgColor
        descriptionTextView.keyboardType = UIKeyboardType.default
        descriptionTextView.returnKeyType = UIReturnKeyType.default
        descriptionTextView.textContainer.maximumNumberOfLines = 20
        descriptionTextView.delegate = self
        
        patternImagePicker.setImage( UIImage(named: "insertImage"), for: .normal)
        patternImagePicker.layer.cornerRadius = 10
        patternImagePicker.layer.shadowColor = UIColor.gray.cgColor
        patternImagePicker.layer.shadowOpacity = 0.5
        patternImagePicker.layer.shadowOffset = CGSize(width: 1, height: 1)
        patternImagePicker.layer.shadowRadius = 5
        
        addButton.setTitle(Constants.addButtonLabel, for: .normal)
        addButton.setTitleColor(.black, for: .normal)
        addButton.titleLabel?.font = .systemFont(ofSize: 20)
        addButton.backgroundColor = .white
        addButton.layer.cornerRadius = 10
        addButton.layer.shadowColor = UIColor.gray.cgColor
        addButton.layer.shadowOpacity = 0.5
        addButton.layer.shadowOffset = CGSize(width: 1, height: 1)
        addButton.layer.shadowRadius = 5
    }
    
    //MARK: - setupAction
    
    func setupAction() {
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        patternImagePicker.addTarget(self, action: #selector(imagePickerPressed), for: .touchUpInside)
    }
    
    // MARK: - Add Button
    
    @objc func addButtonPressed() {
        model.patternName = patternNameTextField.text ?? ""
        model.patternDescription = descriptionTextView.text ?? ""
        model.patternImage = patternImagePicker.imageView?.image ??  UIImage()
        

        presenter?.addButtonPressed()
        closure?(model)
    }
    
    // MARK: - Add photot picker
    
    @objc func imagePickerPressed() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.present(self.imagePicker,animated: true,completion: nil)
        }
    }
}

    // MARK: - IPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate

extension AddingViewController:  UIPickerViewDataSource,UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        Constants.numberOfComponentsforPickerCategories
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         PatternsModel.PatternsCategory.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
         PatternsModel.PatternsCategory.allCases.first(where: { $0.sectionNumber == row })?.description ?? ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let gategory = PatternsModel.PatternsCategory.allCases.first(where: { $0.sectionNumber == row })
        switch gategory {
        case .Поведенческие:
            model.category = gategory ?? Constants.defaultPickerViewCase
            print(model.category)
        case .Структурные:
            model.category = gategory ?? Constants.defaultPickerViewCase
            print(model.category)
        case .Порождающие:
            model.category = gategory ?? Constants.defaultPickerViewCase
            print(model.category)
        case .none:
            print(Errors.ChangingPickerCaseForAddingModel)
        }
    }
}
// MARK: - UITextFieldDelegate

extension AddingViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension AddingViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (textView.text  == Constants.defaultTextForDescriptionTextView && textView.textColor == .placeholderText){
            textView.text = ""
            textView.textColor = .black
        }
        textView.becomeFirstResponder()
    }
}

// MARK: - UIImagePickerControllerDelegate
extension AddingViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if info[.mediaType] as? String == "public.image" {
            handleImage(info: info)
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
    }
    // MARK: - Images
    
    func handleImage(info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            self.pickedPatternImage = image
            
            patternImagePicker.setImage( image, for: .normal)
        }
    }
}
