import Foundation
import Auth0

class UserStateViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var userProfile = Profile.empty


    func login() {
        Auth0
          .webAuth()
          .start { result in
                switch result {
                case .failure(let error):
                    //The user pressed "cancel" or smth unexpected happened
                    print("Failure with: \(error)" )
                case .success(let credentials):
                    self.isAuthenticated = true
                    self.userProfile = Profile.from(credentials.idToken)
                    print("Credentials \(credentials)")
                    print("Id Token: \(credentials.idToken)")
                }//switch
            }
    }

    func logout() {
        Auth0
            .webAuth()
            .clearSession { result in
                switch result {
                case .failure(let error):
                    print("Failure with: \(error)" )
                case .success:
                    self.isAuthenticated = false
                    self.userProfile = Profile.empty
                }//switch
            }
    }
}
