//
//  BaseView.swift
//  HorizontalMenuDemo
//
//  Created by Jitesh Acharya on 29/09/21.
//

import SwiftUI
import ComposableArchitecture

struct BaseView: View {
  @State private var selection = 0
  
  let store: Store<BaseViewState, BaseViewActions>
  
  var body: some View {
    NavigationView {
      TabView(selection: $selection) {
        
        IfLetStore(store.scope(state: \.contentState, action: BaseViewActions.contentActions), then: ContentView.init(store:), else: {})
        
          .tabItem {
            Image(systemName: "house.fill")
            Text("Home")
          }
          .tag(0)
        
        TabView1()
          .tabItem {
            Image(systemName: "bookmark.circle.fill")
            Text("Bookmark")
          }
          .tag(1)
      }
      .navigationBarTitle("HORIZONTAL MENU", displayMode: .inline)
    }
  }
}
/*
struct BaseView_Previews: PreviewProvider {
  static var previews: some View {
    BaseView()
  }
}
*/
