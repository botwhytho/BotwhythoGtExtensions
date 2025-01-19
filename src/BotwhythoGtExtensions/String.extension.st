Extension { #name : #String }

{ #category : #'*BotwhythoGtExtensions' }
String >> gtCopyToClipboardFor: anAction [
	<gtAction>
	^ anAction button
		label: 'Copy to Clipboard';
		action: [ GtClipboard clipboardText: self ]
]
