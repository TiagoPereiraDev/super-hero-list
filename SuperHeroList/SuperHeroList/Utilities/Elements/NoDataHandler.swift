//
//  NoDataHandler.swift
//  SuperHeroList
//
//  Created by Tiago Pereira on 03/10/2020.
//  Copyright © 2020 Tiago Pereira. All rights reserved.
//

import Foundation
import RxSwift

/// Class to that will handle when there isn't resltus to show
class NoDataHandler {
    private weak var container: UIView?
    
    private let noDataLabel: UILabel
    private let disposeBag = DisposeBag()
    private let stateDidChange = PublishSubject<Bool>()
    
    /**
    Class constructor
    
    - Parameter container: view where we want the no results label to appear
    */
    public init(container: UIView) {
        self.container = container
        self.noDataLabel = UILabel()
        self.noDataLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.noDataLabel.textColor = Colors.black
        self.noDataLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        self.noDataLabel.text = "No results found"
        self.noDataLabel.textAlignment = .center
    }
    
    /**
    Method to update the message that's suppose to be shown
    
    - Parameter message: message to show in the label
    */
    func updateMessage(message: String) {
        self.noDataLabel.text = message
    }
    
    /**
    Method that will start observing if there's data or not and will show label or not based on the result
    
    - Parameter obs: Observer that will notify if no data
     
    - Returns: Observable that will notify that changes were made and if no data state
    */
    @discardableResult
    func regiterDataObserver(obs: Observable<Bool>) -> Observable<Bool> {
        obs.subscribe(onNext: { noData in
            DispatchQueue.main.async {
                noData ? self.show() : self.hidde()
                self.stateDidChange.onNext(noData)
            }
        }).disposed(by: self.disposeBag)
        
        return self.stateDidChange
    }
    
    /**
    Method that will insert the no results label inside of the container, also handles the constraints
    */
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
    
    /**
    Method tha will remove the no results label from the container
    */
    private func hidde() {
        self.noDataLabel.removeFromSuperview()
    }
    
    /**
    Method that will return if the no resuts label is visible or not
     
    - Returns: Bool value indicating if the no results label is visible or not
    */
    public func isNoDataLabelVisible() -> Bool {
        guard let container = container else {
            return false
        }
        
        return container.subviews.contains(self.noDataLabel)
    }
    
    /**
    Method that will return the current message to be shown
     
    - Returns: defined message that will appear as no results message
    */
    public func getCurrentMessage() -> String? {
        return self.noDataLabel.text
    }
}
