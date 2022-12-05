//
//  NftListViewModel.swift
//  alchemy-demo-ios
//
//  Created by Amaury WEI on 05.12.22.
//

import SwiftUI

/// ViewModel to store a list of NFTs
class NftListViewModel: ObservableObject {
    
    /// Storage of the list of NFTs
    @Published private var model = NftList()
    
    /// Stored list of NFTs
    var nfts: [String] {
        return model.nfts
    }
    
    // MARK: - Intent(s)
    
    /// Fetch the NFTs from an ETH wallet using the Alchemy API
    /// - Parameter ethWalletAddress: ETH wallet address to fetch the NFTs from
    func fetchNfts(ethWalletAddress: String) {
        //! TODO: Fetch the NFTs here using Alchemy API
        print("TODO: Fetch the NFTs from \(ethWalletAddress)")
    }
}
