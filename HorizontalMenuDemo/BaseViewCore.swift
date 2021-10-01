//
//  BaseViewCore.swift
//  HorizontalMenuDemo
//
//  Created by Jitesh Acharya on 30/09/21.
//

import Foundation
import SwiftUI
import ComposableArchitecture

// MARK:- STATE
struct BaseViewState: Equatable {
  var contentState: ContentState?
}

// MARK:- ACTION
enum BaseViewActions {
  case contentActions(ContentAction)
}

// MARK:- ENVIRONMENT
struct BaseViewEnvironment {}

// MARK:- REDUCER
let baseReducer = Reducer<BaseViewState, BaseViewActions, BaseViewEnvironment>.combine(
  contentReducer.optional().pullback(state: \.contentState, action: /BaseViewActions.contentActions, environment: { env in
    ContentEnvironment()
  }),
  .init {
    state, action, environment in
    switch action {
    case .contentActions(_):
      return .none
    }
  }
)
