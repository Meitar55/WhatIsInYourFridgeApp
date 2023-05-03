//
//  Extensions.swift
//  WhatIsInMyFridgeApp
//
//  Created by test11 on 10/08/2022.
//

import Foundation
import UIKit
extension UIImageView{
  func loadImage(urlString: String) async {
    let image = await self.getImage(urlString: urlString)
    self.image = image
  }
  private func getImage(urlString: String) async -> UIImage? {
    guard let url = URL(string: urlString) else{
      return nil
    }
    let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: TimeInterval(10))
    let (data, _) = try! await URLSession.shared.data(for: request)
    if let image = UIImage(data: data){
      return image
    }
    return nil
  }
}
