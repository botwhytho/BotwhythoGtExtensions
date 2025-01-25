Extension { #name : #Character }

{ #category : #'*BotwhythoGtExtensions' }
Character >> gtCopyToClipboardFor: anAction [
	<gtAction>
	^ anAction button
		label: 'Copy to Clipboard';
		action: [ GtClipboard clipboardText: self asString ]
]
