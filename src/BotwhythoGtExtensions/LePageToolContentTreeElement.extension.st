Extension { #name : #LePageToolContentTreeElement }

{ #category : #'*BotwhythoGtExtensions' }
LePageToolContentTreeElement >> initializeDateInsertShortcut [
	self
		addShortcut: (BlShortcutWithAction new
				name: 'Insert Today''s Date';
				combination: (BlKeyCombinationBuilder new primary key: BlKeyboardKey backslash) build;
				action: [ :aBlShortcutEvent :aBlShortcutWithAction |
					aBlShortcutEvent target editor inserter
						atCursor;
						string: (Date today yyyymmdd copyReplaceAll: '-' with: '/');
						insert ])
]
