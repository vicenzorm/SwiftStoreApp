import Foundation
import SwiftData

@MainActor
protocol OrdersServiceProtocol {
    func getAllOrders() -> [Order]
    func getOrder(byId: Int) -> Order?
    func createOrder(productsId: [Int])
}
