Extension { #name : #Collection }

{ #category : #'*BotwhythoGtExtensions' }
Collection >> asGtSearchFilter [
	^ GtFromCollectionSearchFilter from: self
]
