Class {
	#name : #BaselineOfBotwhythoGtExtensions,
	#superclass : #BaselineOf,
	#category : #BaselineOfBotwhythoGtExtensions
}

{ #category : #adding }
BaselineOfBotwhythoGtExtensions >> addDateInsertShortcut [
	| rootElement shortcut |
	rootElement := (GtWorld spaceWithId: GtWorld defaultId do: #yourself) root.
	shortcut := BlShortcutWithAction new
			name: 'Insert Today''s Date';
			combination: (BlKeyCombinationBuilder new primary key: BlKeyboardKey backslash) build;
			action: [ :aBlShortcutEvent :aBlShortcutWithAction | 
				[ aBlShortcutEvent target editor inserter
					atCursor;
					string: (Date today yyyymmdd copyReplaceAll: '-' with: '/');
					insert ] on: MessageNotUnderstood do: [  ] ].
	rootElement addShortcut: shortcut
]

{ #category : #adding }
BaselineOfBotwhythoGtExtensions >> addShortcuts [
self addDateInsertShortcut.
self addShortcutsHelperShortcut.
]

{ #category : #adding }
BaselineOfBotwhythoGtExtensions >> addShortcutsHelperShortcut [
	| rootElement shortcut |
	rootElement := (GtWorld spaceWithId: GtWorld defaultId do: #yourself) root.
	shortcut := BlShortcutWithAction new
			name: 'Show List of Keyboard Shortcuts';
			description: 'Show list of keyboard shortcuts in the currently focused element';
			combination: (BlKeyCombinationBuilder new primary key: BlKeyboardKey slash) build;
			action: [ :aBlShortcutEvent :aBlShortcutWithAction | 
				| focused pager shortcuts |
				focused := rootElement deepestFocusedChild ifNil: [ rootElement ].
				pager := focused
						withAllParentsDetect: [ :each | each isKindOf: GtPager ]
						ifFound: #yourself
						ifNone: [ nil ].
				shortcuts := focused gtShortcutsFor: GtPhlowEmptyView new.
				pager
					ifNil: [ GtInspector openOn: shortcuts from: rootElement ]
					ifNotNil: [ focused phlow spawnObject: shortcuts ] ].
	rootElement addShortcut: shortcut
]

{ #category : #baseline }
BaselineOfBotwhythoGtExtensions >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec postLoadDoIt: #postLoadActions.
			spec package: 'BotwhythoGtExtensions'
		]
]

{ #category : #adding }
BaselineOfBotwhythoGtExtensions >> postLoadActions [
	self addShortcuts
]
