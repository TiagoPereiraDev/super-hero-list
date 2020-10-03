//
//  MarvelActivityIndicator.swift
//  SuperHeroList
//
//  Created by Tiago Pereira on 02/10/2020.
//  Copyright © 2020 Tiago Pereira. All rights reserved.
//

import UIKit
import RxSwift

class MarvelActivityIndicator {
        
    private let disposeBag = DisposeBag()
    private weak var container: UIView?
    private let activityIndicator: UIActivityIndicatorView
    
    init(container: UIView) {
        self.container = container
        self.activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        self.activityIndicator.color = Colors.red
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func registerLoading(loading: Observable<Bool>) {
        loading.subscribe(onNext: { loading in
            DispatchQueue.main.async {
                if loading {
                    self.addActivityIndicator()
                } else {
                    self.removeActivityIndicator()
                }
            }
        }).disposed(by: self.disposeBag)
    }
    
    func addActivityIndicator() {
        if let container = self.container {
            self.activityIndicator.startAnimating()
            container.addSubview(self.activityIndicator)
         
            NSLayoutConstraint.activate([
                activityIndicator.centerYAnchor.constraint(equalTo: container.centerYAnchor),
                activityIndicator.centerXAnchor.constraint(equalTo: container.centerXAnchor)
            ])
        }
    }
    
    func removeActivityIndicator() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.removeFromSuperview()
    }
}
