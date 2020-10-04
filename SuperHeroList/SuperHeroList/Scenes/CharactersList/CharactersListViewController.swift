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

class CharactersListViewController: UIViewController {
    weak var coordinator: CharactersListCoordinator?
    
    var viewModel: CharactersListViewModel?
    
    var activityIndicator: MarvelActivityIndicator?
    var noDataHandler: NoDataHandler?
    
    let disposeBag = DisposeBag()
    
    @IBOutlet var charactersTableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var containerView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Heroes List"
        
        self.activityIndicator = MarvelActivityIndicator(container: self.containerView)
        self.noDataHandler = NoDataHandler(container: self.containerView)
        
        CharacterTableViewCell.registerInTableView(tableView: self.charactersTableView)
        
        self.charactersTableView.delegate = self
        
        self.charactersTableView.addInfiniteScroll { _ in
            self.viewModel?.fetchMore()
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.color = Colors.red
        
        self.charactersTableView.infiniteScrollIndicatorView = activityIndicator
        
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
        
        self.noDataHandler?.regiterDataObserver(obs: output.noData)
        
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

// View model input and output section
extension CharactersListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}
