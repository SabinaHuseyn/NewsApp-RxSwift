//
//  ObservableType+Extension.swift
//  NewsApp
//
//  Created by Sabina Huseynova on 23.10.21.
//

import Foundation
import RxSwift
extension ObservableType {
    static func createFromResultCallback<E: Error>(_ fn: @escaping (@escaping (Result<Element, E>) -> Void) -> ()) -> Observable<Element> {
        return Observable.create { observer in
            fn { result in
                switch result {
                case .success(let value):
                    observer.onNext(value)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
