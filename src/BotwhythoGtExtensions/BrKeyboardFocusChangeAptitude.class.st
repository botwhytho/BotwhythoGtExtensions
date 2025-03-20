Class {
	#name : #BrKeyboardFocusChangeAptitude,
	#superclass : #BrAptitude,
	#category : #BotwhythoGtExtensions
}

{ #category : #initialization }
BrKeyboardFocusChangeAptitude >> initialize [
	super initialize
]

{ #category : #initialization }
BrKeyboardFocusChangeAptitude >> initializeListeners [
	super initializeListeners.
	self
		when: BlKeyDownEvent
			do: [ :anEvent | 
				| key |
				key := anEvent key.
				anEvent consumed: true.
				key = BlKeyboardKey arrowLeft
					ifTrue: [ BlFocusFinder new
							left;
							root: self widget parent parent;
							referenceElement: self widget;
							nextFocusDo: #requestFocus ifNone: [  ] ].
				key = BlKeyboardKey arrowUp
					ifTrue: [ BlFocusFinder new
							up;
							root: self widget parent parent;
							referenceElement: self widget;
							nextFocusDo: #requestFocus ifNone: [  ] ].
				key = BlKeyboardKey arrowRight
					ifTrue: [ BlFocusFinder new
							right;
							root: self widget parent parent;
							referenceElement: self widget;
							nextFocusDo: #requestFocus ifNone: [  ] ].
				key = BlKeyboardKey arrowDown
					ifTrue: [ BlFocusFinder new
							down;
							root: self widget parent parent;
							referenceElement: self widget;
							nextFocusDo: #requestFocus ifNone: [  ] ].
				key isReturn
					ifTrue: [ self widget loseFocus.
						self widget anchor
							ifNotNil: [ :notNil | 
								self widget
									fireEvent: (BrDropdownHideWish new
											anchor: notNil;
											yourself) ] ] ];
		when: BlMouseEnterEvent
			do: [ :anEvent | 
				anEvent consumed: true.
				self widget requestFocus ]
]

{ #category : #'api - hooks' }
BrKeyboardFocusChangeAptitude >> onAttachedTo: anElement [
	super onAttachedTo: anElement.
	widget beFocusable
]
