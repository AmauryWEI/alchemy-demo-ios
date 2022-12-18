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
        VStack(alignment: .leading) {
            contractAddressHeading
            contractAddressFormatted
            
            tokenIdHeading
            tokenIdFormatted
        }
    }
    
    var contractAddressHeading: some View {
        Text("Contract Address (hex)")
            .foregroundColor(.gray)
            .font(.footnote)
    }
    
    var contractAddressFormatted: some View {
        Text(nft.contractAddress.dropFirst(2))
            .font(.footnote)
    }
    
    var tokenIdHeading: some View {
        Text("Token ID (decimal)")
            .foregroundColor(.gray)
            .font(.footnote)
    }
    
    var tokenIdFormatted: some View {
        guard nft.tokenIdAsUInt != nil else {
            return Text("Unknown").font(.footnote)
        }
        return Text(String(nft.tokenIdAsUInt!)).font(.footnote)
    }
}

struct NftView_Previews: PreviewProvider {
    static var previews: some View {
        let exampleContractAddress = "0x8a6f2ee949ce6c98bfe053a5d8057d01e695d808"
        let exampleTokenId = "0x000000000000000000000000000000000000000000013"
        let exampleImageUrl = URL(string: "https://images.unsplash.com/photo-1518717758536-85ae29035b6d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80")
        let exampleNft = Nft(
            id: 0,
            contractAddress: exampleContractAddress,
            tokenId: exampleTokenId,
            image: exampleImageUrl!
        )
        
        NftView(nft: exampleNft)
    }
}
