Extension { #name : #ByteString }

{ #category : #'*BotwhythoGtExtensions' }
ByteString >> >>@ aFileExtension [
	"Returns a temp file with a specific file extension"
	| tempFile |
	self assert: aFileExtension isString.
	tempFile := FileSystem currentMemoryFileSystem / UUID new asString
			, aFileExtension.
	tempFile writeStreamDo: [ :aStream | aStream nextPutAll: self ].
	^ tempFile
]

{ #category : #'*BotwhythoGtExtensions' }
ByteString >> asTempFile [
	| tempFile |
	tempFile := FileSystem currentMemoryFileSystem / UUID new asString.
	tempFile writeStreamDo: [ :aStream | aStream nextPutAll: self ].
	^ tempFile
]
