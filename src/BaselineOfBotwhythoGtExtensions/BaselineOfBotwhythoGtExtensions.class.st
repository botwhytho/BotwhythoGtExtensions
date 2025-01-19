Class {
	#name : #BaselineOfBotwhythoGtExtensions,
	#superclass : #BaselineOf,
	#category : #BaselineOfBotwhythoGtExtensions
}

{ #category : #adding }
BaselineOfBotwhythoGtExtensions >> addDateInsertShortcut [
	| method |
	method := [ LePageToolContentTreeElement >> #initialize ]
			on: KeyNotFound
			do: [ nil ].
	method
		ifNotNil: [ | ast link |
			ast := method ast.
			link := MetaLink new
					metaObject: [ thisContext stack
							detect: [ :each | each receiver isKindOf: LePageToolContentTreeElement ]
							ifFound: [ :found | found receiver initializeDateInsertShortcut ] ];
					selector: #value;
					control: #after;
					arguments: #().
			ast link: link ]
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
