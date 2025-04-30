Extension { #name : #GtSearchMethodsFilter }

{ #category : #'*BotwhythoGtExtensions' }
GtSearchMethodsFilter >> gtGroupByGtRepoActionFor: anAction [
	<gtAction>
	^ anAction button
		priority: 1;
		label: 'Group By GT Repo';
		action: [ :aBrButton :aBrTab :aBrButtonModel :aBlClickEvent | 
			| groupedBy |
			groupedBy := self result toArray wait
					groupedBy: [ :aMethod | 
						| aPackage |
						aPackage := aMethod protocol first = $*
								ifTrue: [ aMethod protocol allButFirst asPackage ]
								ifFalse: [ aMethod methodClass package ].
						GtGitRepositoryRegistryHistory instance
							repositoryIncludingPackage: aPackage name ].
			aBlClickEvent consumed: true.
			aBrButton phlow spawnObject: groupedBy ]
]
