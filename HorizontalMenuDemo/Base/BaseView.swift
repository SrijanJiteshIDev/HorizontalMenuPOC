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
            Image(selection == 0 ? TabBarIconsName.homeActive : TabBarIconsName.homeInactive)
            Text("HOME")
          }
          .tag(0)
        
        TabView1(title: "MINUTES")
          .tabItem {
            Image(selection == 1 ? TabBarIconsName.minuteActive : TabBarIconsName.minuteInactive)
            Text("MINUTES")
          }
          .tag(1)
        
        TabView1(title: "LATEST NEWS")
          .tabItem {
            Image(selection == 2 ? TabBarIconsName.latestNewsActive : TabBarIconsName.latestNewsInactive)
            Text("LATEST NEWS")
          }
          .tag(2)
        
        TabView1(title: "MENU")
          .tabItem {
            Image(selection == 3 ? TabBarIconsName.menuActive : TabBarIconsName.menuInactive)
            Text("MENU")
          }
          .tag(3)
      }
      .onAppear{
        UINavigationBar.appearance().barTintColor = .white
        let tabBarItemAppearance = UITabBarItemAppearance()
        tabBarItemAppearance.selected.iconColor = .white
        let tabBarAppearance = UITabBarAppearance()
        tabBarItemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        tabBarItemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 213/256, green: 213/256, blue: 213/256, alpha: 1.0)]
        tabBarAppearance.backgroundColor = UIColor(red: 210/256, green: 45/256, blue: 40/256, alpha: 1.0)
        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
        tabBarAppearance.inlineLayoutAppearance = tabBarItemAppearance
        tabBarAppearance.compactInlineLayoutAppearance = tabBarItemAppearance
        UITabBar.appearance().standardAppearance = tabBarAppearance
      }
      .navigationBarTitle("TODAY", displayMode: .inline)
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

struct TabBarIconsName {
  static let homeActive = "home-active"
  static let homeInactive = "home-inactive"
  static let minuteActive = "minute-active"
  static let minuteInactive = "minute-inactive"
  static let latestNewsActive = "latest-active"
  static let latestNewsInactive = "latest-inactive"
  static let menuActive = "menu-active"
  static let menuInactive = "menu-inactive"
}
