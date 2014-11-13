RIME
====

RIME (Remote Image Manipulation Environment) is an Android/iOS application that uses a phone's sensors to send commands to [ViPER (Video Performance System)](https://github.com/isha/ViPer)

Setup
=====

Follow the directions to install openfl at [openfl.org](http://www.openfl.org/download).

Run the setup command for desired platforms:

```
lime setup android
lime setup windows
lime setup linux
lime setup mac
```

Required Libraries
=================

The following libraries need to be installed by running:

```
haxelib install msignal
```

```
haxelib install haxeui
```

```
From the root RIME directory
haxelib dev SensorExtension SensorExtension
```

```
From the root RIME directory
haxelib dev hxudp hxudp
```

Running RIME
============

From the root RIME directory run any of the following:

```
lime test neko
lime test linux
lime test windows
lime test mac
lime test android
lime test ios
```