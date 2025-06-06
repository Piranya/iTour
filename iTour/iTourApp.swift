import SwiftUI
import SwiftData


@main
struct iTourApp: App {
    @StateObject var userStateViewModel = UserStateViewModel()
    
    var body: some Scene {
        WindowGroup {
            ApplicationSwitcher()
                .environmentObject(userStateViewModel)
        }
    }    
}


struct ApplicationSwitcher: View {
    
    @EnvironmentObject var vm: UserStateViewModel
    
    var body: some View {
        
        if (vm.isAuthenticated == true){
            ContentView()
                .modelContainer(for: Cafes.self)
        } else {
            LoginView()
        }
    
        
    }
}
