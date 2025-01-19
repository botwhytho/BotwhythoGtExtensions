Extension { #name : #String }

{ #category : #'*BotwhythoGtExtensions' }
String >> gtCopyToClipboardFor: anAction [
	<gtAction>
	^ anAction button
		label: 'Copy to Clipboard';
		action: [ GtClipboard clipboardText: self ]
]

{ #category : #'*BotwhythoGtExtensions' }
String >> writeToFile: aFileReferences [
	^ aFileReferences asFileReference
		writeStreamDo: [ :aStream | aStream nextPutAll: self ];
		yourself
]
