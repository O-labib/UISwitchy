# UISwitchy
A more customizable, powerful replica for Apple standard UISwtich.

<p align="center">
<img src="https://github.com/baianat/UISwitchy/blob/main/readmeAssets/demo.gif">
</p>

[Quick Start](#quick-start)

[Customization](#customization)

[Delegate (Callback)](#delegate-(callback))

[Installation](#installation)

### Quick Start:

1- Drag View object from the Object Library into your storyboard.
<p align="center">
<img src="https://github.com/baianat/PSMeter/blob/main/InstructionAssets/instruction1.png">
</p>

2- Set the view's class to `UISwitchy` in the Identity Inspector. Set its module property to `UISwitchy`.

<p align="center">
<img src="https://github.com/baianat/UISwitchy/blob/main/readmeAssets/instruction%200.png">
</p>

3- Add `import UISwitchy` to the header of your view controller.

4- Create an outlet in the corresponding view controller.
``` swift
@IBOutlet weak var uiswitchy: UISwitchy!
```

### Customization:

You can customize `UISwitchy` for these attributes:
| Attribute  | Definition |
| ------------- | ------------- |
|buttonFillColorOn | color of inner circle while switch is on |
|buttonFillColorOff  | color of inner circle while switch is off |
|backgroundColorOn  | background color of the switch while is on |
| backgroundColorOff | background color of the switch while is off |
| buttonImageOn | the icon of the switch while is on |
| buttonImageOff | the icon of the switch while is off |
| imageTintingColorOn | the icon tinting color of the switch while is on |
| imageTintingColorOff | the icon tinting color of the switch while is off |
| borderColor | border color of the switch |
| borderWidth | border width of the switch |


### Delegate (Callback):
Just as the normal ios, you can listen for the state change of the switch via an `IBAction`
<p align="center">
<img src="https://github.com/baianat/UISwitchy/blob/main/readmeAssets/instruction1.png">
</p>



## Installation

To install it, simply add the following line to your Podfile:

```ruby
pod 'UISwitchy'
```

## License

UISwitchy is available under the MIT license. See the LICENSE file for more info.
