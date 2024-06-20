Class {
	#name : #BaselineOfBotwhythoGtExtensions,
	#superclass : #BaselineOf,
	#category : #BaselineOfBotwhythoGtExtensions
}

{ #category : #adding }
BaselineOfBotwhythoGtExtensions >> addDateInsertShortcut [
	| method |
	method := [ LePageToolContentTreeElement >> #initialize ]
			on: KeyNotFound
			do: [ nil ].
	method
		ifNotNil: [ | ast link |
			ast := method ast.
			link := MetaLink new
					metaObject: [ thisContext sender receiver initializeDateInsertShortcut ];
					selector: #value;
					control: #after;
					arguments: #().
			ast link: link ]
]

{ #category : #baseline }
BaselineOfBotwhythoGtExtensions >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec postLoadDoIt: #postLoadActions.
			spec package: 'BotwhythoGtExtensions'
		]
]

{ #category : #adding }
BaselineOfBotwhythoGtExtensions >> postLoadActions [
	self addDateInsertShortcut
]
