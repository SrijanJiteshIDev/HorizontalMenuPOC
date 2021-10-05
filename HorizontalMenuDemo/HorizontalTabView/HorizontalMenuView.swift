//
//  HorizontalMenuView.swift
//  HorizontalMenuDemo
//
//  Created by Jitesh Acharya on 28/09/21.
//

import SwiftUI
import ScrollViewProxy
import ComposableArchitecture

//MARK:- Composable

struct HorizontalMenuView: View {
  var horizontalMenuList: IdentifiedArrayOf<HorizontalMenu>
  @Binding var selectedTab: Int
  
  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) { proxy in
      HStack(spacing: 0) {
        ForEach(0 ..< horizontalMenuList.count) { row in
          Button(action: {
            withAnimation {
              selectedTab = row
            }
          }, label: {
            HStack {
              // Text
              Text(horizontalMenuList[row].menuTitle)
                .font(Font.system(size: 14, weight: .semibold))
                .foregroundColor(selectedTab == row ? Color.white : Color.black)
            }
            .padding(.horizontal, 15)
            .frame(height: 40)
          })
          .scrollId(row)
          .buttonStyle(PlainButtonStyle())
        }
      }
      .valueChanged(value: selectedTab) { target in
        withAnimation {
          proxy.scrollTo(target)
        }
      }
    }
    .frame(height: 40)
    .onAppear(perform: {
      UIScrollView.appearance().backgroundColor = UIColor.red
    })
  }
}

struct Tabs_Previews: PreviewProvider {
  static var previews: some View {
    HorizontalMenuView(horizontalMenuList: [.init(id: 0, menuTitle: "Tab 1", bgColor: UIColor.red, ctaButton: .withoutButton), .init(id: 1, menuTitle: "Tab 2", bgColor: UIColor.blue, ctaButton: .withoutButton), .init(id: 2, menuTitle: "Tab 3", bgColor: UIColor.green, ctaButton: .withoutButton)], selectedTab: .constant(0))
  }
}
