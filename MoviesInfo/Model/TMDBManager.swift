
//
//  TMDBNetwork.swift
//  MoviesInfo
//
//  Created by Polina Petrenko on 12/01/2019.
//  Copyright © 2019 Polina Petrenko. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

struct TMDBManager {
   
    // MARK: - API Addresses
    fileprivate enum Address: String {
        case movieList = "search/movie"
        
        private var baseURL: String { return "https://api.themoviedb.org/3/" }
        var url: URL {
            return URL(string: baseURL.appending(rawValue))!
        }
    }
    
    // MARK: - API errors
    enum Errors: Error {
        case requestFailed
    }
   
    static func getMoviesForSearchString(searchText: String) -> Observable<MovieSearchResult> {
        return request(address: .movieList, parameters: [ParameterKeys.query: searchText])
            .map({ jsonObject in
                let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
                let JSONStr = String(data: jsonData, encoding: .utf8)
                let data = JSONStr?.data(using: .utf8)
                let searchResult = try JSONDecoder().decode(MovieSearchResult.self, from: data!)
                return searchResult
            })
    }

    // MARK: - generic request
    static private func request(address: Address, parameters: [String: String] = [:]) -> Observable<[String:Any]> {
        return Observable.create { observer in
            var params = parameters
            // add API key parameter
            params[ParameterKeys.ApiKey] = Constants.ApiKey
            // generate URL
            var comps = URLComponents(string: address.url.absoluteString)!
            comps.queryItems = params.map(URLQueryItem.init)
            let url = try! comps.asURL()
            
            let request = Alamofire.request(url.absoluteString,
                                            method: .get,
                                            parameters: Parameters(),
                                            encoding: URLEncoding.httpBody,
                                            headers: nil) // for now no authorization ["Authorization": "Bearer \(token)"]
            request.responseJSON { response in
                guard response.error == nil,
                    //let data = response.data,
                    let json = response.result.value as? [String:Any]
                    else {
                        observer.onError(Errors.requestFailed)
                        return
                }
                observer.onNext(json)
                observer.onCompleted()
            }

            return Disposables.create {
                request.cancel()
            }
        }
    }

}
