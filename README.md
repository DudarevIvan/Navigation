**Custom SwiftUI Navigation View**
---
How to use:
1. Import this package into your project
```Swift
import Navigation
```
2. Use
```Swift
// In the initial view where navigation starts
var body: some View {
        Navigation {
            // Your Views
            NLink(destination: Destination.forward(AnyView(OtherView()))) {
                Text("Go to Other view")
            }
        }
}
```
NLink structure has 3 directions of navigation:
- forward
- back
- home

```Swift
// Forward
NLink(destination: Destination.forward(AnyView(NextView()))) {
  Text("Go to next view")
}
// Back
NLink(destination: .back) {
  Text("Go to back")
}
// Home (Root view)
NLink(destination: .home) {
  Text("Go to home")
}
```
