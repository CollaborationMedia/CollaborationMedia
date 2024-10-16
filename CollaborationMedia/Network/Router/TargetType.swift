//
//  TargetType.swift
//  CollaborationMedia
//
//  Created by 유철원 on 10/9/24.
//

import Foundation
import Alamofire

protocol TargetType: URLRequestConvertible {
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var headers: HTTPHeaders { get }
    var parameters: Encodable? { get }
    var encoder: ParameterEncoder { get }
}

extension TargetType {
    
    func asURLRequest() throws -> URLRequest {
        let url = try (baseURL + path).asURL()
        var request = try URLRequest(url: url, method: method, headers: headers)
        let combinedRequest = try parameters.map { try encoder.encode($0, into: request) } ?? request
        return combinedRequest
    }

}

