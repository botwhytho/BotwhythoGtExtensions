Class {
	#name : #BrWithExplicitDropdownAptitude,
	#superclass : #BrWithExplicitMenuAptitude,
	#category : #BotwhythoGtExtensions
}

{ #category : #initialization }
BrWithExplicitDropdownAptitude >> initialize [
	super initialize.
	self
		usePrimaryMouseButton;
		beWidgetBoundsRelocator
]

{ #category : #'event handling' }
BrWithExplicitDropdownAptitude >> onMouseUp: anEvent [
	anEvent button = mouseButton ifFalse: [ ^ self ].

	(modifiersMatcher value: anEvent modifiers) ifFalse: [ ^ self ].

	anEvent consumed: true.

	self widgetDo: [ :aWidget | relocator mouseUp: anEvent given: aWidget ].
	self widget isActivated ifTrue: [ self hide ] ifFalse: [ self show ]
]
