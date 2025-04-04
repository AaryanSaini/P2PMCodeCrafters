import SwiftUI

class BookmarkedGigsModel: ObservableObject {
    static let shared = BookmarkedGigsModel()

    @Published private(set) var bookmarkedGigs: [Gig] = []

    private init() {}

    func toggleBookmark(gig: Gig) {
        if let index = bookmarkedGigs.firstIndex(where: { $0.id == gig.id }) {
            bookmarkedGigs.remove(at: index) // Remove if already bookmarked
        } else {
            bookmarkedGigs.append(gig) // Add if not bookmarked
        }
    }

    func isBookmarked(gig: Gig) -> Bool {
        bookmarkedGigs.contains(where: { $0.id == gig.id })
    }
}
