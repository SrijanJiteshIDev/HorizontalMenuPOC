//
//  UIView+Ext.swift
//  HorizontalMenuDemo
//
//  Created by Jitesh Acharya on 29/09/21.
//

import Foundation
import SwiftUI
import Combine

extension View {
  /// A backwards compatible wrapper for iOS 14 `onChange`
  @ViewBuilder func valueChanged<T: Equatable>(value: T, onChange: @escaping (T) -> Void) -> some View {
    if #available(iOS 14.0, *) {
      self.onChange(of: value, perform: onChange)
    } else {
      self.onReceive(Just(value)) { (value) in
        onChange(value)
      }
    }
  }
}
