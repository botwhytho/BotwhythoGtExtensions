Extension { #name : #MetaclassForTraits }

{ #category : #'*BotwhythoGtExtensions' }
MetaclassForTraits class >> gtTraitsByTagsFor: aView [
	<gtClassView>
	<gtView>
	^ aView columnedList
		title: 'Traits by Tag';
		priority: 1;
		items: [ (MetaclassForTraits allSubInstances
				groupedBy: [ :each | [ each tags first ] on: SubscriptOutOfBounds do: [ #Untagged ] ])
				associations sorted: [ :each | each value size ] descending ];
		column: 'Traits with Tag' text: [ :each | each value size ];
		column: 'Tag' text: #key;
		send: #value;
		actionStencil: [ :aButton | 
				| traitsByTag |
				GtSpotterDropdownButtonStencil new
					valuable: [ traitsByTag := ((MetaclassForTraits allSubInstances
								groupedBy: [ :each | [ each tags first ] on: SubscriptOutOfBounds do: [ #Untagged ] ])
								associations sorted: [ :each | each value size ] descending)
								asOrderedDictionary.
						traitsByTag keys sorted ];
					tooltip: 'Search Tags';
					objectActOn: [ :anActOnEvent :anItem :theButton | 
						| columnedList trait |
						anActOnEvent beActed.
						trait := anActOnEvent objectToSend.
						columnedList := theButton phlow viewContent
								allChildrenBreadthFirstDetect: [ :child | child isKindOf: BrColumnedList ]
								ifFound: [ :child | child ].
						columnedList scrollToItem: (traitsByTag associationAt: trait).
						columnedList
							selectOne: (columnedList items indexOf: (traitsByTag associationAt: trait)).
						theButton phlow spawnObject: (traitsByTag at: trait) ];
					asElement ]
			tooltip: 'Search Tags'
]

{ #category : #'*BotwhythoGtExtensions' }
MetaclassForTraits class >> gtTraitsSortedByUsersFor: aView [
	<gtClassView>
	<gtView>
	^ aView columnedList
		title: 'Traits';
		priority: 0;
		items: [ ((MetaclassForTraits allSubInstances
				collect: [ :each | each users size -> each ]) sorted: #key descending)
				collect: #value ];
		column: 'Users' text: [ :each | each users size ];
		column: 'Trait' text: #yourself;
		send: #value;
		actionStencil: [ :aButton | 
				GtSpotterDropdownButtonStencil new
					valuable: [ ((MetaclassForTraits allSubInstances
							collect: [ :each | each users size -> each ]) sorted: #key descending)
							collect: #value ];
					tooltip: 'Search Traits';
					objectActOn: [ :anActOnEvent :anItem :theButton | 
						| columnedList trait |
						anActOnEvent beActed.
						trait := anActOnEvent objectToSend.
						columnedList := theButton phlow viewContent
								allChildrenBreadthFirstDetect: [ :child | child isKindOf: BrColumnedList ]
								ifFound: [ :child | child ].
						columnedList scrollToItem: trait.
						columnedList selectOne: (columnedList items indexOf: trait).
						theButton phlow spawnObject: trait ];
					asElement ]
			tooltip: 'Search Traits'
]
