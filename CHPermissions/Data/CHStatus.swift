//
//  Status.swift
//  Permissioner
//
//  Created by kay on 2020/12/14.
//

import Foundation

public enum CHStatus {
        
    case notDetermined  // 권한 요청 전
    case restricted     // 한정된 ..
    case denied         // 권한 거부
    case authorized     // 권한 획득 중
    case error(CHError)   //에러 
    
    public var index: Int {
        switch self {
        case .notDetermined: return 0
        case .restricted: return 1
        case .denied: return 2
        case .authorized: return 3
        case .error: return 4
        }
    }
    
    public var isAuthorized: Bool {
        return self == .authorized
    }
}

extension CHStatus: Equatable {
    public static func == (lhs: CHStatus, rhs: CHStatus) -> Bool {
        return lhs.index == rhs.index
    }
}
