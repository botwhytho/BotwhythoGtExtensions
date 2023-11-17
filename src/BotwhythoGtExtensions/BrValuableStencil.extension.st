Extension { #name : #BrValuableStencil }

{ #category : #'*BotwhythoGtExtensions' }
BrValuableStencil >> gtLiveDrawingsFor: aView [
	<gtView>
	| containerElement iconElement iconContainerElement listElement segments |
	((self valuable sourceNode allChildren select: #isVariable)
		anySatisfy: [ :aVariable | aVariable variable value = BlSvgPath ])
		ifFalse: [ ^ aView empty ].
	iconElement := self asElement.
	segments := iconElement geometry instVarNamed: #segments.
	listElement := GtPhlowProtoView new list
			items: [ segments ];
			itemStencil: [ BrLabel new aptitude: BrGlamorousListLabelAptitude ];
			itemDataBinder: [ :anItemElement :anItem :anIndex | 
				anItemElement text: anItem asString.
				anItemElement
					when: BlMouseEnterEvent
					do: [ :anEvent | 
						anEvent consumed: true.
						iconContainerElement
							replaceChild: (iconContainerElement childAt: 1)
							with: (self asElement
									geometry: (iconElement geometry copy
											instVarNamed: #segments
												put: ((iconElement geometry instVarNamed: #segments) first: anIndex);
											yourself)) asScalableElement ] ].
	^ aView explicit
		title: 'Live Drawing';
		priority: 10;
		stencil: [ containerElement := BrHorizontalPane new.
			iconContainerElement := BrHorizontalPane new.
			containerElement
				matchParent;
				addChildren: {BrFrame new
							matchParent;
							addChild: listElement asElement;
							aptitude: BrShadowAptitude;
							background: Color white;
							margin: ((BlInsets all: 10) withRight: 5).
						iconContainerElement
							alignCenter;
							matchParent;
							addChild: iconElement asScalableElement;
							constraintsDo: [ :c | 
								c vertical matchParent.
								c horizontal matchParent ];
							aptitude: BrShadowAptitude;
							background: Color white;
							margin: ((BlInsets all: 10) withLeft: 5)} ]
]
