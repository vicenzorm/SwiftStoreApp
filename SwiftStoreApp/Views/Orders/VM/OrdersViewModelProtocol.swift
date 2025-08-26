import Foundation

@MainActor
protocol OrdersViewModelProtocol {
    var orders: [Product] { get set }
    var isLoading: Bool { get set }
    var textToSearch: String { get set }
    var filteredOrders: [Product] { get }
    
    func loadOrders() async
}
