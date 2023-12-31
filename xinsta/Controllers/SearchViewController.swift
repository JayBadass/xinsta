//
//  SearchViewController.swift
//  xinsta
//
//  Created by t2023-m0075 on 2023/08/17.
//

import UIKit


class SearchViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    
    @IBOutlet weak var searchController: UISearchBar!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    // 검색어 배열 선언
    
    var searchResults: [String] = []
    let userNames = users.map {$0.username}
    
    // 이미지 배열 선언
    
    let images = posts.map {$0.thumbnailImage}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //searchController 딜리게이트 선언
        searchController.delegate = self
        searchController.placeholder = "검색"
        //서치바 cancel 텍스트 수정
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "취소"
        
        //tableview 딜리게이트 선언
        myTableView.dataSource = self
        myTableView.delegate = self
        let nibb = UINib(nibName: "ResultCell", bundle: nil)
        myTableView.register(nibb, forCellReuseIdentifier: "ResultCell")
        
        //collectionview 딜리게이트 선언
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        myCollectionView.register(nib, forCellWithReuseIdentifier: "CollectionViewCell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.collectionViewCell.image = images[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let cellItemForRow: CGFloat = 3
        let minimumSpacing: CGFloat = 2
        let width = (collectionViewWidth - (cellItemForRow - 1) * minimumSpacing) / cellItemForRow
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1  // 세로 간격
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1  // 가로 간격
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)  // 여백 설정
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            myCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        myCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    // 컬렉션뷰 셀 클릭 시 해당 세그 실행
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // 셀이 선택되었을 때 수행할 작업을 여기에 구현
        
        // 세그웨이 실행
        self.performSegue(withIdentifier: "YourSegueIdentifier", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "YourSegueIdentifier" {
            // 목적지 뷰 컨트롤러 가져오기
            if let detailPageViewController = segue.destination as? DetailPageViewController {
                // 선택된 셀의 인덱스 가져오기
                if let indexPath = myCollectionView.indexPathsForSelectedItems?.first {
                    // 필요한 데이터 전달하기
                    detailPageViewController.selectedPostIndex = indexPath.row
                }
            }
        }
        if segue.identifier == "SearchSegueIdentifier" {
            if let searchPageViewController = segue.destination as? SearchDetailViewController {
                if let indexPath = myTableView.indexPathForSelectedRow {
                    let selectedText = searchResults[indexPath.row]
                    print(selectedText)
                    searchPageViewController.selectedUserName = selectedText
                }
            }
        }
    }
}
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("검색창이 눌렸습니다.")
        searchBar.showsCancelButton = true
        
        myTableView.isHidden = false
        myCollectionView.isHidden = true
        myTableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchResults = performSearch(with: searchText)
        print(searchText)
        myTableView.reloadData()  // tableView를 새로고침
        myCollectionView.isHidden = true
        myTableView.isHidden = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        
        myTableView.isHidden = true
        myCollectionView.isHidden = false
    }
    
    func performSearch(with searchText: String) -> [String] {
        // 더미 데이터를 검색어로 필터링하여 반환
        return userNames.filter { $0.lowercased().contains(searchText.lowercased()) }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! SearchResultTableViewCell  // ResultCell로 캐스팅
        let username = searchResults[indexPath.row]
        
        // users 배열에서 해당 username에 대한 User 객체 찾기
        if let user = users.first(where: { $0.username == username }) {
            cell.profileUserName?.text = user.username
            cell.profileImageView.image = user.profilePhoto
            cell.profileImageView.circleImage = true
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        // 셀이 선택되었을 때 수행할 작업을 여기에 구현

        // 세그웨이 실행
        self.performSegue(withIdentifier: "SearchSegueIdentifier", sender: self)
    }
}
