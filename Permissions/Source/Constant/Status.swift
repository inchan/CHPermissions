//
//  Status.swift
//  Permissioner
//
//  Created by kay on 2020/12/14.
//

import Foundation

enum Status {
        
    case notDetermined  // 권한 요청 전
    case restrted       // 부분 권한??
    case denied         // 권한 거부
    case authorized     // 권한 획득 중
    case error(PermissionError)   //에러 
    
    var index: Int {
        switch self {
        case .notDetermined: return 0
        case .restrted: return 1
        case .denied: return 2
        case .authorized: return 3
        case .error: return 4
        }
    }
    
}

extension Status: Equatable {
    static func == (lhs: Status, rhs: Status) -> Bool {
        return lhs.index == rhs.index
    }
}
