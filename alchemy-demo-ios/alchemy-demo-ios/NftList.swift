//
//  NftList.swift
//  alchemy-demo-ios
//
//  Created by Amaury WEI on 05.12.22.
//

import Foundation

/// Standardized struct for a single NFT
struct Nft: Identifiable {
    var id: Int
    /// Smart contract address of the NFT
    var contractAddress: String
    /// Token ID of the NFT in the smart contract
    var tokenId: String
    /// URL to the NFT
    var image: URL
}

/// Storage for a list of NFTs
struct NftList {
    /// NFTs are stored as an array of Strings
    private(set) var nfts: [Nft] = [Nft]()
    
    /// Set the list of NFTs stored inside the list
    /// - Parameter nfts: NFTs to store inside the list
    mutating func setNfts(_ nfts: [Nft]) {
        self.nfts = nfts
    }
}
