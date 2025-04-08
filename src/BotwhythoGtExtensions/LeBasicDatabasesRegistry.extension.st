Extension { #name : #LeBasicDatabasesRegistry }

{ #category : #'*BotwhythoGtExtensions' }
LeBasicDatabasesRegistry class >> gtRegistriesFor: aView [
	<gtClassView>
	<gtView>
	^ aView explicit
		title: 'Registries';
		priority: 0;
		stencil: [ | container |
			container := BrVerticalPane new matchParent.
			self allSubInstances
				do: [ :each | 
					container
						addChild: (BrAsyncWidget new
								margin: (BlInsets all: 10);
								background: Color white;
								aptitude: BrShadowAptitude new
										+ (BrGlamorousButtonExteriorAptitude new
												backgroundPaint: Color white;
												borderPaint: Color transparent);
								constraintsDo: [ :c | 
									c vertical fitContent.
									c horizontal matchParent ];
								stencil: [ BrVerticalPane new
										hMatchParent;
										vFitContent;
										addChild: (each gtDatabasesFor: GtPhlowView empty) asElement ]) ].
			container asScrollableElement ];
		actionUpdateButton
]
