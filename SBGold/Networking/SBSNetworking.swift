//
//  SBSNetworking.swift
//  SBNetworking
//
//  Created by Anonymos on 03/06/2021.
//

import Foundation

enum HTTPMethod: String {
  case POST
  case GET
  case PUT
  case PATCH
  case DETELE
}

enum ResponseError: Error {
  case responseInvalid
  case error(_ message: String, code: String)
  case generic(Error)
  case timout
}

enum Response<T> {
  case success(T)
  case error(ResponseError)
}

public class SBSNetworking {
  static let shared = SBSNetworking()
  
  private let defaultSession = URLSession(configuration: .default)
  private var dataTask: URLSessionDataTask?
  private var authorizationKey: String = ""
  
  func setAcessToken(_ token: String) {
    authorizationKey = "Bearer \(token)"
  }

  func sendRequest(
    url: String,
    method: HTTPMethod,
    query: [String: Any]? = nil,
    params: [String: Any]? = nil,
    completionHandler: @escaping (Response<Data?>) -> ()) {
    
    guard let urlReq = URL(string: urlRequest(url, query: query)) else { return}
    var req = URLRequest(url: urlReq)
    req.httpMethod = method.rawValue
    req.setValue("application/json", forHTTPHeaderField: "Content-Type")
    req.setValue("application/json", forHTTPHeaderField: "Accept")
    req.addValue(authorizationKey, forHTTPHeaderField: "Authorization")
    
    if let dic = params,
       let jsonData = try? JSONSerialization.data(withJSONObject: dic,
                                                  options: .prettyPrinted) {
      req.httpBody = jsonData
    }
    
    dataTask = defaultSession.dataTask(with: req) { [weak self] data, response, error  in
      defer {
        self?.dataTask?.cancel()
      }
      if let error = error {
        return completionHandler(Response.error(.generic(error)))
      }
      guard let response = response as? HTTPURLResponse else {
        return completionHandler(Response.error(.error("HTTP request failed", code: "")))
      }
      switch response.statusCode {
      case 200...300:
        completionHandler(Response.success(data))
      default:
        completionHandler(Response.error(.error("HTTP request failed",
                                                code: "\(response.statusCode)")))
      }
    }
    
    dataTask?.resume()
  }
}

extension SBSNetworking {
  private func urlRequest(_ url: String, query: [String: Any]?) -> String {
    var urlReq = url
    let components = query?.map({ (key, value) -> String in
      if let array = value as? [Any] {
        return array.map({ "\(key)=\($0)" }).joined(separator: "&")
      }
      return "\(key)=\(value)"
    })
    
    if let qyeryStr = components?.joined(separator: "&")
        .addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    {
      urlReq.append("?\(qyeryStr)")
    }
    
    return urlReq
  }
}

extension Data {
  func to<T: Codable>(_ aClass: T.Type) -> T? {
    let decoder = JSONDecoder()
    do {
      return try decoder.decode(T.self, from: self)
    } catch {
      return nil
    }
  }
}
