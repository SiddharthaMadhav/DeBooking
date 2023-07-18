// Transaction to buy a ticket and receive an NFT
transaction(ticketId: UInt64) {
    prepare(acct: AuthAccount) {
        // Get the Ticketing contract reference
        let ticketingRef = acct.borrow<&Ticketing.Ticketing>(from: /storage/TicketingContract)
            ?? panic("Could not borrow a reference to the Ticketing contract")

        // Call the buyTicket function to purchase the ticket and receive the NFT
        let nft <- ticketingRef.buyTicket(ticketId: ticketId)
        acct.save<@NFT.NFT>(<-nft, to: /storage/MyTickets)

        // Transfer the ticket fee to the host's account
        let ticket = ticketingRef.tickets[ticketId]
        if let hostAccount = getAccount(ticket.host) {
            let hostAddr = hostAccount.address
            let ticketFee = ticket.ticketFee
            let vault = acct.borrow<&FlowToken.Vault>(from: /storage/flowTokenVault)
                ?? panic("Could not borrow a reference to the FlowToken vault")
            vault.transfer(to: hostAddr, amount: ticketFee)
        } else {
            panic("Host account not found")
        }
    }
}
