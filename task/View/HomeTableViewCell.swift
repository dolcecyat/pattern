//
//  HomeTableViewCell.swift
//  task
//
//  Created by Анатолий Коробских on 10.08.2024.


import UIKit
private enum Constants {
    static let redHeartImage = "redHeart"
    static let greyHeartImage = "greyHeart"
}

class HomeTableViewCell: UITableViewCell {
    
    // MARK: - Prorerties
    
    static var identifier: String {
        return String(describing: self)
    }
    
    private var cellFrame: UIView = {
        let frame = UIView()
        frame.backgroundColor = .white
        frame.layer.cornerRadius = 10
        frame.layer.shadowColor = UIColor.gray.cgColor
        frame.layer.shadowOpacity = 0.5
        frame.layer.shadowOffset = CGSize(width: 1, height: 1)
        frame.layer.shadowRadius = 5
    
        return frame
    }()
    
     let patternImageView: UIImageView = {
        let im = UIImageView()
        im.contentMode = .scaleAspectFit
        im.image = UIImage(named: " ")
        return im
    }()
    
     let likebutton: UIButton = {
        let like = UIButton()
        like.setTitle("", for: .normal)
        like.setImage(UIImage(named: Constants.greyHeartImage), for: .normal)
        like.addTarget(self, action: #selector(heartButtonPressed), for: .touchUpInside)
        return like
    }()
    
     let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15)
        label.text = " "
        return label
    }()
    
     var descriptionLabel: UILabel = {
          let description = UILabel()
          description.textColor = .lightGray
          description.textAlignment = .left
          description.font = .systemFont(ofSize: 9)
          description.text = " "
          description.numberOfLines = 2
          return description
    }()
    
     let viewLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 9)
        label.textColor = .darkGray
        label.text = " "
        return label
    }()
    
    var isFavorite: Bool = false {
        didSet{
            if isFavorite == true {
                likebutton.setImage(UIImage(named: Constants.redHeartImage), for: .normal)
            }else {
                likebutton.setImage(UIImage(named: Constants.greyHeartImage), for: .normal)
            }
        }
    }
    
    var clousure: ((Bool)->())?
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addView()
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: HomeCellModel){
        descriptionLabel.text = model.description
        patternImageView.image = UIImage(named: model.image)
        nameLabel.text = model.name
        viewLabel.text = "Просмотренно раз: \(model.viewNumber)"
        isFavorite = model.isFavorite
    }
    
    func addView(){
        contentView.addSubview(cellFrame)
        
        cellFrame.addSubview(patternImageView)
        cellFrame.addSubview(nameLabel)
        cellFrame.addSubview(viewLabel)
        cellFrame.addSubview(likebutton)
        cellFrame.addSubview(descriptionLabel)
    }
    
    func setupUI() {
        cellFrame.translatesAutoresizingMaskIntoConstraints = false
        patternImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        viewLabel.translatesAutoresizingMaskIntoConstraints = false
        likebutton.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        cellFrame.layer.masksToBounds = false
      
        NSLayoutConstraint.activate([
        cellFrame.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
        cellFrame.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -8),
        cellFrame.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 8),
        cellFrame.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -8),
        
        patternImageView.topAnchor.constraint(equalTo: cellFrame.topAnchor, constant: 14),
        patternImageView.leadingAnchor.constraint(equalTo: cellFrame.leadingAnchor, constant: 4),
        patternImageView.heightAnchor.constraint(equalToConstant: 55),
        patternImageView.widthAnchor.constraint(equalToConstant: 70),
        
        nameLabel.topAnchor.constraint(equalTo: cellFrame.topAnchor, constant: 18),
        nameLabel.leadingAnchor.constraint(equalTo: patternImageView.trailingAnchor , constant: 6),
        
        descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
        descriptionLabel.leadingAnchor.constraint(equalTo: patternImageView.trailingAnchor,constant: 8),
        descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
        descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -39),
        
        viewLabel.topAnchor.constraint(equalTo: patternImageView.bottomAnchor, constant: 8),
        viewLabel.leadingAnchor.constraint(equalTo: cellFrame.leadingAnchor, constant: 12),
        viewLabel.trailingAnchor.constraint(equalTo: cellFrame.trailingAnchor, constant: -100),
        
        likebutton.bottomAnchor.constraint(equalTo: cellFrame.bottomAnchor, constant: -4),
        likebutton.trailingAnchor.constraint(equalTo: cellFrame.trailingAnchor, constant: -6),
        likebutton.heightAnchor.constraint(equalToConstant: 30),
        likebutton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    // MARK: - Handlers
    
    @objc func heartButtonPressed() {
        clousure?(isFavorite)
    }
}
