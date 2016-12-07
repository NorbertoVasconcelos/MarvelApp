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
    // MARK: Variables
    var allCharacters: [Character] = [] {
        didSet {
            characters = Variable<[Character]>.init(allCharacters)
        }
    }
    var characters: Variable<[Character]> = Variable<[Character]>.init([]) {
        didSet {
            characters
                .asDriver()
                .drive(tableView.rx.items(cellIdentifier: "CharacterTableViewCell", cellType: CharacterTableViewCell.self)) { (_, character, cell) in
                    cell.config(with: character)
                }
                .addDisposableTo(disposeBag)
        }
    }
    var disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - View Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()

        self.callService()
        self.setupTableView()
    
    }
    
    // MARK: - Table View -
    func setupTableView() {
        
        // Sets self as tableview delegate
        tableView
            .rx
            .setDelegate(self)
            .addDisposableTo(disposeBag)
        
        tableView.register(UINib(nibName: "CharacterTableViewCell", bundle: nil), forCellReuseIdentifier: "CharacterTableViewCell")
        
    }
    
    // MARK: - Service calls -
    func callService() {
        APIManager
            .shared
            .request(service: MarvelService.getCharacters(),
                     completion: { [weak self] value in
                        let respObject = GetCharactersResponse(JSON: value)
                        self?.allCharacters = respObject?.data?.results ?? []
            })
    }
}

// TODO: Place this somewhere better
extension UITableView {
    
    func dequeueCell<T: UITableViewCell>(withIdentifier identifier: String, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! T
    }
}
