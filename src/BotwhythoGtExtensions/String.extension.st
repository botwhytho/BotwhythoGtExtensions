Extension { #name : #String }

{ #category : #'*BotwhythoGtExtensions' }
String >> >>@ aFileExtension [
	"Returns a temp file with a specific file extension"
	| tempFile |
	self assert: aFileExtension isString.
	tempFile := FileSystem currentMemoryFileSystem / UUID new asString
			, aFileExtension.
	tempFile writeStreamDo: [ :aStream | aStream nextPutAll: self asString ].
	^ tempFile
]

{ #category : #'*BotwhythoGtExtensions' }
String >> asTempFile [
	| tempFile |
	tempFile := FileSystem currentMemoryFileSystem / UUID new asString.
	tempFile writeStreamDo: [ :aStream | aStream nextPutAll: self asString ].
	^ tempFile
]

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
