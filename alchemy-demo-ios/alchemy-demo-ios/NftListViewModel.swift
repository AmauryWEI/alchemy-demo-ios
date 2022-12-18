//
//  NftListViewModel.swift
//  alchemy-demo-ios
//
//  Created by Amaury WEI on 05.12.22.
//

import SwiftUI

/// Custom Errors thrown by `fetchNfts()`
enum FetchNftsError: Error {
    case dummyAlchemyApiKey
    case invalidUrl
    case requestFailed
}

/// ViewModel to store a list of NFTs
class NftListViewModel: ObservableObject {
    /// Replace with your own ALCHEMY_API_KEY
    private let ALCHEMY_API_KEY = "your_key_here"
    private let HTTP_STATUS_CODE_OK: Int = 200
    
    /// Storage of the list of NFTs
    @Published private var model = NftList()
    
    /// Stored list of NFTs
    var nfts: [Nft] {
        return model.nfts
    }
    
    // MARK: - Intent(s)
    
    /// Fetch the NFTs from an ETH wallet using the Alchemy API
    /// - Parameter ethWalletAddress: ETH wallet address to fetch the NFTs from
    /// - Throws: Errors of type `FetchNftsError`or `DecodingError`
    func fetchNfts(ethWalletAddress: String) async throws {
        // Making sure you have updated the `ALCHEMY_API`KEY` with your own
        guard ALCHEMY_API_KEY != "your_key_here" else {
            throw FetchNftsError.dummyAlchemyApiKey
        }
        
        // Create the proper URL using the private Alchemy API key and the specified ETH address
        guard let nftsRequestUrl = URL(string: "https://eth-mainnet.g.alchemy.com/v2/\(ALCHEMY_API_KEY)/getNFTs?owner=\(ethWalletAddress)&excludeFilters[SPAM,AIRDROPS]") else { throw FetchNftsError.invalidUrl }
        
        // Perform the HTTPS request
        print("INFO: Performing HTTPS GET request: ", nftsRequestUrl.absoluteString)
        let nftsRequest = URLRequest(url: nftsRequestUrl)
        let (data, response) = try await URLSession.shared.data(for: nftsRequest)
        guard (response as? HTTPURLResponse)?.statusCode == HTTP_STATUS_CODE_OK else { throw FetchNftsError.requestFailed }
        
        // Decode the NFTs using Alchemy structs
        let decodedNfts = try JSONDecoder().decode(AlchemyNfts.self, from: data)
        print("INFO: NFTs retrieved: ", decodedNfts.totalCount)
        
        // Convert those Alchemy-based NFTs into custom NFT structures
        let filteredAlchemyNfts = filterInvalidNfts(alchemyNfts: decodedNfts)
        let standardizedNfts = standardizeNfts(alchemyNfts: filteredAlchemyNfts)
        print("INFO: Valid NFTs: ", standardizedNfts.count)
        
        // Update the internal model (from the main thread)
        DispatchQueue.main.async {
            self.model.setNfts(standardizedNfts)
        }
    }
    
    /// Filter invalid NFTs obtained from the Alchemy API.
    /// NFTs considered invalid: `error` field is present, invalid image URL
    private func filterInvalidNfts(alchemyNfts: AlchemyNfts) -> AlchemyNfts {
        let filteredNfts = alchemyNfts.ownedNfts.filter { nft in
            // Remove NFTs which have an `error` field
            if let error = nft.error, error != "" {
                return false
            }
            return true
        }
        
        return AlchemyNfts(ownedNfts: filteredNfts, totalCount: filteredNfts.count, blockHash: alchemyNfts.blockHash)
    }
    
    /// Convert Alchemy NFTs to standardize NFTs.
    /// NFTs with an invalid or missing image metadata will be discarded
    /// - Parameter alchemyNfts: Decoded set of NFTs retrieved from the Alchemy API
    /// - Returns: Array of standardized `Nft` struct
    private func standardizeNfts(alchemyNfts: AlchemyNfts) -> [Nft] {
        var nfts = [Nft]()
        for (index, nft) in alchemyNfts.ownedNfts.enumerated() {
            // Filter the NFTs without any metadata or invalid URLs (most likely errors)
            if let image = nft.metadata.image {
                if let imageUrl = URL(string: image) {
                    nfts.append(Nft(id: index, contractAddress: nft.contract.address, tokenId: nft.id.tokenId, image: imageUrl))
                }
            }
        }
        return nfts
    }
}
