Extension { #name : #GtPackageDependencyStatus }

{ #category : #'*BotwhythoGtExtensions' }
GtPackageDependencyStatus >> gtDependenciesByClassFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Dependencies by Type';
		priority: 7;
		items: [ (self dependencies asArray groupedBy: #class) associations
				collect: [ :each | 
					each
						value: (each value
								sorted: [ :item | 
									| sortValuable |
									(item isKindOf: GtPharoInheritance)
										ifTrue: [ sortValuable := [ :anItem | anItem superclass asString , anItem subclass asString ] ].
									(item isKindOf: GtPharoClassReference)
										ifTrue: [ sortValuable := [ :anItem | anItem referencingMethod asString ] ].
									(item isKindOf: GtPharoClassExtension)
										ifTrue: [ sortValuable := [ :anItem | anItem extendingMethod asString ] ].

									sortValuable value: item ] ascending) ] ];
		children: [ :each | each isAssociation ifTrue: [ each value ] ifFalse: [ #() ] ];
		column: 'Dependency Type'
			text: [ :each | each isAssociation ifTrue: [ each key ] ifFalse: [ '' ] ];
		column: 'Dependency'
			text: [ :each | each isAssociation ifTrue: [ each value size ] ifFalse: [ each ] ];
		expandAll;
		send: [ :each | 
			each isAssociation
				ifTrue: [ each key = GtPharoClassReference
						ifTrue: [ ((each value groupedBy: #referencingMethod) associations
								sorted: [ :sortItem | sortItem key name ] ascending) asOrderedDictionary ]
						ifFalse: [ each value ] ]
				ifFalse: [ each ] ]
]
