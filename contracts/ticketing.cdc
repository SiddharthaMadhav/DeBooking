// Ticketing contract

pub contract Ticketing {

    // Ticket resource structure
    pub resource Ticket {
        pub let id: UInt64
        pub let host: Address
        pub let showDate: String
        pub let showTime: String
        pub let venue: String
        pub let ticketFee: UFix64
        pub let totalTickets: UInt64
        pub var availableTickets: UInt64

        init(id: UInt64, host: Address, showDate: String, showTime: String, venue: String, ticketFee: UFix64, totalTickets: UInt64) {
            self.id = id
            self.host = host
            self.showDate = showDate
            self.showTime = showTime
            self.venue = venue
            self.ticketFee = ticketFee
            self.totalTickets = totalTickets
            self.availableTickets = totalTickets
        }
    }

    // Collection of listed tickets
    pub let tickets: @{UInt64: Ticket}

    // Event for ticket purchase
    pub event PurchaseTicket(id: UInt64, buyer: Address, ticketNumber: UInt64)

    init() {
        self.tickets = {}
    }

    // Function for a host to list a show with tickets
    pub fun createShow(id: UInt64, showDate: String, showTime: String, venue: String, ticketFee: UFix64, totalTickets: UInt64) {
        let host = AuthAccount.private().address
        let ticket <- create Ticket(id: id, host: host, showDate: showDate, showTime: showTime, venue: venue, ticketFee: ticketFee, totalTickets: totalTickets)
        self.tickets[id] = <-ticket
    }

    // Function for users to buy a ticket and receive an NFT
    pub fun buyTicket(ticketId: UInt64): @NFT {
        let ticket = self.tickets[ticketId]
        if ticket == nil {
            panic("Ticket not available")
        }

        if ticket.availableTickets == 0 {
            panic("No more tickets available for this show")
        }

        let buyer = AuthAccount.private().address
        let nft <- NFT(id: ticket.id, showDate: ticket.showDate, showTime: ticket.showTime, venue: ticket.venue)
        emit PurchaseTicket(id: ticketId, buyer: buyer, ticketNumber: nft.id)

        ticket.availableTickets -= 1

        return <-nft
    }
}
