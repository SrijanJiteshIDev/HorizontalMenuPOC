//
//  SwipeView.swift
//  HorizontalMenuDemo
//
//  Created by Jitesh Acharya on 28/09/21.
//

import SwiftUI
import ComposableArchitecture

struct SwipeView: View {
  let store: Store<SwipeViewState, SwipeViewActions>
  
  var body: some View {
    WithViewStore(self.store) { viewStore in
      ZStack {
        Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        VStack(spacing: 20) {
          Text(viewStore.selectedMenu.menuTitle)
            .foregroundColor(.black)
            .font(Font.system(size: 25, weight: .bold))
          
          switch viewStore.selectedMenu.ctaButton {
          case .withoutButton:
            EmptyView()
          case .withCTAButton(let ctaState):
            if(!ctaState.viewMoreTitle.isEmpty && !ctaState.viewMoreId.isEmpty) {
              Button(action: {
                withAnimation {
                  viewStore.send(.ctaTapped(id: ctaState.viewMoreId))
                }
              }, label: {
                Text("\(ctaState.viewMoreTitle)")
              })
              .padding()
              .background(Color(red: 210/256, green: 45/256, blue: 40/256))
              .foregroundColor(Color.white)
            }
          }
        }
      }
    }
  }
}

struct SwipeView_Previews: PreviewProvider {
  static var previews: some View {
    SwipeView(store: Store(initialState: SwipeViewState(selectedMenu: .init(id: 0, menuTitle: "Hello", ctaButton: .withoutButton)), reducer: swipeReducer, environment: SwipeViewEnvironment()))
  }
}
