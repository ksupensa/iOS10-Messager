//
//  RecentD.swift
//  Messager
//
//  Created by Spencer Forrest on 15/03/2017.
//  Copyright © 2017 Spencer Forrest. All rights reserved.
//

import Foundation

typealias completion = ()->()

protocol RecentD: class {
    func transferName(_ str: String?, completed: completion)
}
