Extension { #name : #ByteString }

{ #category : #'*BotwhythoGtExtensions' }
ByteString >> asTempFile [
	| tempFile |
	tempFile := FileSystem currentMemoryFileSystem / UUID new asString.
	tempFile writeStreamDo: [ :aStream | aStream nextPutAll: self ].
	^ tempFile
]
