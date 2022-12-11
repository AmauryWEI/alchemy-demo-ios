//
//  NftListViewModel.swift
//  alchemy-demo-ios
//
//  Created by Amaury WEI on 05.12.22.
//

import SwiftUI

/// ViewModel to store a list of NFTs
class NftListViewModel: ObservableObject {
    
    /// Custom Errors thrown by `fetchNfts()`
    enum FetchNftsError: Error {
        case invalidUrl
        case requestFailed
    }
    
    /// Replace with your own ALCHEMY_API_KEY
    private let ALCHEMY_API_KEY = "your_key_here"
    private let HTTP_STATUS_CODE_OK: Int = 200
    
    /// Storage of the list of NFTs
    @Published private var model = NftList()
    
    /// Stored list of NFTs
    var nfts: [String] {
        return model.nfts
    }
    
    // MARK: - Intent(s)
    
    /// Fetch the NFTs from an ETH wallet using the Alchemy API
    /// - Parameter ethWalletAddress: ETH wallet address to fetch the NFTs from
    /// - Throws: Errors of type `FetchNftsError`or `DecodingError`
    func fetchNfts(ethWalletAddress: String) async throws {
        // Create the proper URL using the private Alchemy API key and the specified ETH address
        guard let nftsRequestUrl = URL(string: "https://eth-goerli.g.alchemy.com/v2/\(ALCHEMY_API_KEY)/getNFTs?owner=\(ethWalletAddress)") else { throw FetchNftsError.invalidUrl }
        
        // Perform the HTTPS request
        print("Performing HTTPS GET request: ", nftsRequestUrl.absoluteString)
        let nftsRequest = URLRequest(url: nftsRequestUrl)
        let (data, response) = try await URLSession.shared.data(for: nftsRequest)
        guard (response as? HTTPURLResponse)?.statusCode == HTTP_STATUS_CODE_OK else { throw FetchNftsError.requestFailed }
        
        // Decode the NFTs using Alchemy structs
        let decodedNfts = try JSONDecoder().decode(AlchemyNfts.self, from: data)
        print("NFTs retrieved: ", decodedNfts.totalCount)
    }
}
