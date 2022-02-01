//
//  SearchViewController.swift
//  MVVMPokedex
//
//  Created by allan.galdino on 19/05/21.
//

import UIKit

class SearchViewController: UIViewController {
    
    let searchView = SearchView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = searchView
    }
}
