A **Swift** based reimplementation of the Apple 3D Touch.
<br />
<br />
## Features
...

![RFA3dTouch.gif](https://dl.dropboxusercontent.com/u/30253301/screen_3d.png)

## How To
First you need to add the framework to your project. The recommended way is to use CocoaPods.
```ruby
pod "RFA3dTouch"
```

After adding the framework to your project, you need to import the module
```swift
import RFA3dTouch
```

Usage:
```swift
        3dtouch = RFA3dTouch.instance(self) //self should implement TouchMenuListDataSource, TouchMenuListDelegate
        3dtouch.showMenu(RFA3dTouch.takeSnap(sender), point: RFA3dTouch.absolutePosition(sender.superview!, view: sender))
```

Datasource:
```swift
    func touchMenuListNumberOfRows() -> Int {
        return self.someList.count
    }
    
    func touchMenuListTitlePerRow(row: NSInteger) -> NSString {
        let model = self.someList[row] as SomeModel
        return model.name
    }
    
    func touchMenuListIconPerRow(row: NSInteger) -> NSString {
        let model = self.someList[row] as SomeModel
        return model.icon
    }
```

Delegate:
```swift
        func touchMenuListDidSelectItemForRow(row: NSInteger)
```

## Customization

...

## License

The MIT License (MIT)

Copyright (c) 2016 Rafael Assis (rafazassis@gmail.com)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
