//
//  GameController.swift
//  miniGameSangramento
//
//  Created by Juliana Prado on 10/11/20.
//

import Foundation
import SwiftUI

class GameController: ObservableObject{
    static var shared = GameController()
    @Published var barProgress: Double = 0.0
    @Published var presentBar = true
    @Published var presentPopup = false
}
