// Secondary Marketplace contract
import Ticketing from 0xTICKETINGADDRESS
import NFT from 0xNFTADDRESS

pub contract SecondaryMarketplace {

    // Collection of listed NFT tickets for sale
    pub let ticketsForSale: @{UInt64: NFT.NFT}

    // Function for users to list their NFT tickets for sale
    pub fun listTicketForSale(ticketId: UInt64, price: UFix64) {
        let nft = NFT.getNFTResource(ticketId: ticketId)
        let seller = AuthAccount.private().address
        if nft == nil {
            panic("NFT ticket not found")
        }
        if nft.owner != seller {
            panic("You don't own this NFT ticket")
        }

        self.ticketsForSale[ticketId] = <-create NFT.NFT(id: nft.id, showDate: nft.showDate, showTime: nft.showTime, venue: nft.venue)
    }

    // Function for users to buy an NFT ticket from the secondary marketplace
    pub fun buyTicketFromMarketplace(ticketId: UInt64, price: UFix64): @NFT.NFT {
        let seller = AuthAccount.private().address
        let nft = self.ticketsForSale[ticketId]
        if nft == nil {
            panic("Ticket not listed for sale")
        }

        let buyer = AuthAccount.private().address
        let tokenVault = <-FungibleToken.createEmptyVault(balance: price)
        let
