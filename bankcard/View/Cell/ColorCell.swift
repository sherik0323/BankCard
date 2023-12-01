//
//  ColorCell.swift
//  bankcard
//
//  Created by Sherozbek on 29/11/23.
//

import UIKit

class ColorCell: UICollectionViewCell {
    
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
    
    func setCell(colors: [String]){
        let gradient = VIewManager.shared.getGradient(frame: CGRect(origin: .zero, size: CGSize(width: 62, height: 62)),  colors: colors)
        self.layer.addSublayer(gradient)
        self.clipsToBounds = true
        self.layer.cornerRadius = 12
        self.addSubview(checkStatus)
        
        
        NSLayoutConstraint.activate([
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
