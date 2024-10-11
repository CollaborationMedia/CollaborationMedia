//
//  ViewModel.swift
//  CollaborationMedia
//
//  Created by 조규연 on 10/10/24.
//

import Foundation

protocol ViewModel: AnyObject {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
