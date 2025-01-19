Extension { #name : #GtSearchFilter }

{ #category : #'*BotwhythoGtExtensions' }
GtSearchFilter class >> gtSearchClassesWithNotesFor: aView [
	<gtView>
	<gtClassView>
	^ aView explicit
		title: 'Classes with Notes';
		stencil: [ | allFilterClasses classesWithNotes |
			allFilterClasses := GtSearchFilter allSubclasses.
			classesWithNotes := LeDatabasesRegistry defaultPlaygroundDatabase pages
					select: [ :aPage | 
						aPage type isPharoClassPageType
							and: [ ((allFilterClasses collect: [ :each | each name , ' class' ])
									includes: aPage type pageClassName)
									and: [ aPage leSnippetsInPage contents anySatisfy: #isNotEmpty ] ] ]
					thenCollect: [ :aPage | aPage type pageClassName substrings first asClass ].
			classesWithNotes.
			BrSimpleList new
				items: classesWithNotes;
				stencil: [ :aClass | 
					BrLabel new
						aptitude: BrGlamorousLabelAptitude;
						text: aClass name;
						padding: (BlInsets all: 1);
						hMatchParent;
						when: BlClickEvent
							do: [ :aBlClickEvent | 
								aBlClickEvent consumed: true.
								aBlClickEvent target phlow
									spawnTool: (GtClassCoderTool forClass: aClass) ] ] ]
]
