//
//  AvatarPickerVC.swift
//  Smack
//
//  Created by juger on 6/26/19.
//  Copyright © 2019 juger. All rights reserved.
//

import UIKit

class AvatarPickerVC: UIViewController {

    // Outlets -:
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    
    // Variables -:
    var avatarType : AvatarType = .dark
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    // Actions -:
    @IBAction func segmentControlChanged(_ sender: Any) {
        if segmentControl.selectedSegmentIndex == 0 {
            avatarType = .dark
        }else {
            avatarType = .light
        }
        collectionView.reloadData()
    }
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}

extension AvatarPickerVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AVATAR_CELL, for: indexPath) as? AvatarCell {
            cell.configureCell(index: indexPath.item, type: avatarType)
            return cell
        }
        return AvatarCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var numOfColumns : CGFloat = 3
        if UIScreen.main.bounds.width > 320 { // 320 is the smalest screen width in iphones it is for the se
            numOfColumns = 4
        }
        let spaceBetweenCells : CGFloat = 10
        let padding : CGFloat = 40
        let cellDimension = ((collectionView.bounds.width - padding) - (numOfColumns - 1 ) * spaceBetweenCells) / numOfColumns
        
        return CGSize(width: cellDimension, height: cellDimension)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if avatarType == .dark {
            UserDataService.instance.setAvatarName(avatarName: "dark\(indexPath.item)")
        }else {
            UserDataService.instance.setAvatarName(avatarName: "light\(indexPath.item)")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
}
