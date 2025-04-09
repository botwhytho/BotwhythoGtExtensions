Extension { #name : #MetaclassForTraits }

{ #category : #'*BotwhythoGtExtensions' }
MetaclassForTraits class >> gtTraitsSortedByUsersFor: aView [
	<gtClassView>
	<gtView>
	^ aView columnedList
		title: 'Traits';
		priority: 0;
		items: [ (MetaclassForTraits allSubInstances
				collect: [ :each | each users size -> each ]) sorted: #key descending ];
		column: 'Users' text: #key;
		column: 'Trait' text: #value;
		send: #value
]
