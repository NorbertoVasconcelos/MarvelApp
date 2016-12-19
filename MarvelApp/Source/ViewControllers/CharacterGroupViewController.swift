//
//  CharacterGroupViewController.swift
//  MarvelApp
//
//  Created by Norberto Vasconcelos on 22/11/16.
//  Copyright © 2016 Norberto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CharacterGroupViewController: UIViewController, UITableViewDelegate {

    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnSearch: UIBarButtonItem!
    @IBOutlet weak var searchBar: UISearchBar!
    // MARK: Variables
    var allCharacters: [Character] = [] {
        didSet {
            characters.value = allCharacters
            print("Did set Characters!")
        }
    }
    var characters: Variable<[Character]> = Variable<[Character]>.init([])
    var disposeBag: DisposeBag = DisposeBag()
    var selectedCharacter: Character?
    var isSearching: Variable<Bool> = Variable<Bool>.init(false)
    
    // MARK: - View Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupSearch()
        
        characters
            .asObservable()
            .bindTo(tableView.rx.items(cellIdentifier: "CharacterTableViewCell", cellType: CharacterTableViewCell.self)) { (_, character, cell) in
                cell.config(with: character)
            }
            .addDisposableTo(disposeBag)
    
    }
    
    // MARK: - Table View -
    func setupTableView() {
        
        // Sets self as tableview delegate
        tableView
            .rx
            .setDelegate(self)
            .addDisposableTo(disposeBag)
        
        tableView.register(UINib(nibName: "CharacterTableViewCell", bundle: nil), forCellReuseIdentifier: "CharacterTableViewCell")
        
        // Cell selection
        tableView
            .rx
            .modelSelected(Character.self)
            .subscribe( onNext: {
                [weak self] character in
                self?.selectedCharacter = character
                self?.performSegue(withIdentifier: "CharacterDetail", sender: self)
            })
            .addDisposableTo(disposeBag)
        
        // Lazy loading
        tableView
        .rx
        .contentOffset
            .throttle(3, scheduler: MainScheduler.instance)
            .subscribe(onNext: {
                [weak self] contentOffset in
                let shouldLoadMore = contentOffset.y + (self?.tableView.frame.size.height)! + 80.0 > (self?.tableView.contentSize.height)!
                if shouldLoadMore {
                    self?.callService()
                }
            },
                       onError: {error in print(error.localizedDescription)},
                       onCompleted: {_ in},
                       onDisposed: {_ in})
        .addDisposableTo(disposeBag)
    }
    
    // MARK: - Search Bar -
    func setupSearch() {
        // Toggle search
        btnSearch
            .rx
            .tap
            .map {!self.isSearching.value}
            .bindTo(isSearching)
            .addDisposableTo(disposeBag)
        
        
        isSearching
            .asObservable()
            .bindTo(searchBar.rx.isHidden)
            .addDisposableTo(disposeBag)
        
        
        
        
    }
    
    // MARK: - Service calls -
    func callService() {
        APIManager
            .shared
            .request(service: MarvelService.getCharacters(offset: allCharacters.count),
                     completion: { [weak self] value in
                        let respObject = GetCharactersResponse(JSON: value)
                        if let results = respObject?.data?.results, var newCharacters = self?.allCharacters {
                            
                            for character in results {
                                newCharacters.append(character)
                            }
                            
                            self?.allCharacters = newCharacters
                        }                        
            })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "CharacterDetail" {
            if let vc = segue.destination as? CharacterDetailViewController {
                vc.character = selectedCharacter
            }
        }
    }
}

// TODO: Place this somewhere better
extension UITableView {
    
    func dequeueCell<T: UITableViewCell>(withIdentifier identifier: String, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! T
    }
}
