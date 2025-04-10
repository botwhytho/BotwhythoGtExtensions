Extension { #name : #AbstractFileReference }

{ #category : #'*BotwhythoGtExtensions' }
AbstractFileReference >> gtActionCopyAbsolutePathFor: anAction [
	<gtAction>
	^ anAction button
		priority: 0;
		label: 'Copy';
		tooltip: 'Copy absolute path string to clipboard';
		action: [ :element | GtClipboard clipboardText: self asAbsolute pathString ]
]
