//
//  HomeTableViewCell.swift
//  task
//
//  Created by Анатолий Коробских on 10.08.2024.
//

import UIKit


class HomeTableViewCell: UITableViewCell {

    // MARK: - Prorerties
    
   static let homeTableViewCell = "HomeTableViewCell"
    
    private var rtxf: UITextField{
        let rtx = UITextField()
        rtx.borderStyle = .roundedRect
        rtx.frame = CGRect(x:1, y:1 ,width: 350, height: 103)
        rtx.layer.shadowOffset = CGSize(width: 0, height: 2)
        rtx.layer.shadowColor = UIColor.black.cgColor
        rtx.layer.shadowOpacity = 0.5
        rtx.layer.shadowRadius = 2.0
        rtx.layer.masksToBounds = false
        rtx.layer.cornerRadius = 10
        rtx.clipsToBounds = false
        return rtx
    }
 
    internal var delegate: MyTableViewCellDelegate?
    var index : IndexPath?
    
    private let myImageView: UIImageView = {
        let im = UIImageView()
        im.contentMode = .scaleAspectFit
        im.image = UIImage(named: "robot")
        return im
    }()

    private let likebutton: UIButton = {
        let butt = UIButton()
        butt.setTitle("", for: .normal)
        butt.setImage(UIImage(named: "greyHeart"), for: .normal)
       
        butt.frame = CGRect(x: 322, y: 76, width: 30, height: 30)
        butt.addTarget(self, action: #selector(heartButtonPressed), for: .touchUpInside)
        return butt
    }()
    
    private let myLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15)
        label.text = "Прототип"
        return label
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
        self.setupUI()

       
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        self.contentView.addSubview(rtxf)
        self.contentView.addSubview(myImageView)
        self.contentView.addSubview(myLabel)
        self.contentView.addSubview(viewLabel)
        self.contentView.addSubview(likebutton)
        
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        viewLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
        myImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 6),
        myImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 1),
        myImageView.heightAnchor.constraint(equalToConstant: 60),
        myImageView.widthAnchor.constraint(equalToConstant: 80),
        
        myLabel.leadingAnchor.constraint(equalTo: myImageView.trailingAnchor , constant: 2),
        myLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 22),
        
        viewLabel.topAnchor.constraint(equalTo: myImageView.bottomAnchor, constant: 22),
        viewLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
        
        ])
    }
    
    // MARK: - Handlers
    
    @objc func heartButtonPressed (){
        if  likebutton.tag == 0{
            likebutton.setImage(UIImage(named:"redHeart"), for: .normal)
            likebutton.tag = 1
           } else  {
               likebutton.setImage(UIImage(named:"greyHeart"), for: .normal)
               likebutton.tag = 0
        }
    }
    
}

