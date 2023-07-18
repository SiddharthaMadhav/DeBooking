// Transaction to list a show with tickets
transaction {
    prepare(acct: AuthAccount) {
        // Get the Ticketing contract reference
        let ticketingRef = acct.borrow<&Ticketing.Ticketing>(from: /storage/TicketingContract)
            ?? panic("Could not borrow a reference to the Ticketing contract")

        // Call the createShow function to list the show with tickets
        ticketingRef.createShow(
            id: 1234,
            showDate: "2023-08-20",
            showTime: "18:00",
            venue: "Movie Theater 1",
            ticketFee: 10.0, // Flow tokens
            totalTickets: 100
        )
    }
}
