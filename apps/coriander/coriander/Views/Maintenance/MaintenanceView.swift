//
//  MaintenanceView.swift
//  coriander
//
//  Created by Tomas Korcak on 02.06.2021.
//

import SwiftUI
import SwiftUIX
import ReSwift

struct MaintenanceView: View {
    @Environment(\.managedObjectContext) var moc
    
    @ObservedObject var state: ObservableState<AppState>
    
    @State var isEditing: Bool = false
    @State var searchText: String = ""
    @State var text: String = "Hello World"
    
    var body: some View {
        VStack {
//            SearchBar("Search...", text: $searchText, isEditing: $isEditing)
//                .showsCancelButton(isEditing)
//                .onCancel { print("Canceled!") }

//            Text("Hello, world!")
//                .navigationSearchBar {
//                    SearchBar("Placeholder", text: $text)
//                }
            
//            Text("Hello, world!")
//                .statusItem(id: "foo", image: .system(.exclamationmark)) {
//                    Text("Popover!")
//                        .padding()
//                }
            
//            ActivityIndicator()
//                .animated(true)
//                .style(.large)
            
//            LinkPresentationView(url: URL(string: "https://idnes.cz")!)
//                .frame(height: 192)
            
        }
    }
}

struct MaintenanceView_Previews: PreviewProvider {
    static let previewStore = Store<AppState>(
        reducer: appReducer,
        state: nil
    )
    
    static var previews: some View {
        let state = ObservableState(store: previewStore)
        MaintenanceView(state: state)
    }
}

