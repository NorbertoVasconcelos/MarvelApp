//
//  CharacterDetailViewController.swift
//  MarvelApp
//
//  Created by Norberto Vasconcelos on 07/12/16.
//  Copyright © 2016 Norberto. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class CharacterDetailViewController: UIViewController, UITableViewDelegate {
    
    let defaultString: String = "Unavailable"
    
    @IBOutlet weak var btnClose: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    var character: Character?
    var disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - View Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }
    
    // MARK: - Table View -
    func setupTableView() {
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100.0
        tableView.contentInset = UIEdgeInsetsMake(0.0, 0.0, 20.0, 0.0)
        
        // Set Header
        if let headerView: CharacterDetailHeaderView = CharacterDetailHeaderView.instanceFromNib() as? CharacterDetailHeaderView {
            if let url = URL(string: character?.thumbnail?.pathForType(type: .portraitUncanny) ?? "") {
                headerView.image.kf.setImage(with: url,
                                             placeholder: #imageLiteral(resourceName: "img_not_found"),
                                             options: nil,
                                             progressBlock: nil,
                                             completionHandler: nil)
            }
            tableView.tableHeaderView = headerView
        }
       
        
        // Sets self as tableview delegate
        tableView
            .rx
            .setDelegate(self)
            .addDisposableTo(disposeBag)
        
        tableView.register(UINib(nibName: "TextTableViewCell", bundle: nil), forCellReuseIdentifier: "TextTableViewCell")
        
        if let charName = character?.name, let charDescription = character?.description {
            let details = Observable.just([("Name", charName != "" ? charName : defaultString),
                                           ("Description", charDescription != "" ? charDescription : defaultString)])
            
            details
                .bindTo(tableView
                    .rx
                    .items(cellIdentifier: "TextTableViewCell",
                           cellType: TextTableViewCell.self)) { (row, element, cell) in
                            cell.lblTitle.text = element.0
                            cell.lblText.text = element.1
                }
                .addDisposableTo(disposeBag)
        }
        
    }
    
    @IBAction func btnClosePressed(_ sender: Any) {
        if let nc = navigationController {
            nc.popViewController(animated: true)
        }
    }
    
}
