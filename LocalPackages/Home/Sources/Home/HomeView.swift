import SwiftUI

public struct HomeView: View {
    @StateObject var viewModel: HomeViewModel = .init()

    public init() {}

    public var body: some View {
        ZStack {
            switch viewModel.contentState {
            case .loading:
                ProgressView()
                    .padding()
            case let .content(repositories):
                List {
                    ForEach(repositories, id: \.cloneUrl) { repository in
                        VStack(alignment: .leading, spacing: 4) {
                            Group {
                                Text(repository.owner?.login ?? "") +
                                Text(" / ") +
                                Text(repository.name ?? "").bold()
                            }
                            if let description = repository.description {
                                Text(description)
                                    .font(.callout)
                            }
                            HStack(alignment: .center, spacing: 2) {
                                Image(systemName: "star")
                                    .font(.subheadline)
                                Text("\(repository.stargazersCount ?? 0)")
                                    .font(.subheadline)
                            }
                            .foregroundColor(.gray)
                        }
                    }
                }
            case let .error(error):
                Text(error)
                    .foregroundColor(.red)
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchRepos()
            }
        }
        .navigationBarTitle("Repositories")
    }
}
