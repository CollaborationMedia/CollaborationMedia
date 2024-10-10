//
//  NetworkManager.swift
//  CollaborationMedia
//
//  Created by 유철원 on 10/9/24.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    typealias OnSuccess<T> = ((T) -> Void)
    typealias OnFailure = ((_ error: NetworkError) -> Void)
    
    static let shared = NetworkManager()
    
    private init() {}
    
    static func request<T>(_ object: T.Type,
                           router: APIRouter,
                           success: @escaping OnSuccess<T>,
                           failure: @escaping OnFailure) where T: Decodable {
                
        AF.request(router)
            .validate(statusCode: 200...445)
            .responseDecodable(of: object) { response in
                responseHandler(response, success: success, failure: failure)
            }
        
    }
    
    private static func responseHandler<T: Decodable>(_ response: AFDataResponse<T>, success: @escaping (T) -> Void, failure: @escaping OnFailure) {
        if let error = responseErrorHandler(response) {
            return failure(error)
        }
        switch response.result  {
        case .success(let result):
            success(result)
        case .failure(let AFError):
            let error = convertAFErrorToAPIError(AFError)
            failure(error)
        }
    }
    
    private static func responseErrorHandler<T: Decodable>(_ response: AFDataResponse<T>) -> NetworkError? {
        if let statusCode = response.response?.statusCode, let statusError = convertResponseStatus(statusCode) {
            return statusError
        }
        return nil
    }
    
    private static func convertResponseStatus(_ statusCode: Int) -> NetworkError? {
        return switch statusCode {
        case 200: nil
        case 300 ..< 400: .redirectError
        case 402 ..< 500: .clientError
        case 500 ..< 600: .serverError
        default: .networkError
        }
    }
    
    private static func convertAFErrorToAPIError(_ error: AFError) -> NetworkError {
        return switch error {
        case .createUploadableFailed: .failedRequest
        case .createURLRequestFailed: .clientError
        case .downloadedFileMoveFailed: .invalidData
        case .explicitlyCancelled: .clientError
        case .invalidURL: .clientError
        case .multipartEncodingFailed: .failedRequest
        case .parameterEncodingFailed: .failedRequest
        case .parameterEncoderFailed: .failedRequest
        case .requestAdaptationFailed: .failedRequest
        case .requestRetryFailed: .failedRequest
        case .responseValidationFailed: .invalidResponse
        case .responseSerializationFailed: .invalidData
        case .serverTrustEvaluationFailed: .networkError
        case .sessionDeinitialized: .networkError
        case .sessionInvalidated: .networkError
        case .sessionTaskFailed: .networkError
        case .urlRequestValidationFailed: .clientError
        }
    }

}


