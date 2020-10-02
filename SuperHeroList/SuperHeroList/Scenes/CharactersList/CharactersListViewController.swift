//
//  CharactersListViewController.swift
//  SuperHeroList
//
//  Created by Tiago Pereira on 01/10/2020.
//  Copyright © 2020 Tiago Pereira. All rights reserved.
//

import UIKit
import RxSwift
import UIScrollView_InfiniteScroll

class CharactersListViewController: UIViewController, UIScrollViewDelegate, UITableViewDelegate {
    
    weak var coordinator: CharactersListCoordinator?
    
    var viewModel: CharactersListViewModel?
    var activityIndicator: MarvelActivityIndicator?
    
    let obs = BehaviorSubject<Int>.init(value: 1)
    let disposeBag = DisposeBag()
    
    @IBOutlet var charactersTableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.activityIndicator = MarvelActivityIndicator(container: self.view)
        
        CharacterTableViewCell.registerInTableView(tableView: self.charactersTableView)
        
        self.charactersTableView.addInfiniteScroll { _ in
            self.viewModel?.fetchMore()
        }
        
        self.charactersTableView.rx.itemSelected.subscribe(onNext: { indexPath in
            guard let cell = self.charactersTableView.cellForRow(at: indexPath) as? CharacterTableViewCell,
                let character = cell.character else {
                return
            }
            
            self.coordinator?.navigateToDetailedCharacter(character: character)
        }).disposed(by: self.disposeBag)
        
        transform()
    }
}

// View model input and output section
extension CharactersListViewController {
    func transform() {
        guard let viewModel = self.viewModel else { return }
        
        let output = viewModel.transform(
            input: CharactersListViewModel.Input(
                search: self.searchBar.rx.text.asDriver()
            )
        )
        
        output.characters.bind(to: self.charactersTableView.rx.items){(tv, row, item) -> UITableViewCell in
            guard let cell = tv.dequeueReusableCell(withIdentifier: CharacterTableViewCell.className()) as? CharacterTableViewCell else {
                let cell = UITableViewCell(style: .default, reuseIdentifier: "default")
                cell.textLabel?.text = item.name
                
                return cell
            }
            
            
            cell.character = item
            
            return cell
        }.disposed(by: disposeBag)
        
        output.fetchingMore.subscribe(onNext: { fetching in
            if !fetching {
                DispatchQueue.main.async {
                    self.charactersTableView.finishInfiniteScroll(completion: nil)
                }
            }
        }).disposed(by: self.disposeBag)
        
        self.activityIndicator?.registerLoading(loading: output.loading)
        
        self.viewModel?.fetchMore()
    }
}
