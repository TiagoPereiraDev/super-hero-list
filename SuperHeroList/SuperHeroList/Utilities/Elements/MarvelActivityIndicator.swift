//
//  MarvelActivityIndicator.swift
//  SuperHeroList
//
//  Created by Tiago Pereira on 02/10/2020.
//  Copyright © 2020 Tiago Pereira. All rights reserved.
//

import UIKit
import RxSwift

/// Class that will handle all the activity indicator in the app
/// basically it can register an observer to listen when is loading or not
/// and it will show or not the activity indicator in a container passed by constructor
class MarvelActivityIndicator {
    
    private let disposeBag = DisposeBag()
    private weak var container: UIView?
    private let activityIndicator: UIActivityIndicatorView
    private let didChangeState = PublishSubject<Bool>()
    
    /**
    Class constructor
    
    - Parameter container: view where we want the activity indicator to appear
    */
    init(container: UIView) {
        self.container = container
        self.activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        self.activityIndicator.color = Colors.red
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    }
    
    /**
     Register the loading observer to know when to show / hidde the activity indicator
     
     - Parameter loading: loading observer responsable for the process that's going on
     
     - Returns: Observable to notify when loading changes were aplied indicating if is loading or not
     */
    @discardableResult
    func registerLoading(loading: Observable<Bool>) -> Observable<Bool> {
        loading.subscribe(onNext: { loading in
            DispatchQueue.main.async {
                if loading {
                    self.addActivityIndicator()
                } else {
                    self.removeActivityIndicator()
                }
                self.didChangeState.onNext(loading)
            }
        }).disposed(by: self.disposeBag)
        
        return self.didChangeState
    }
    
    /**
        Method that will insert the activity indicator in the container and start animating,
     it sets all the constraints as well
        */
    private func addActivityIndicator() {
        if let container = self.container {
            self.activityIndicator.startAnimating()
            container.addSubview(self.activityIndicator)
            
            NSLayoutConstraint.activate([
                activityIndicator.centerYAnchor.constraint(equalTo: container.centerYAnchor),
                activityIndicator.centerXAnchor.constraint(equalTo: container.centerXAnchor)
            ])
        }
    }
    
    /**
     Method that will remove activity indicator from the container and stop animating
     */
    private func removeActivityIndicator() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.removeFromSuperview()
    }
    
    /**
     Method to check if activity indicator is animating or not
     
     - Returns: Bool value indicating if activity indicator is animating or not
     */
    public func isActivityIndicatorAnimating() -> Bool {
        return self.activityIndicator.isAnimating
    }
    
    /**
     Method to check if activity indicator is in the container or not
     
     - Returns: Bool value indicating if activity indicator is in the container or not
     */
    public func isActivityInContainer() -> Bool {
        guard let container = self.container else {
            return false
        }
        
        return container.subviews.contains(self.activityIndicator)
    }
}
