Extension { #name : #BlElementEagerQuery }

{ #category : #'*BotwhythoGtExtensions' }
BlElementEagerQuery >> \\ aSelector [
	self result size = 1
		ifFalse: [ self
				error: 'Parent queries can only be ran on individual elements, not query results with more than one element.' ].
	^ self result anyOne
		allParentsDetect: [ :anElement | 
			| return |
			return := false.
			aSelector isClass ifTrue: [ return := anElement isKindOf: aSelector ].
			aSelector isSymbol ifTrue: [ return := anElement id asSymbol = aSelector ].
			aSelector isBlock ifTrue: [ return := aSelector value: anElement ].
			return ]
		ifFound: [ :found | found query ]
		ifNone: [ self // UndefinedObject ]
]
