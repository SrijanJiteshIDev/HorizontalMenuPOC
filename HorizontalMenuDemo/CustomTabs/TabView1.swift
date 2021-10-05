//
//  TabView1.swift
//  HorizontalMenuDemo
//
//  Created by Jitesh Acharya on 29/09/21.
//

import SwiftUI

struct TabView1: View {
    var title: String
    var body: some View {
        Text(title)
    }
}

struct TabView1_Previews: PreviewProvider {
    static var previews: some View {
        TabView1(title: "")
    }
}
