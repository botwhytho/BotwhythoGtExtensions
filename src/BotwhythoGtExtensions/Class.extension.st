Extension { #name : #Class }

{ #category : #'*BotwhythoGtExtensions' }
Class >> gtClassesByTagsFor: aView [
	<gtClassView>
	<gtView>
	self = Class ifFalse: [ ^ aView empty ].
	^ aView columnedList
		title: 'Classes by Tag';
		priority: 1;
		items: [ (Class allSubclasses
				groupedBy: [ :each | [ each tags first ] on: SubscriptOutOfBounds do: [ #Untagged ] ])
				associations sorted: [ :each | each value size ] descending ];
		column: 'Classs with Tag' text: [ :each | each value size ];
		column: 'Tag' text: #key;
		send: #value;
		actionStencil: [ :aButton | 
				| classesByTag |
				GtSpotterDropdownButtonStencil new
					valuable: [ classesByTag := ((Class allSubclasses
								groupedBy: [ :each | [ each tags first ] on: SubscriptOutOfBounds do: [ #Untagged ] ])
								associations sorted: [ :each | each value size ] descending)
								asOrderedDictionary.
						classesByTag keys sorted ];
					tooltip: 'Search Tags';
					objectActOn: [ :anActOnEvent :anItem :theButton | 
						| columnedList class |
						anActOnEvent beActed.
						class := anActOnEvent objectToSend.
						columnedList := theButton phlow viewContent
								allChildrenBreadthFirstDetect: [ :child | child isKindOf: BrColumnedList ]
								ifFound: [ :child | child ].
						columnedList scrollToItem: (classesByTag associationAt: class).
						columnedList
							selectOne: (columnedList items indexOf: (classesByTag associationAt: class)).
						theButton phlow spawnObject: (classesByTag at: class) ];
					asElement ]
			tooltip: 'Search Tags'
]
