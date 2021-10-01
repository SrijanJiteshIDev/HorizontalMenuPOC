//
//  SwipeableCore.swift
//  HorizontalMenuDemo
//
//  Created by Jitesh Acharya on 30/09/21.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct SwipeViewState: Equatable {
  var selectedMenu: HorizontalMenu
}

enum SwipeViewActions {
  case ctaTapped(id: String)
}

struct SwipeViewEnvironment {}

let swipeReducer = Reducer<SwipeViewState, SwipeViewActions,SwipeViewEnvironment> {state, action, environment in
  return .none
}
