//
//  NoDataIndicator.swift
//  SuperHeroList
//
//  Created by Tiago Pereira on 03/10/2020.
//  Copyright © 2020 Tiago Pereira. All rights reserved.
//

import Foundation
import RxSwift

class NoDataFound {
    private weak var container: UIView?
    
    private let noDataLabel: UILabel
    private let disposeBag = DisposeBag()
    
    init() {
        self.noDataLabel = UILabel()
        self.noDataLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.noDataLabel.textColor = Colors.black
        self.noDataLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        self.noDataLabel.text = "No results found"
        self.noDataLabel.textAlignment = .center
    }
    
    func updateMessage(message: String) {
        self.noDataLabel.text = message
    }
    
    func setContainer(containerView: UIView?) {
        self.container = containerView
    }
    
    func regiterDataObserver(obs: Observable<Bool>) {
        obs.subscribe(onNext: { noData in
            DispatchQueue.main.async {
                noData ? self.show() : self.hidde()
            }
        }).disposed(by: self.disposeBag)
    }
    
    private func show() {
        guard let container = self.container else { return }
        
        container.addSubview(self.noDataLabel)
        
        NSLayoutConstraint.activate([
            self.noDataLabel.centerYAnchor.constraint(
                equalTo: container.centerYAnchor
            ),
            self.noDataLabel.leadingAnchor.constraint(
                equalTo: container.leadingAnchor, constant: 10
            ),
            self.noDataLabel.trailingAnchor.constraint(
                equalTo: container.trailingAnchor, constant: -10
            )
        ])
    }
    
    private func hidde() {
        self.noDataLabel.removeFromSuperview()
    }
    
}
