Extension { #name : #BrValuableStencil }

{ #category : #'*BotwhythoGtExtensions' }
BrValuableStencil >> gtLiveDrawingsFor: aView [
	<gtView>
	| animated animateTask animateTaskBuilder containerElement iconElement iconContainerElement listElement segmentIndex segments |
	((self valuable sourceNode allChildren select: #isVariable)
		anySatisfy: [ :aVariable | aVariable variable value = BlSvgPath ])
		ifFalse: [ ^ aView empty ].
	segmentIndex := 1.
	animated := false.
	iconElement := self asElement.
	segments := iconElement geometry instVarNamed: #segments.
	animateTaskBuilder := [ BlRepeatedTaskAction new
			delay: 64 milliseconds;
			action: [ iconContainerElement
					replaceChild: (iconContainerElement childAt: 1)
					with: (self asElement
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
						iconContainerElement
							replaceChild: (iconContainerElement childAt: 1)
							with: (self asElement
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
