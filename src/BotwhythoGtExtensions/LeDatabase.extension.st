Extension { #name : #LeDatabase }

{ #category : #'*BotwhythoGtExtensions' }
LeDatabase >> gtLatestCreatedFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Last Created';
		priority: 9;
		items: [ (self pages
				select: [ :each | 
					each shouldAppearInIndexOrDailyNotes
						and: [ each createTime asDate asMonth = Date today asMonth ] ])
				sorted: [ :each | each createTime time ] descending ];
		column: 'Page' text: #title;
		column: 'Created Date' text: [ :each | each createTime asDate asString ]
]
