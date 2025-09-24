# BotwhythoGtExtensions
Placeholder for misc extension methods, custom views, actions, etc. on top of Glamorous Toolkit
## Installation

```Smalltalk
[ EpMonitor current
	disableDuring: [ Metacello new
			repository: 'github://botwhytho/BotwhythoGtExtensions:main/src';
			baseline: 'BotwhythoGtExtensions';
			load ] ] asAsyncPromiseWithUserBackgroundPriority
```
To depend on this package add this to your baseline:

```Smalltalk
spec baseline: 'BotwhythoGtExtensions' with: [spec repository: 'github://botwhytho/BotwhythoGtExtensions:main/src']
```
