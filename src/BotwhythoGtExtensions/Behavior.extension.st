Extension { #name : #Behavior }

{ #category : #'*BotwhythoGtExtensions' }
Behavior >> gtClassReferencesFor: aView [
	<gtClassView>
	<gtView>
	| classes |
	classes := self -> (self methods flatCollectAsSet: #gtReferencedClasses).
	^ aView mondrian
		title: 'Referenced Classes';
		priority: 13;
		painting: [ :aMondrian | 
			aMondrian nodes
				stencil: [ :each | 
					BlTextElement new
						text: each name asRopedText;
						when: BlClickEvent
							do: [ :anEvent | 
								anEvent consumed: true.
								anEvent modifiers
									in: [ :aModifier | 
										aModifier = anEvent modifiers class alt
											ifTrue: [ anEvent target phlow spawnObject: self name gtClassMatches & each gtReferences ].
										aModifier = anEvent modifiers class shift
											ifTrue: [ anEvent target phlow spawnObject: each ].
										aModifier isEmpty
											ifTrue: [ anEvent target phlow spawnTool: (GtClassCoderTool forClass: each) ] ] ] ];
				with: classes value , {classes key}.
			aMondrian edges
				stencil: [ :each | 
					BlSigmoidElement new
						beHorizontal;
						sharpness: 0.1;
						border: (BlBorder paint: Color lightGray) ];
				fromRightCenter;
				toLeftCenter;
				connect: {classes}
					from: #key
					toAll: #value.
			aMondrian layout horizontalTree
				levelDistance: 30;
				nodeDistance: 10 ]
]
