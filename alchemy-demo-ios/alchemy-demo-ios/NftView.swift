//
//  NftView.swift
//  alchemy-demo-ios
//
//  Created by Amaury WEI on 11.12.22.
//

import SwiftUI

/// View to represent an NFT as a single Text line
struct NftView: View {
    /// NFT to represent in the View
    let nft: Nft
    
    var body: some View {
        Text(nft.address.replacingOccurrences(of: "0x", with: ""))
            .font(.footnote)
    }
}

struct NftView_Previews: PreviewProvider {
    static var previews: some View {
        let exampleAddress = "0x8a6f2ee949ce6c98bfe053a5d8057d01e695d808"
        let exampleImageUrl = URL(string: "https://images.unsplash.com/photo-1518717758536-85ae29035b6d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80")
        let exampleNft = Nft(address: exampleAddress, image: exampleImageUrl!)
        
        NftView(nft: exampleNft)
    }
}
