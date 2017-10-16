![alt tag](./Assets/PredixMobileUIKitTitle.png)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Releases](https://img.shields.io/badge/Release-0.1-blue.svg)](https://github.com/PredixDev/PredixMobileUIKit/releases)

PredixMobileUIKit
====

iOS UI Components designed for [Predix](https://predix.io)


## Components
#### PredixDonutView
The PredixDonutView is a donut and pie chart, that defaults to the regular Predix data visualization color set. It's Interface Builder enabled, and has various properties for controlling its legend placement, donut characteristics, and an easy helper-method for loading data from a simple name/value dictionary.

#### PredixTimeSeriesView
The PredixTimeSeriesView is a line chart that easily shows Time Series data from the Predix Time Series service.  It's Interface Builder enabled, and has various properties for controlling its legend placement, title and other characteristics, and an easy method for loading time series data.

#### PredixCircleProgressView
The PredixCircleProgressView is a circular progress display. It supports two thresholds, with color animations when those thresholds are crossed, progress update animation, clockwise or counterclockwise display, and many other options.

---
Getting Started
====
The PredixMobileUIKit project uses [Carthage](https://github.com/Carthage/Carthage) package manager to manage it's [dependencies](#dependencies).

Users should install Carthage, then once you've downloaded the PredixMobileUIKit repository, run the command: `carthage update` to download and build the required project dependancies before opening the project files in Xcode.

The PredixMobileUIKit repo includes a demonstration project: PredixMobileUIKitDemo. This project can show you usage of some of the PredixMobileUIKit provided views. 

Documentation
====
The framework is fully documented for Xcode's quick help. Additionally, full online documentation can be found here: [documentation site](http://predixdev.github.io/PredixMobileUIKit/)

---

Contributions
====
[See Contributions documentation](Contributions.md)

License
====
[GE Software Development License Agreement](LICENSE.md)

<a name="dependencies"></a>
Dependencies:
====
#### PredixMobileSDK
Copyright 2017 GE Digital

[https://github.com/PredixDev/PredixMobileSDK](https://github.com/PredixDev/PredixMobileSDK)

#### Charts
Copyright 2016 Daniel Cohen Gindi & Philipp Jahoda

Licensed under the Apache License, Version 2.0

[https://github.com/danielgindi/Charts](https://github.com/danielgindi/Charts)

Tools
====
The PredixMobileUIKit project uses the following tools in it's CI build process:

#### SwiftLint
A tool to enforce Swift style and conventions

SwiftLint is maintained and funded by Realm Inc.

[MIT licensed](https://github.com/realm/SwiftLint/blob/master/LICENSE)

[https://github.com/realm/SwiftLint](https://github.com/realm/SwiftLint)

#### Jazzy
Jazzy is a command-line utility that generates documentation for Swift or Objective-C

Jazzy is maintained and funded by Realm Inc.

[MIT licensed](https://github.com/realm/jazzy/blob/master/LICENSE)

[https://github.com/realm/jazzy](https://github.com/realm/jazzy)

---

