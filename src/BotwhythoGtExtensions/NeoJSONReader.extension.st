Extension { #name : #NeoJSONReader }

{ #category : #'*BotwhythoGtExtensions' }
NeoJSONReader >> normalizeIntoCollection: aJSONPath [
	^ aJSONPath isString
		ifTrue: [ $. split: aJSONPath ]
		ifFalse: [ aJSONPath isCollection
				ifTrue: [ ^ aJSONPath ]
				ifFalse: [ self error: 'The parameter should be a string with period separated key names or a collection of strings of said keys' ] ]
]

{ #category : #'*BotwhythoGtExtensions' }
NeoJSONReader >> onlyJSONPath: aJSONPath [
	| path dictionary valueBlockClosure |
	path := self normalizeIntoCollection: aJSONPath.
	dictionary := self mapClass new.
	path size = 1
		ifTrue: [ valueBlockClosure := [ self parseValue ] ]
		ifFalse: [ valueBlockClosure := [ self onlyJSONPath: path allButFirst ] ].
	self
		parseMapKeysDo: [ :key | 
			key = path first
				ifTrue: [ dictionary at: path first put: valueBlockClosure value ]
				ifFalse: [ self parseValue ] ].
	^ dictionary
]

{ #category : #'*BotwhythoGtExtensions' }
NeoJSONReader >> onlyJSONPath: aJSONPath as: aSchema [
	| path dictionary valueBlockClosure |
	path := self normalizeIntoCollection: aJSONPath.
	dictionary := self mapClass new.
	path size = 1
		ifTrue: [ valueBlockClosure := [ self nextAs: aSchema ] ]
		ifFalse: [ valueBlockClosure := [ self onlyJSONPath: path allButFirst as: aSchema ] ].
	self
		parseMapKeysDo: [ :key | 
			key = path first
				ifTrue: [ dictionary at: path first put: valueBlockClosure value ]
				ifFalse: [ self parseValue ] ].
	^ dictionary
]

{ #category : #'*BotwhythoGtExtensions' }
NeoJSONReader >> onlyJSONPathLeafValue: aJSONPath [
	| counter dictionary path |
	path := self normalizeIntoCollection: aJSONPath.
	dictionary := self mapClass new.
	self
		parseMapKeysDo: [ :key | 
			key = path first
				ifTrue: [ | return |
					return := path size = 1
							ifTrue: [ {self parseValue.
									0} ]
							ifFalse: [ self onlyJSONPathLeafValue: path allButFirst ].
					counter := return second.
					dictionary at: path first put: return first ]
				ifFalse: [ self parseValue ] ].
	thisContext sender selector = #onlyJSONPathLeafValue:
		ifTrue: [ ^ {dictionary.
				(counter ifNil: [ 0 ]) + 1} ]
		ifFalse: [ counter timesRepeat: [ dictionary := dictionary flatten ].
			^ (dictionary isKindOf: self mapClass)
				ifTrue: [ dictionary associations first value ]
				ifFalse: [ dictionary first ] ]
]

{ #category : #'*BotwhythoGtExtensions' }
NeoJSONReader >> onlyJSONPathLeafValue: aJSONPath as: aSchema [
	| counter dictionary path |
	path := self normalizeIntoCollection: aJSONPath.
	dictionary := self mapClass new.
	self
		parseMapKeysDo: [ :key | 
			key = path first
				ifTrue: [ | return |
					return := path size = 1
							ifTrue: [ {self nextAs: aSchema.
									0} ]
							ifFalse: [ self onlyJSONPathLeafValue: path allButFirst as: aSchema ].
					counter := return second.
					dictionary at: path first put: return first ]
				ifFalse: [ self parseValue ] ].
	thisContext sender selector = #onlyJSONPathLeafValue:as:
		ifTrue: [ ^ {dictionary.
				(counter ifNil: [ 0 ]) + 1} ]
		ifFalse: [ counter timesRepeat: [ dictionary := dictionary flatten ].
			^ (dictionary isKindOf: self mapClass)
				ifTrue: [ dictionary associations first value ]
				ifFalse: [ dictionary first ] ]
]

{ #category : #'*BotwhythoGtExtensions' }
NeoJSONReader >> onlyParseAtPosition: anIndex [
	| wantedValues |
	self
		parseListDo: [ :index | 
			index = anIndex
				ifTrue: [ wantedValues := self parseValue ]
				ifFalse: [ self parseValue ] ].
	^ wantedValues
]

{ #category : #'*BotwhythoGtExtensions' }
NeoJSONReader >> onlyParseProperty: aPropertyName [
	| wantedValues |
	self
		parseMapKeysDo: [ :key | 
			key = aPropertyName
				ifTrue: [ wantedValues := self parseValue ]
				ifFalse: [ self parseValue ] ].
	^ wantedValues
]

{ #category : #'*BotwhythoGtExtensions' }
NeoJSONReader >> onlyParseProperty: aPropertyName as: aSchema [
	| wantedValues |
	self
		parseMapKeysDo: [ :key | 
			key = aPropertyName
				ifTrue: [ wantedValues := self nextAs: aSchema ]
				ifFalse: [ self parseValue ] ].
	^ wantedValues
]

{ #category : #'*BotwhythoGtExtensions' }
NeoJSONReader >> parseListDo: block [
	| listIndex |
	listIndex := 1.
	self expectChar: $[.
	(self matchChar: $]) 
		ifTrue: [ ^ self ].
	[ readStream atEnd ] 
		whileFalse: [
			block cull: listIndex.
			(self matchChar: $]) 
				ifTrue: [ ^ self ].
			(self matchChar: $,)
				ifFalse: [ self error: ', or ] expected' ].
				listIndex := listIndex + 1 ].
	self error: 'incomplete list'
]
