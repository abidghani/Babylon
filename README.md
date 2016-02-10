# Babylon

Notes:
Will build and compile on XCode 7.2
Written entirely in SWIFT
Data is persisted using NSKeyedArchiver and NSKeyedUnarchiver
UI is built using Storyboards and Auto-layout

Project requires Hanake library for avatar retrieval and caching.

https://github.com/Haneke/HanekeSwift.git

Installation:
Drag Haneke.xcodeproj to your project in the Project Navigator.
Select your project and then your app target. Open the Build Phases panel.
Expand the Target Dependencies group, and add Haneke.framework.
Click on the + button at the top left of the panel and select New Copy Files Phase. Set Destination to Frameworks, and add Haneke.framework.
