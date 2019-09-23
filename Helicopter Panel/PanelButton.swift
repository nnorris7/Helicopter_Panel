//
//  PanelButton.swift
//  Helicopter Panel
//
//  Created by Norman Norris on 9/21/19.
//  Copyright © 2019 Norman Norris. All rights reserved.
//

import Foundation

struct PanelButton: Codable {
    let id: Int
    let name: String
    let warningColour: String
    let linkedButtons: [Int]
    let procedure: String
    
    func printButton() {
        print("\(self.id): \(self.name)")
        print("\(self.warningColour)")
        print("\(self.linkedButtons)")
        print("\(self.procedure)")
    }
}
