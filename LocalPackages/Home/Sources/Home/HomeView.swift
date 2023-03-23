import SwiftUI
import Profile

public struct HomeView: View {
    @StateObject var viewModel: HomeViewModel = .init()

    @State private var showProfileView = false

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
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    self.showProfileView.toggle()
                } label: {
                    Image(systemName: "person.crop.circle")
                }
            }
        }
        .sheet(isPresented: self.$showProfileView) {
            ProfileViewControllerWrapper()
        }
        .onAppear {
            Task {
                await viewModel.fetchRepos()
            }
        }
        .navigationBarTitle("Repositories")
    }

//    func buildProfileView() -> some View {
//        let controller = ProfileViewController()
//        return UIHostingController(rootView: AnyView(controller.view))
//    }
}

struct ProfileViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some ProfileViewController {
        ProfileViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {

    }
}
