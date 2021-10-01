//
//  ContentView.swift
//  HorizontalMenuDemo
//
//  Created by Jitesh Acharya on 29/09/21.
//

import SwiftUI
import ComposableArchitecture

// MARK:- VIEW
struct ContentView: View {  
  let store: Store<ContentState, ContentAction>
  
  var body: some View {
    WithViewStore(self.store) { viewStore in
      VStack(spacing: 0) {
        // Tabs
        HorizontalMenuView(horizontalMenuList: viewStore.state.menuList, selectedTab: viewStore.binding(get: \.currentTab, send: ContentAction.pageChanged))
        
        // Pageview
        PagingView(index: viewStore.binding(get: \.currentTab, send: ContentAction.pageChanged), maxIndex: viewStore.state.menuList.count - 1) {
          
          ForEachStore(
              self.store.scope(state: \.contentListingComponent, action: ContentAction.contentListingActions(id:action:))
          ) { contentChildStore in
              SwitchStore(contentChildStore) {
                  CaseLet(state: /ContentListingComponents.swipeView, action: ContentListingComponentActions.swipeCtaButtonAction) { featuredStore in
                    SwipeView(store: featuredStore)
                  }
                  Default {
                      EmptyView()
                  }
              }
          }
        }
      }
      .foregroundColor(Color(#colorLiteral(red: 0.737254902, green: 0.1294117647, blue: 0.2941176471, alpha: 1)))
    }
  }
}


// MARK:- PREVIEW
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(store: Store(initialState: ContentState(menuList: getMenuList(), contentListingComponent: convertComponentToState(menuList: horizontalMenuList)), reducer: contentReducer, environment: ContentEnvironment()))
  }
}









//MARK:- SAMPLE DATA
struct HorizontalMenu: Equatable, Identifiable {
  var id: Int
  var menuTitle: String
  var ctaButton: CTAButton
}

struct CTAButtonState : Equatable{
    var viewMoreTitle: String
    var viewMoreUrl: String = ""
    var viewMoreId: String
    var viewMoreType: String = ""
    var actionType : CTAButtonActionType = .landing
}

enum CTAButton : Equatable{
    case withCTAButton(CTAButtonState)
    case withoutButton
}

enum CTAButtonActionType : String{
    case article = "article"
    case landing = "landing"
    case video = "video"
    case webview = "webview"
}


let horizontalMenuList: [HorizontalMenu] = [
  .init(id: 0, menuTitle: "Top stories", ctaButton: .withCTAButton(CTAButtonState(viewMoreTitle: "Asia", viewMoreId: "3"))),
  .init(id: 1, menuTitle: "Latest News", ctaButton: .withCTAButton(CTAButtonState(viewMoreTitle: "Random CTA", viewMoreId: "100"))),
  .init(id: 2, menuTitle: "Singapore", ctaButton: .withCTAButton(CTAButtonState(viewMoreTitle: "Lifestyle", viewMoreId: "5"))),
  .init(id: 3, menuTitle: "Asia", ctaButton: .withoutButton),
  .init(id: 4, menuTitle: "Africa", ctaButton: .withCTAButton(CTAButtonState(viewMoreTitle: "Latest News", viewMoreId: "1"))),
  .init(id: 5, menuTitle: "Lifestyle", ctaButton: .withCTAButton(CTAButtonState(viewMoreTitle: "Top Stories", viewMoreId: "0")))
]

func convertComponentToState(menuList: [HorizontalMenu]) -> IdentifiedArrayOf<ContentListingComponents> {
  var arrContentListComponents = IdentifiedArrayOf<ContentListingComponents>()
  for menu in menuList {
    arrContentListComponents.append(ContentListingComponents.swipeView(SwipeViewState(selectedMenu: menu)))
  }
  return arrContentListComponents
}

func getMenuList() -> IdentifiedArrayOf<HorizontalMenu> {
  var menus = IdentifiedArrayOf<HorizontalMenu>()
  for menu in horizontalMenuList {
    menus.append(menu)
  }
  return menus
}

func getSelectedPageIndex(menuList: IdentifiedArrayOf<HorizontalMenu>, ctaId: String) -> Int? {
  return menuList.firstIndex { menuVal in
    menuVal.id == Int(ctaId)
  }
}


