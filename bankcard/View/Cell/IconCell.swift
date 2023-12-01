//
//  IconCell.swift
//  bankcard
//
//  Created by Sherozbek on 29/11/23.
//

import UIKit

class IconCell: UICollectionViewCell {
    
    private lazy var checkStatus: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "checkmark")
        image.tintColor = .white
        image.translatesAutoresizingMaskIntoConstraints = false
        image.widthAnchor.constraint(equalToConstant: 24).isActive = true
        image.heightAnchor.constraint(equalToConstant: 24).isActive = true
        image.isHidden = true
        return image
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        imageView.layer.opacity = 0.2
        return imageView
    }()
    
    func setIcon(icon: UIImage){
        imageView.image = icon
        self.addSubview(imageView)
        self.backgroundColor = UIColor(hex: "6F6F6F")
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
        self.addSubview(checkStatus)
       
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -10),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 10),
            checkStatus.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            checkStatus.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    func selectItem(){
        checkStatus.isHidden = false
    }
    
    func deselectItem() {
        checkStatus.isHidden = true
    }

    
}
