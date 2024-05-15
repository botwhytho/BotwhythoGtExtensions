Extension { #name : #BlockClosure }

{ #category : #'*BotwhythoGtExtensions' }
BlockClosure >> asGtMethodSearchFilter [
	^ GtSearchMethodConditionsFilter condition: self
]
