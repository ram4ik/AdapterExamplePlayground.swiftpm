import SwiftUI

struct ContentView: View {
    @State private var data = [Int]()
    @State private var keys = [String]()
    
    var body: some View {
        VStack {
            VStack {
                List(data, id: \.self) { value in
                    Text("\(value)")
                        .padding()
                }.onAppear {
                    useAdapter()
                }
            }
            
            VStack {
                List(keys, id: \.self) { key in
                    Text(key)
                        .padding()
                }.onAppear {
                    useAdapterToGetKeys()
                }
            }
        }
    }
    
    func useAdapter() {
        let adapter = AdapterListService(service: ListService())
        let listManager = ListManager(client: adapter)
        data = listManager.manageList()
    }
    
    func useAdapterToGetKeys() {
        let adapter = AdapterListService(service: ListService())
        let listManager = ListManager(client: adapter)
        keys = listManager.manageKeys()
    }
}

protocol ListClient {
    func getList() -> [Int]
    func getKeysList() -> [String]
}

class ListManager {
    private let client: ListClient
    
    init(client: ListClient) {
        self.client = client
    }
    
    func manageList() -> [Int] {
        return client.getList()
    }
    
    func manageKeys() -> [String] {
        return client.getKeysList()
    }
}

class AdapterListService: ListClient {
    let service: ListService
    
    init(service: ListService) {
        self.service = service
    }
    
    func getList() -> [Int] {
        service.getDictionary().values.map { $0 }
    }
    
    func getKeysList() -> [String] {
        service.getDictionary().keys.map { $0 }
    }
}

class ListService {
    func getDictionary() -> [String: Int] {
        return ["001" : 1, "002" : 2, "003" : 3]
    }
}
