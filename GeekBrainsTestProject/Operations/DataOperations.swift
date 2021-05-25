//
//  LoadDataOperation.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 23.05.2021.
//

import Foundation
import RealmSwift
import Alamofire

class LoadDataOperation: AsyncOperation {
    
    let url: URL
    let method: HTTPMethod
    let params: Parameters
    private(set) var downloadedData: Data?
    private var dataTask: URLSessionDataTask?
    
    init(url: URL, method: HTTPMethod = .get, params: Parameters = [:]) {
        self.url = url
        self.method = method
        self.params = params
    }
    
    override func main() {
        AF.request(url, method: method, parameters: params).responseData { result in
            guard !self.isCancelled else { return }
            self.downloadedData = result.data
            self.state = .finished
        }
    }
}
class ParsingOperation<T: Decodable>: Operation {
    private(set) var data: Data?
    private(set) var parsedData: T?
    
    public override func main() {
        
        if let dependentLoadingOperation = dependencies.compactMap({ $0 as? LoadDataOperation }).first {
            if let data = dependentLoadingOperation.downloadedData {
                self.data = data
                self.parsedData = try? JSONDecoder().decode(T.self, from: data)
            } else {
                print("No data available")
            }
        }
    }
}

class RealmSavingOperation<T: ObjectProvider & Decodable>: Operation {
    
    public override func main() {
        if let dependentLoadingOperation = dependencies.compactMap({ $0 as? ParsingOperation<T> }).first {
            if let parsedData = dependentLoadingOperation.parsedData {
                let realm = try? Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))
                try? realm?.write {
                    realm?.add(parsedData.getRealmObjects(), update: .all)
                }
            } else {
                print("No parsed data available")
            }
        }
    }
}
