//
//  HomeTableViewCell.swift
//  task
//
//  Created by Анатолий Коробских on 10.08.2024.


import UIKit

class HomeTableViewCell: UITableViewCell {
    
    // MARK: - Prorerties
    

    static let homeTableViewCell = "HomeTableViewCell"
    
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
    
     let myImageView: UIImageView = {
        let im = UIImageView()
        im.contentMode = .scaleAspectFit
        im.image = UIImage(named: "strategy")
        return im
    }()
    
     let likebutton: UIButton = {
        let like = UIButton()
        like.setTitle("", for: .normal)
        like.setImage(UIImage(named: "greyHeart"), for: .normal)
        like.addTarget(self, action: #selector(heartButtonPressed), for: .touchUpInside)
        return like
    }()
    
    private let myLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15)
        label.text = "Прототип"
        return label
    }()
    var descriptionLabel: UILabel = {
          let description = UILabel()
          
          description.textColor = .lightGray
          description.textAlignment = .left
          description.font = .systemFont(ofSize: 9)
          description.text = "Прототип — это порождающий паттерн проектирования, который позволяет копировать объекты, не вдаваясь в подробности их реализации."
          description.numberOfLines = 2
          return description
      }()
    
    private let viewLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 9)
        label.textColor = .darkGray
        label.text = "Просмотренно раз: 0"
        return label
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addView()
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addView(){
        
        contentView.addSubview(cellFrame)
        
        cellFrame.addSubview(myImageView)
        cellFrame.addSubview(myLabel)
        cellFrame.addSubview(viewLabel)
        cellFrame.addSubview(likebutton)
        cellFrame.addSubview(descriptionLabel)
    }
    
    func setupUI() {
        
        cellFrame.translatesAutoresizingMaskIntoConstraints = false
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        viewLabel.translatesAutoresizingMaskIntoConstraints = false
        likebutton.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        cellFrame.layer.masksToBounds = false
      
        NSLayoutConstraint.activate([
        cellFrame.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
        cellFrame.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -8),
        cellFrame.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 8),
        cellFrame.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -8),
        
        myImageView.topAnchor.constraint(equalTo: cellFrame.topAnchor, constant: 14),
        myImageView.leadingAnchor.constraint(equalTo: cellFrame.leadingAnchor, constant: 4),
        myImageView.heightAnchor.constraint(equalToConstant: 55),
        myImageView.widthAnchor.constraint(equalToConstant: 70),
        
        myLabel.topAnchor.constraint(equalTo: cellFrame.topAnchor, constant: 18),
        myLabel.leadingAnchor.constraint(equalTo: myImageView.trailingAnchor , constant: 6),
        
        descriptionLabel.topAnchor.constraint(equalTo: myLabel.bottomAnchor, constant: 2),
        descriptionLabel.leadingAnchor.constraint(equalTo: myImageView.trailingAnchor,constant: 8),
        descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
        descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -39),
        
        viewLabel.topAnchor.constraint(equalTo: myImageView.bottomAnchor, constant: 8),
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
        
        if likebutton.tag == 0{
            print("111")
            likebutton.setImage(UIImage(named:"redHeart"), for: .normal)
            likebutton.tag = 1
        } else  {
           likebutton.setImage(UIImage(named:"greyHeart"), for: .normal)
       likebutton.tag = 0
        }
    }
}
