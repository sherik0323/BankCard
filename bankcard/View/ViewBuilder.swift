//
//  ViewBuilder.swift
//  bankcard
//
//  Created by Sherozbek on 23/11/23.
//

import UIKit

final class ViewBuilder: NSObject {
    
    private let manager = VIewManager.shared
    private var card = UIView()
    private let balance: Float = 9.999
    private let cardNumber: Int = 1234
    private var colorCollection: UICollectionView!
    private var imageCollection: UICollectionView!
    var controller: UIViewController
    var view: UIView
    var cardColor: [String] = ["#16A085FF","#003F32FF"] {
        willSet{
            
            if let colorView = view.viewWithTag(7) {
                colorView.layer.sublayers?.remove(at: 0)
                let gradient = manager.getGradient(colors: newValue)
                colorView.layer.insertSublayer(gradient, at: 0 )
            }
        }
    }
    var cardIcon: UIImage = .icon1 {
        willSet {
            if let imageView = card.viewWithTag(8) as? UIImageView{
                imageView.image = newValue  
            }
        }
    }
    
    init(controller: UIViewController, view: UIView) {
        self.controller = controller
        self.view = controller.view
    }
    
    private lazy var pageTitle: UILabel = {
        let title = UILabel()
        title.textColor = .white 
        title.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        title.numberOfLines = 0
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    func setPageTitle(title: String){
        pageTitle.text = title
        view.addSubview(pageTitle)
        
        NSLayoutConstraint.activate([
            pageTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            pageTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            pageTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
    }
    
    func getCard() {
        card = manager.getCard(colors: cardColor , balance: balance, cardNumber: cardNumber, cardImage: cardIcon)
        
        view.addSubview(card)
        
        NSLayoutConstraint.activate([
            card.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            card.topAnchor.constraint(equalTo: pageTitle.bottomAnchor, constant: 30)
        ])
    }
    
    func getColorSlider() {
        
        let colorTitle = manager.slideTitle(titleText: "Select color")
        
        colorCollection = manager.getCollection(id: RestoreIDs.colors.rawValue, dataSource: self, delegate: self)
        colorCollection.register(ColorCell.self, forCellWithReuseIdentifier: "cell")
        
        view.addSubview(colorTitle)
        view.addSubview(colorCollection)
        
        NSLayoutConstraint.activate([
            colorTitle.topAnchor.constraint(equalTo: card.bottomAnchor, constant: 50),
            colorTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            colorTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            colorCollection.topAnchor.constraint(equalTo: colorTitle.bottomAnchor, constant: 20),
            colorCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            colorCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setIconSlider() {
        let iconSliderTitle = manager.slideTitle(titleText: "Add shapes")
        
        imageCollection = manager.getCollection(id: RestoreIDs.images.rawValue, dataSource: self, delegate: self)
        imageCollection.register(IconCell.self, forCellWithReuseIdentifier: "cell")
        
        view.addSubview(iconSliderTitle)
        view.addSubview(imageCollection)
        
        NSLayoutConstraint.activate([
            iconSliderTitle.topAnchor.constraint(equalTo: colorCollection.bottomAnchor, constant: 40),
            iconSliderTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            iconSliderTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            imageCollection.topAnchor.constraint(equalTo: iconSliderTitle.bottomAnchor, constant: 20),
            imageCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    
    func setDescriptionText(){
        let descrp: UILabel = {
            let text = UILabel()
            text.text = "Don't worry. You can always change the design of your virtual card later. Just enter the settings."
            text.setLineHeight(lineHeight: 10)
            text.textColor = UIColor(hex: "#6F6F6FFF")
            text.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
            text.translatesAutoresizingMaskIntoConstraints = false
            text.numberOfLines = 0 
            return text
        }()
        
        view.addSubview(descrp)
        
        NSLayoutConstraint.activate([
            descrp.topAnchor.constraint(equalTo: imageCollection.bottomAnchor, constant: 40),
            descrp.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            descrp.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

        ])
    }
    
    func addContinueButton(){
        let button = {
            let btn = UIButton(primaryAction: nil)
            btn.setTitle("Continue", for: .normal)
            btn.backgroundColor = .white
            btn.layer.cornerRadius = 20
            btn.setTitleColor(.black, for: .normal)
            btn.heightAnchor.constraint(equalToConstant: 60).isActive = true
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.layer.shadowColor = UIColor.white.cgColor
            btn.layer.shadowRadius = 10
            btn.layer.shadowOpacity = 0.5
            
            return btn
        }()
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),


        ])
    }
    
}

extension ViewBuilder: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        switch collectionView.restorationIdentifier {
        case RestoreIDs.colors.rawValue:
            return manager.colors.count
        case RestoreIDs.images.rawValue:
            return manager.images.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView.restorationIdentifier {
        case RestoreIDs.colors.rawValue:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ColorCell {
                
                let color = manager.colors[indexPath.item]
                cell.setCell(colors: color)
                return cell
            }
        case RestoreIDs.images.rawValue:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
                as? IconCell {
                let icon = manager.images[indexPath.item]
                cell.setIcon(icon: icon)
                return cell
            }
        default:
            return UICollectionViewCell()
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView.restorationIdentifier {
        case RestoreIDs.colors.rawValue:
            let colors = manager.colors[indexPath.item]
            self.cardColor = colors
            
            let cell = collectionView.cellForItem(at: indexPath) as? ColorCell
            cell?.selectItem()
            
        case RestoreIDs.images.rawValue:
            let image = manager.images[indexPath.item]
            self.cardIcon = image
            
            let cell = collectionView.cellForItem(at: indexPath) as? IconCell
            cell?.selectItem()
        default:
            return
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        switch collectionView.restorationIdentifier {
        case RestoreIDs.colors.rawValue:
            let cell = collectionView.cellForItem(at: indexPath) as? ColorCell
            cell?.deselectItem()
        case RestoreIDs.images.rawValue:
            let cell = collectionView.cellForItem(at: indexPath) as? IconCell
            cell?.deselectItem()
        default:
            return
        }
        
        
    }
}

enum RestoreIDs: String {
    case colors, images
}

