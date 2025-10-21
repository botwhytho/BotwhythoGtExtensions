Extension { #name : #BrValuableStencil }

{ #category : #'*BotwhythoGtExtensions' }
BrValuableStencil >> gtLiveDrawingsFor: aView [
	<gtView>
	| animated animateTask animateTaskBuilder containerElement iconElement iconContainerElement listElement segmentIndex segments getSvgElement |
	getSvgElement := [ :anElement | 
		(anElement geometry isKindOf: BlSvgPath)
			ifTrue: [ anElement ]
			ifFalse: [ (anElement asElement query
					// [ :childElement | childElement geometry isKindOf: BlSvgPath ]) result
					anyOne ] ].
	(self asElement
		in: [ :aStencilElement | 
			(aStencilElement geometry isKindOf: BlSvgPath)
				or: [ (aStencilElement query
						// [ :anElement | anElement geometry isKindOf: BlSvgPath ]) result size
						= 1 ] ]) ifFalse: [ ^ aView empty ].
	segmentIndex := 1.
	animated := false.
	iconElement := getSvgElement value: self asElement.
	segments := iconElement geometry instVarNamed: #segments.
	animateTaskBuilder := [ BlRepeatedTaskAction new
			delay: 64 milliseconds;
			action: [ | newElement |
				newElement := getSvgElement value: self asElement.
				iconContainerElement
					replaceChild: (iconContainerElement childAt: 1)
					with: (newElement
							geometry: (iconElement geometry copy
									instVarNamed: #segments
										put: ((iconElement geometry instVarNamed: #segments) first: segmentIndex);
									yourself)) asScalableElement.
				segmentIndex := segmentIndex
						= (iconElement geometry instVarNamed: #segments) size
						ifTrue: [ 1 ]
						ifFalse: [ segmentIndex + 1 ].
				listElement
					scrollToIndex: segmentIndex;
					selectOne: segmentIndex ] ].
	listElement := GtPhlowProtoView new list
			items: [ segments ];
			itemStencil: [ BrLabel new aptitude: BrGlamorousListLabelAptitude ];
			itemDataBinder: [ :anItemElement :anItem :anIndex | 
				anItemElement text: anItem asString.
				anItemElement
					when: BlMouseEnterEvent
					do: [ :anEvent | 
						anEvent consumed: true.
						segmentIndex := anIndex.
						listElement
							scrollToIndex: segmentIndex;
							selectOne: segmentIndex.
						iconContainerElement
							replaceChild: (iconContainerElement childAt: 1)
							with: ((getSvgElement value: self asElement)
									geometry: (iconElement geometry copy
											instVarNamed: #segments
												put: ((iconElement geometry instVarNamed: #segments) first: segmentIndex);
											yourself)) asScalableElement ] ];
			asElement.
	^ aView explicit
		title: 'Live Drawing';
		priority: 10;
		stencil: [ containerElement := BrHorizontalPane new.
			iconContainerElement := BrHorizontalPane new.
			containerElement
				matchParent;
				addChildren: {BrFrame new
							matchParent;
							addChild: listElement;
							aptitude: BrGlamorousFocusableShadowAptitude;
							background: Color white;
							margin: ((BlInsets all: 10) withRight: 5).
						iconContainerElement
							alignCenter;
							matchParent;
							addChild: iconElement asScalableElement;
							constraintsDo: [ :c | 
								c vertical matchParent.
								c horizontal matchParent ];
							aptitude: BrGlamorousFocusableShadowAptitude;
							background: Color white;
							margin: ((BlInsets all: 10) withLeft: 5)} ];
		actionButtonIcon: BrGlamorousVectorIcons play
			tooltip: 'Animate Drawing of SVG'
			action: [ :aBrButton :aBrTab :aBrButtonModel :aBlClickEvent | 
				aBlClickEvent consumed: true.
				animated
					ifTrue: [ animated := false.
						animateTask stop.
						aBrButton icon: BrGlamorousVectorIcons play ]
					ifFalse: [ animated := true.
						animateTask := animateTaskBuilder value.
						aBrButton enqueueTask: animateTask.
						aBrButton icon: BrGlamorousVectorIcons pause ] ]
]
