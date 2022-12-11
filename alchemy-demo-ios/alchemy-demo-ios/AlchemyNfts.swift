//
//  AlchemyNfts.swift
//  alchemy-demo-ios
//
//  Created by Amaury WEI on 11.12.22.
//

import Foundation

/// Returned data when performing a `/getNfts` request on the Alchemy API
struct AlchemyNfts: Codable {
    var ownedNfts: [AlchemyNft]
    var totalCount: Int
    var blockHash: String
}

/// Represents a single owned NFT item.
/// - Warning: More fields exist in the retrieved JSON data, only the relevant ones for this demo have been declared
struct AlchemyNft: Codable {
    var contract: AlchemyContract
    var metadata: AlchemyMetadata
    var error: String?
}

struct AlchemyContract: Codable {
    var address: String
}

struct AlchemyMetadata: Codable {
    var description: String?
    var image: String?
    var name: String?
}
