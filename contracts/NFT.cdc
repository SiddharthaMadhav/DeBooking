// NFT contract
pub contract NFT {

    // NFT resource structure
    resource NFT {
        pub let id: UInt64
        pub let showDate: String
        pub let showTime: String
        pub let venue: String

        init(id: UInt64, showDate: String, showTime: String, venue: String) {
            self.id = id
            self.showDate = showDate
            self.showTime = showTime
            self.venue = venue
        }
    }

    init() {}

    // Function to create an NFT
    pub fun createNFT(id: UInt64, showDate: String, showTime: String, venue: String): @NFT {
        return <-create NFT(id: id, showDate: showDate, showTime: showTime, venue: venue)
    }
}
