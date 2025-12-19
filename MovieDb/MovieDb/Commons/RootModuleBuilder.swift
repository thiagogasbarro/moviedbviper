import UIKit

enum RootModuleBuilder {
    static func build() -> UIViewController {
        let movies = MoviesModuleBuilder.build()
        return SideMenuContainerViewController(content: movies)
    }
}
