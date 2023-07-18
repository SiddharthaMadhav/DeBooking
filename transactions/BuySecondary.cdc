// Transaction to buy an NFT ticket from the secondary marketplace
transaction(ticketId: UInt64, price: UFix64) {
    prepare(acct: AuthAccount) {
        // Get the SecondaryMarketplace contract reference
        let marketplaceRef = acct.borrow<&SecondaryMarketplace.SecondaryMarketplace>(from: /storage/SecondaryMarketplaceContract)
            ?? panic("Could not borrow a reference to the SecondaryMarketplace contract")

        // Call the buyTicketFromMarketplace function to purchase the NFT ticket from the secondary marketplace
        let nft <- marketplaceRef.buyTicketFromMarketplace(ticketId: ticketId, price: price)
        acct.save<@NFT.NFT>(<-nft, to: /storage/MyTickets)
    }
}
