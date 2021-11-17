//
//  ViewController.swift
//  AssignmentOne
//
//  Created by JustMac on 15/11/21.

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var tableView: UITableView!
    
    var bannerArray = [UIImage]()
    var countries: [String] = []
    var filterList: [String] = []
    var sectionElement : [String] = ["First-List","Second-List","Third-List"]
    override func viewDidLoad() {
        
        initSetup()
        bannerArray = [#imageLiteral(resourceName: "gallery (1)"),#imageLiteral(resourceName: "gallery (1)"),#imageLiteral(resourceName: "gallery (1)")]
    }
    
    func  initSetup(){
        for code in NSLocale.isoCountryCodes as [String] {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
            countries.append(name)
        }
        self.tableView.keyboardDismissMode = .onDrag
        filterList = countries
    }
    
}
//MARK:- CollectionView DelegateMethod (Banner SetUp)

extension HomeViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? BannerViewCell
        corrnerradius(value: 2, outlet: (cell?.banner_Image)!)
        cell?.banner_Image.image = bannerArray[indexPath.item]
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageController.currentPage = indexPath.item
        self.tableView.scrollToRow(at: IndexPath(item: 0, section: indexPath.item), at: .top, animated: true)
    }
    
}
//MARK:- TableView Setup (list of Country Name)

extension HomeViewController : UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        pageController.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        pageController.numberOfPages = bannerArray.count
        return bannerArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterList.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionElement[section]
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tcell", for: indexPath) as? HomeTableViewCell
        cell?.countriesName?.text = filterList[indexPath.item]
        
        return cell!
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if velocity.y > 0 {
            //scrolling down
            
            //, options: .curveEaseIn
            UIView.animate(withDuration: 0.5, delay: 0.0) {
                self.collectionView.isHidden = true
                self.pageController.isHidden = true
                self.view.layoutIfNeeded()
            }
        } else {
            //scrolling up
            
            UIView.animate(withDuration: 0.5, delay: 0) {
                self.collectionView.isHidden = false
                self.pageController.isHidden = false
                self.view.layoutIfNeeded()
            }
        }
    }
}
//MARK:- Searchbar Delegate methods

extension HomeViewController : UISearchBarDelegate,UITextFieldDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty == false{
            filterList = countries.filter {
                $0.contains(searchText)
            }
        }else{
            filterList = countries
        }
        tableView.reloadData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//MARK:- Cornners round of all Sides
func corrnerradius(value : Int, outlet : UIView)  {
    outlet.layer.cornerRadius = CGFloat(value)
    outlet.clipsToBounds = true
}
