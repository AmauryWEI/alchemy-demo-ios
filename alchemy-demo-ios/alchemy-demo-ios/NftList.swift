//
//  NftList.swift
//  alchemy-demo-ios
//
//  Created by Amaury WEI on 05.12.22.
//

import Foundation

/// Storage for a list of NFTs
struct NftList {
    /// NFTs are stored as an array of Strings
    private(set) var nfts: [String] = [String]()
    
    /// Set the list of NFTs stored inside the list
    /// - Parameter nfts: NFTs to store inside the list
    mutating func setNfts(_ nfts: [String]) {
        self.nfts = nfts
    }
}
