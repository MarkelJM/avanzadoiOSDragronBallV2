//
//  HeroDetailView.swift
//  avanzadoiOSDragonBallV2
//
//  Created by Markel Juaristi on 7/4/23.
//

/*
import Foundation
import UIKit

class HeroDetailView : UIView {
    
    let photoImageView =  {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let nameLabel = {
        let label = UILabel()
        label.font  = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false /* muy importante siempre a false!!!*/
        return label
    }()
    
    let descriptionLabel = {
       let label = UILabel()
        
        label.textColor = .systemBlue
        label.font  = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView(){
        
        backgroundColor = .white
        addSubview(photoImageView)
       
        
        NSLayoutConstraint.activate([
            
            photoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            photoImageView.heightAnchor.constraint(equalToConstant: 80),
            photoImageView.widthAnchor.constraint(equalToConstant: 80),
            
        
        ])
        
    }
    func setupViews() {
        
        backgroundColor = .white
        
        addSubview(photoImageView)
        addSubview(nameLabel)
        
        addSubview(descriptionLabel)

        NSLayoutConstraint.activate([
            
            
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            photoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            photoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            photoImageView.heightAnchor.constraint(equalToConstant: 250),

            nameLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: photoImageView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: photoImageView.trailingAnchor),

            descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10)
        ])
    }
    
    func configure(_ model: HeroModel) {
        
        /*para alimentar los label etc*/
        self.nameLabel.text = model.name
        self.descriptionLabel.text = model.description
        self.photoImageView.kf.setImage(with: URL(string: model.photo) )
    }

    
}
*/
