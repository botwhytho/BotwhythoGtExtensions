Extension { #name : #TAsyncStream }

{ #category : #'*BotwhythoGtExtensions' }
TAsyncStream >> asGtSearchFilter [
	^ GtFromCollectionSearchFilter from: self
]
