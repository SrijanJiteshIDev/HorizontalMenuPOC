//
//  ContentCore.swift
//  HorizontalMenuDemo
//
//  Created by Jitesh Acharya on 30/09/21.
//

import Foundation
import SwiftUI
import ComposableArchitecture

// MARK:- STATE
struct ContentState: Equatable {
  var currentTab = 0
  var menuList: IdentifiedArrayOf<HorizontalMenu>
  var contentListingComponent: IdentifiedArrayOf<ContentListingComponents>
}

// State for swipe listing view
enum ContentListingComponents: Equatable, Identifiable {
  case swipeView(SwipeViewState)
  var id: Int {
    switch self {
    case .swipeView(let swipeState):
      return swipeState.selectedMenu.id
    }
  }
}

// MARK:- ACTION

enum ContentAction {
  case pageChanged(currentPage: Int)
  case contentListingActions(id: Int, action: ContentListingComponentActions)
  case tabChanged(currentPage: Int)
}

// Actions for swipe listing view
enum ContentListingComponentActions {
  case swipeCtaButtonAction(SwipeViewActions)
}

// MARK:- ENVIRONMENT

struct ContentEnvironment {}

// MARK:- REDUCER

let contentListingReducer = Reducer<ContentListingComponents, ContentListingComponentActions, ContentEnvironment>.combine(
  swipeReducer.pullback(state: /ContentListingComponents.swipeView, action: /ContentListingComponentActions.swipeCtaButtonAction, environment: { _ in
    SwipeViewEnvironment()
  })
)

let contentReducer = Reducer<ContentState, ContentAction, ContentEnvironment>.combine(
  contentListingReducer.forEach(
    state: \ContentState.contentListingComponent,
    action: /ContentAction.contentListingActions,
    environment: { $0 }
  ),
  Reducer { state, action, environment in
    switch action {
    case .pageChanged(let currentPage):
      // print("MY DEMO CURR PAGE", currentPage)
      state.currentTab = currentPage
    case .contentListingActions(_, let swipeAction):
      switch swipeAction {
      case .swipeCtaButtonAction(.ctaTapped(let menuId)):
        // print("MY DEMO CURR MENU", menuId)
        if let index = getSelectedPageIndex(menuList: state.menuList, ctaId: menuId) {
          state.currentTab = index
        }
      }
    case .tabChanged(let currentTab):
      // print("TAB CHANGED", currentTab)
      state.currentTab = currentTab
    }
    return .none
  }
)
