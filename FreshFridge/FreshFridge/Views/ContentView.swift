//
//  ContentView.swift
//  FreshFridge
//
//  Created by 41 Go Team on 10/19/22.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @EnvironmentObject var itemListViewModel : ItemListViewModel
    @EnvironmentObject var signupVM : SignUpViewModel // google SignUp
    @State private var auth = Firebase.Auth.auth()
    var body: some View {
            InventoryItemListView(showForm: false)
                .onAppear{
                    UNUserNotificationCenter.current().requestAuthorization(options:[.alert, .badge, .sound]) { success, error in
                        if success {
                            print(success)
                        }
                        else if let error = error{
                            print(error.localizedDescription)
                    }
                }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let itemListViewModel = ItemListViewModel()
        ContentView()
            .environmentObject(itemListViewModel)
    }
}
