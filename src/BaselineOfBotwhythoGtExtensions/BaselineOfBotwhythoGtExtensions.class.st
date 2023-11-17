Class {
	#name : #BaselineOfBotwhythoGtExtensions,
	#superclass : #BaselineOf,
	#category : #BaselineOfBotwhythoGtExtensions
}

{ #category : #baseline }
BaselineOfBotwhythoGtExtensions >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec package: 'BotwhythoGtExtensions'
		]
]
