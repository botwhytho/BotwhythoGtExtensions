Class {
	#name : #PrimitiveAnalysis,
	#superclass : #Object,
	#category : #BotwhythoGtExtensions
}

{ #category : #accessing }
PrimitiveAnalysis class >> gtPrimitivesActionFor: anAction [
	<gtClassAction>
	^ anAction button
		tooltip: 'Unique Primitives';
		priority: 1;
		label: 'Primitives';
		action: [ :aButton | 
			| pragmas primitives |
			pragmas := Pragma pragmaCache associations
					select: [ :each | each key beginsWith: 'primitive' ].
			primitives := (((pragmas flatCollect: #value)
					groupedBy: [ :each | each selector , each arguments asString ])
					associations sorted: [ :each | each value size ] descending)
					asOrderedDictionary.
			aButton phlow spawnObject: primitives ]
]

{ #category : #accessing }
PrimitiveAnalysis class >> gtPrimitivesFor: aView [
	<gtClassView>
	^ aView columnedList
		title: 'Methods by Pragma';
		priority: 1;
		items: [ (Pragma pragmaCache associations
				select: [ :each | each key beginsWith: 'primitive' ])
				sorted: [ :each | each value size ] descending ];
		column: 'Pragma' text: #key;
		column: '# of Methods' text: [ :each | each value size ];
		column: 'Per Class'
			stencil: [ :each | 
				BrButton new
					aptitude: BrGlamorousButtonWithIconAptitude;
					icon: BrGlamorousVectorIcons link;
					action: [ :aBrButton :aBrButtonModel :anEvent | 
						aBrButton phlow
							spawnObject: ((each value contents groupedBy: #methodClass) associations
									sorted: [ :anAssociation | anAssociation value size ] descending)
									asOrderedDictionary ] ];
		send: [ :each | each key gtPragmas ]
]
