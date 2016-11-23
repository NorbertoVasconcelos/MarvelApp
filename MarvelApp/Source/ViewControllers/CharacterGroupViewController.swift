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

class CharacterGroupViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnSearch: UIBarButtonItem!
    // MARK: Variables
    var allCharacters: [Character]?
    var characters: [Character]?
    var disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - View Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()

        self.callService()
        self.setupTableView()
    
    }
    
    // MARK: - Table View -
    func setupTableView() {
//        characters.bindTo(tableView.rx.items(cellIdentifier: "CharacterTableViewCell")) { index, model, cell in
//            cell.lblName?.text = model
//            }
//            .addDisposableTo(disposeBag)
    }
    
    // MARK: - Service calls -
    func callService() {
        APIManager
            .shared
            .request(service: MarvelService.getCharacters(),
                     completion: { [weak self] value in
                        let respObject = GetCharactersResponse(JSON: value)
                    })
    }
}
