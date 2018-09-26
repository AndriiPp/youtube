//
//  ViewController.swift
//  youtube
//
//  Created by Andrii Pyvovarov on 02.04.18.
//  Copyright © 2018 Andrii Pyvovarov. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let cellId = "cellId"
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //mayby correct
//        self.collectionView?.reloadData()
        navigationItem.title = "Home"
//        navigationController?.navigationBar.isTranslucent = false
        
        let tittleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        tittleLabel.text = "Home"
        tittleLabel.textColor = UIColor.white
        navigationItem.titleView  = tittleLabel
        tittleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationController?.navigationBar.isTranslucent = false
        setupCollectionView()
        setupMenuBar()
        setupNavBarButtons()
    }
    func setupCollectionView(){
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        collectionView?.backgroundColor = .white
//        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
//        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.isPagingEnabled = true
    }
    func setupNavBarButtons(){
        let searchImage = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
        let moreImage = UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal)
          let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        let moreButton = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(handleMore))
        
        navigationItem.rightBarButtonItems = [moreButton, searchBarButtonItem]
    }
    @objc func handleSearch(){
        scrollToMenuIndex(menuIndex: 2)
    }
    func scrollToMenuIndex(menuIndex : Int){
        let indexPath = NSIndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath as IndexPath, at: .right, animated: true)
    }
    
    lazy var settingsLauncger : SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.homeController = self
        return launcher
    }()
    @objc func handleMore(){
        //show menu
//settingsLauncger.homeController  = self
         settingsLauncger.showSettings()
      
    }
    func showControllerForSettings(setting : Setting){
        let dummySettingsViewController = UIViewController()
        dummySettingsViewController.navigationItem.title  = setting.name.rawValue
        dummySettingsViewController.view.backgroundColor = UIColor.white
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        navigationController?.pushViewController(dummySettingsViewController, animated: true)
        
    }
    lazy var menuBar : MenuBar = {
       let mb = MenuBar()
        mb.translatesAutoresizingMaskIntoConstraints = false
        mb.homeController = self
        return mb
    }()
    private func setupMenuBar(){
        navigationController?.hidesBarsOnSwipe = true
        let guide = view.safeAreaLayoutGuide
        
        let redView = UIView()
        redView.backgroundColor = UIColor(red: 230/255, green: 32/255, blue: 31/255, alpha: 1)
        view.addSubview(redView)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: redView)
        view.addConstraintWithFormat(format: "V:[v0(50)]", views: redView)
        
         view.addSubview(menuBar)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintWithFormat(format: "V:[v0(50)]", views: menuBar)
        menuBar.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
    }
   override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(scrollView.contentOffset.x)
    menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x/4
    }
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x/view.frame.width
        let indexPath = NSIndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: .right)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}
