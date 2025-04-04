import SwiftUI

struct BookmarkView: View {
    @ObservedObject var bookmarkModel = BookmarkedGigsModel.shared

    var body: some View {
        NavigationView {
            VStack {
//                Text("Bookmarked Gigs")
//                    .font(.title)
//                    .fontWeight(.bold)

                if bookmarkModel.bookmarkedGigs.isEmpty {
                    Text("No bookmarked gigs Yet")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List {
                        ForEach(bookmarkModel.bookmarkedGigs) { gig in
                            VStack(alignment: .leading) {
                                Text(gig.title)
                                    .font(.headline)
                                Text(gig.location)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Bookmarks")
        }
    }
}
