# Navigator
Navigator is a routing service framework used to remove navigation logic inside a controller thus eliminating tight coupling between  presenting and presented controllers. Below is a list of features:

 - Handles route mapping through registration of generic types
 - Flexible presentation by delegation presentation logic to routing observer
 - Universal link compatible

# Route Mapping

 - Define an array of string identfiers for each location in your application because most often than not, a screen needs to be navigated by more than one screen.
 ```
 struct Route {
    static let dismiss = ["/"]
    static let root = ["/root"]
    static let detail = ["/screenTwo"]
    static let openUrl = ["/openUrl"]
}
 ```

 - Registering an instance of a location - Useful for locations which should only occur once such as root controller of UINavigationController.

```
Navigator.shared
    .map(ids: Route.root, location: ViewController()) { [weak self] (event) in
        event.destination.title = "Master"
        let navigation = UINavigationController(rootViewController: event.destination)
        self?.window.rootViewController = navigation
}
```

- Registering a type of a location - Useful for locations which are modally presented and doesn't need to remain in memory once dismissed

```
Navigator.shared
    .map(ids: Route.root, location: DetailViewController.self) { [weak self] (event) in
        guard let navcon = self?.window.rootViewController as? UINavigationController else { return }
        event.destination.title = "Detail"
        navcon.pushViewController(event.destination, animated: true)
}
```

- Registering a custom location - Useful for custom non-UIViewController locations such as opening a url.

```
Navigator.shared
    .map(ids: Route.openUrl, location: CustomLocation(value: URL(string: "https://www.google.com"))) {
                (event) in
                
        guard let url = event.destination.value else { return }
        UIApplication.shared.open(url,
                                  options: [:],
                                  completionHandler: nil)
       }
```

# Navigation

- Trigger the navigation event block
```
Navigator.shared.navigate(id: Route.root.first, isAnimated: true, data: "Hello World")
```

# To Do
- Support dynamic url parsing to get route parameters
