//
//  ContentView.swift
//  FreshFridge
//
//  Created by 41 Go Team on 10/19/22.
//

import SwiftUI
import Firebase
import CryptoKit
import FirebaseAuth
import AuthenticationServices


struct ContentView: View {
    //MARK: - Apple Auth Data
    @State var currentNonce:String?
       //Hashing function using CryptoKit
       func sha256(_ input: String) -> String {
           let inputData = Data(input.utf8)
           let hashedData = SHA256.hash(data: inputData)
           let hashString = hashedData.compactMap {
           return String(format: "%02x", $0)
           }.joined()

           return hashString
       }
    // from https://firebase.google.com/docs/auth/ios/apple
    private func randomNonceString(length: Int = 32) -> String {
      precondition(length > 0)
      let charset: Array<Character> =
          Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
      var result = ""
      var remainingLength = length

      while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
          var random: UInt8 = 0
          let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
          if errorCode != errSecSuccess {
            fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
          }
          return random
        }

        randoms.forEach { random in
          if remainingLength == 0 {
            return
          }

          if random < charset.count {
            result.append(charset[Int(random)])
            remainingLength -= 1
          }
        }
      }
      return result
    }
    
    //MARK: - Variables - Firebase data
    @EnvironmentObject var inventoryItemListViewModel : ItemListViewModel // firebase model
    var inventoryItemViewModel: ItemViewModel? = nil
    @EnvironmentObject var signupVM : SignUpViewModel // google SignUp
    @EnvironmentObject var userAuth : globalAuth
    //MARK: - Variables - Alerts
    enum ActiveForm {
        case first
        case second
    }
    
    @State var showForm = false
    @State private var showingAlert = false
    @State private var info: AlertInfo?
    @State var showingDetail = false
    @State var showProfileView = false
    @State var auth = Auth.auth().currentUser
    @State var deleteAlert = false

    //MARK: - Variables - Search Bar
    @State var searchQuery = "" // Search Bar
    
    //MARK: - Colors
    let lightGrey = Color(red: 0.45, green: 0.57, blue: 0.72)
    let pastelBlue = Color(red: 0.77, green: 0.83, blue: 0.92)
    
    //MARK: - Body
    var body: some View {
        //MARK: - Google Auth
//        VStack {
//            if (Auth.auth().currentUser == nil) {
//                Image("apple")
//                    .resizable()
//                    .scaledToFit()
//                    .aspectRatio(contentMode: .fit)
//                Button {
//                    signupVM.signUpWithGoogle()
//                } label: {
//                    Text("Sign in with google")
//                }
//            } else {
//                mainView
//            }
//        }
        VStack {
            if (userAuth.currUser != nil) {
                mainView
//            if (userAuth.currUser == nil) { // doesnt work for some reason..
//                needToLoginView
            } else {
                needToLoginView
            }
        }
    }
    
    //MARK: - needToLoginView
    var needToLoginView: some View {
        VStack {
            Image("apple")
                .resizable()
                .scaledToFit()
                .aspectRatio(contentMode: .fit)
            SignInWithAppleButton(
                //Request
                onRequest: { request in
                    let nonce = randomNonceString()
                    currentNonce = nonce
                    request.requestedScopes = [.fullName, .email]
                    request.nonce = sha256(nonce)
                },
                //Completion
                onCompletion: { result in
                    switch result {
                    case .success(let authResults):
                        switch authResults.credential {
                        case let appleIDCredential as ASAuthorizationAppleIDCredential:
                            guard let nonce = currentNonce else {
                                fatalError("Invalid state: A login callback was received, but no login request was sent.")
                            }
                            guard let appleIDToken = appleIDCredential.identityToken else {
                                fatalError("Invalid state: A login callback was received, but no login request was sent.")
                            }
                            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                                return
                            }
                            let credential = OAuthProvider.credential(withProviderID: "apple.com",idToken: idTokenString,rawNonce: nonce)
                            Auth.auth().signIn(with: credential) { (authResult, error) in
                                if (error != nil) {
                                    // Error. If error.code == .MissingOrInvalidNonce, make sure
                                    // you're sending the SHA256-hashed nonce as a hex string with
                                    // your request to Apple.
                                    print(error?.localizedDescription as Any)
                                    return
                                }
                                print("signed in")
                                signupVM.state = .signedIn
//                                auth = Auth.auth().currentUser // for logging in
                                DispatchQueue.main.async { // no more crashes
                                    signupVM.userDisplayName = Auth.auth().currentUser?.displayName ?? "Jane Doe"
                                    signupVM.userID = "\(String(describing: Auth.auth().currentUser?.uid))"
                                    userAuth.currUser = Auth.auth().currentUser // for logging out
                                }
                            }
                            print("\(String(describing: Auth.auth().currentUser?.uid))")
                        default:
                            break
                        }
                    default:
                        break
                    }
                }
            ).frame(width: 280, height: 45, alignment: .center)
        }
    }
    
    //MARK: - mainView
    var mainView: some View {
        var display = inventoryItemListViewModel.itemViewModels
        let view = NavigationView {
           VStack {
               NavigationLink(
                   destination: ProfileHost(),
                   isActive: $showProfileView
               ) {
                   EmptyView()
               }.isDetailLink(false)
               if #available(iOS 16.0, *) {
                   List {
                       ForEach(inventoryItemListViewModel.itemViewModels) {
                           result in
                           Button(action: {
                               info=AlertInfo(item: result.item, id: .one, title: result.item.name, message: alertInformation(name: result.item.name, quantity: result.item.quantity, expirationDate: ExpDates[result.item.name] ?? 10))
                           }) {
                               GroceryItemLabel(name: result.item.name, image: "", expirationDate: result.item.exp )
                           }
                           .foregroundColor(lightGrey)
                           .alert(item: $info, content: { info in
                               Alert(title: Text(info.title), message: Text(info.message), primaryButton: .destructive(Text("Edit")) {
                                   self.showingDetail.toggle()
                               }, secondaryButton: .cancel())
                               // make primaryButton : editscreen()
                           })
                       }
                       .onDelete(perform: deleteItem)
                       .listRowSeparator(.hidden)
//                       .alert(isPresented: $deleteAlert) {
//                           Alert(title: Text("Did you waste or used?"), message: Text(), primaryButton: .default(Text("Used")), secondaryButton: .destructive(Text("Waste")) {
//                       })
                   }
                   .alert(isPresented: $deleteAlert) {
                       Alert(title: Text("Did you waste or used?"), message: Text(""), primaryButton: .default(Text("Used")) {
                           // add/remove variable
                           
                       }, secondaryButton: .destructive(Text("Waste")) {// add to wasted variable} {
                       })
                   }
                   .searchable(text: $searchQuery)
                   .onSubmit(of: .search) {
                       if searchQuery.isEmpty {
                       } else {
                           display = display.filter {
                               $0.name
                                   .localizedCaseInsensitiveContains(searchQuery)
                           }
                       }
                   }
                   .onChange(of: searchQuery) { _ in
                       if searchQuery.isEmpty {
                       } else {
                           display = display.filter {
                               $0.name
                                   .localizedCaseInsensitiveContains(searchQuery)
                           }
                       }
                   }
                   .listStyle(.plain)
                   .scrollContentBackground(.hidden)
               } else {
                   // Fallback on earlier versions
               }
           }
           // when add button is pressed
           .sheet(isPresented: $showForm) {
               NewInventoryItemForm(inventoryItemListViewModel: ItemListViewModel())
           }
           .navigationBarTitle("Your Fridge")
           .navigationBarItems(trailing: Button(action: { showForm.toggle() }) {
               Image(systemName: "plus")
                   .font(.title)
           })
           .navigationBarItems(leading:
                                   Button(action: {
               self.showProfileView = true
           }) {
               Image(systemName: "person.crop.circle")
                   .font(.title)
           }
           )
           .toolbar{
               EditButton()
           }
           
       }
       .navigationViewStyle(StackNavigationViewStyle())
        return view
    }
    
    
    //MARK: - Firebase functs
    func deleteItem(at indexes:IndexSet) {
        deleteAlert = true
        inventoryItemListViewModel.remove(at: indexes)
    }
    
//            InventoryItemListView(showForm: false)
//                .onAppear{
//                    UNUserNotificationCenter.current().requestAuthorization(options:[.alert, .badge, .sound]) { success, error in
//                        if success {
//                            print(success)
//                        }
//                        else if let error = error{
//                            print(error.localizedDescription)
//                    }
//                }
//        }
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
