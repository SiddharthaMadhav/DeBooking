// Transaction to list an NFT ticket for sale
transaction(ticketId: UInt64, price: UFix64) {
    prepare(acct: AuthAccount) {
        // Get the SecondaryMarketplace contract reference
        let marketplaceRef = acct.borrow<&SecondaryMarketplace.SecondaryMarketplace>(from: /storage/SecondaryMarketplaceContract)
            ?? panic("Could not borrow a reference to the SecondaryMarketplace contract")

        // Call the listTicketForSale function to list the NFT ticket for sale
        marketplaceRef.listTicketForSale(ticketId: ticketId, price: price)
    }
}
