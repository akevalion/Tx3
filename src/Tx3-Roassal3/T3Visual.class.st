"
todo
"
Class {
	#name : #T3Visual,
	#superclass : #SpPresenter,
	#instVars : [
		'game',
		'canvas',
		'mainCanvas',
		'menuBar',
		'playersCanvas'
	],
	#category : #'Tx3-Roassal3'
}

{ #category : #specs }
T3Visual class >> defaultSpec [
	| h |
	h := SpBoxLayout newHorizontal
		add: #menuBar expand: false;
		add: #playersCanvas;
		yourself.
	^ SpBoxLayout newVertical
		add: h expand: false;
		add: #mainCanvas;
		yourself
]

{ #category : #hooks }
T3Visual >> addOPlay: p duration: d [
	| s c |
	s := self cellSize.
	c := RSPieSlice new
		position: (p -0.5) * s;
		alphaAngle: 0;
		betaAngle: 360;
		border: (RSBorder new width: 0.1);
		color: Color white;
		innerRadius: s * 0.25;
		externalRadius: s * 0.3;
		yourself.
	canvas add: c.
	d = 0 asSeconds ifTrue: [ ^ c ].
	canvas newAnimation
		duration: d;
		from: 0;
		to: 360;
		on: c set: #betaAngle:.
	
	^ c
]

{ #category : #hooks }
T3Visual >> addPlay: player position: aPoint [
	^ self addPlay: player position: aPoint duration: 300 milliSeconds
]

{ #category : #hooks }
T3Visual >> addPlay: player position: aPoint duration: d [
	^ player symbol = 'x' 
		ifTrue: [ self addXPlay: aPoint duration: d ]
		ifFalse: [ self addOPlay: aPoint duration: d ].

]

{ #category : #hooks }
T3Visual >> addXPlay: p duration: dur [
	| l1 l2 s dn g d |
	s := self cellSize.
	d := s * 0.25.
	dn := d negated @ d.
	l1 := self newLine
		startPoint: (p-1) * s + d;
		color: self xColor;
		endPoint: p * s - d;
		yourself.
	l2 := self newLine
		startPoint: (p - (0@1)) * s + dn;
		endPoint: (p- (1@0)) * s - dn;
		color: self xColor;
		yourself.
		
	g := { l1. l2 } asGroup asShape.
	canvas add: g.
	dur = 0 asSeconds ifTrue: [ ^ g ].
	l2 color: Color transparent.
	canvas newAnimation
		delay: dur;
		duration: dur;
		from: Color transparent;
		to: self xColor;
		on: l2 set: #color:.
	
	g children doWithIndex: [ :l :i | 
		canvas newAnimation
			duration: dur;
			delay: dur * (i - 1);
			from: l startPoint;
			to: l endPoint;
			on: l set: #endPoint:.
		l endPoint: l startPoint.
		 ].
	
	^ g
	
]

{ #category : #accessing }
T3Visual >> backgroundColor [
	^ Color gray muchLighter
]

{ #category : #hooks }
T3Visual >> boxFor: label [
	^ RSBox new
		color: (Color white alpha: 0.7);
		position: label position;
		extent: label extent + 10;
		border: (RSBorder new width: 2; color: Color black; joinMiter);
		yourself.
	
	
	
]

{ #category : #accessing }
T3Visual >> cellSize [
	^ 20
]

{ #category : #hooks }
T3Visual >> clean [
	(canvas shapes copy
		flatCollect: [ :shape | 
			shape children 
				ifNil: [ { shape } ]
				ifNotNil:  [ shape children ]
			])
		do: [ :shape |
			| a1 a2 |
			a1 := canvas transitionAnimation
				delay: 500 milliSeconds;
				duration: 500 milliSeconds;
				from: shape color;
				to: Color transparent;
				on: shape set: #color:.
			a2 := a1 copy.
			a2 on: shape set: #borderColor:.
			canvas addAnimation: a1; addAnimation: a2.
			 ].
]

{ #category : #events }
T3Visual >> click: evt [
	| newPos |
	newPos := (evt position / self cellSize) asIntegerPoint.
	game putOnBoard: newPos+1.
]

{ #category : #hooks }
T3Visual >> fixPositions: positions [
	| pos s n |
	pos := positions - 0.5.
	s := self cellSize.
	n := positions size.
	pos first x = pos last x ifTrue: [ 
		pos 
			at: 1 put: pos first - (0@0.5);
			at: n put: pos last + (0@0.5).
	]ifFalse: [ pos first y = pos last y ifTrue: [ 
		pos 
			at: 1 put: pos first - (0.5@0);
			at: n put: pos last + (0.5@0).
	] ifFalse: [ pos first x > pos last x ifTrue: [ 
		pos 
			at: 1 put: pos first + (0.5 @ -0.5);
			at: n put: pos last - (0.5@ -0.5).
	] ifFalse: [ 
		pos 
			at: 1 put: pos first - 0.5;
			at: n put: pos last + 0.5.
	 ] ] ].
	^ pos
]

{ #category : #accessing }
T3Visual >> game [

	^ game
]

{ #category : #accessing }
T3Visual >> game: anObject [
	game := anObject.
	
	game 
		when: T3NewGameEvent do: [ self newGame ];
		when: T3PlayEvent do: [ :evt | self newPlay: evt ];
		when: T3DrawEvent do: [ self newDraw ];
		when: T3WinnerEvent do: [:evt | self newWinner: evt ];
		when: T3TurnEvent do: [ self newScore ];
		newGame.
]

{ #category : #initialization }
T3Visual >> initializePresenters [
	super initializePresenters.
	menuBar := self mainMenu.
	mainCanvas := self instantiate: SpRoassalPresenter.
	playersCanvas := self instantiate: SpRoassalPresenter.
	canvas := mainCanvas canvas.
	canvas
		color: self backgroundColor;
		when: RSMouseClick send: #click: to: self;
		when: RSExtentChangedEvent send: #zoomToFit to: canvas. 
		
	playersCanvas canvas
		color: '404040';
		when: RSExtentChangedEvent send: #zoomToFit to: playersCanvas canvas. 
		
]

{ #category : #initialization }
T3Visual >> initializeWindow: window [
	window 
		title: 'TicTacToe';
		initialExtent: 500@400.
]

{ #category : #initialization }
T3Visual >> mainMenu [
	^ self newMenuBar
		addGroup: [ :group |
			group 
				addItem: [ :item |
					item 
						name: 'Game';
						icon: (self iconNamed: #smallQA);
						subMenu: self subMenu ];
				addItem: [ :item |
					item
						name: 'Oponent';
						icon: (self iconNamed: #smallQA);
						subMenu: self subMenuOponents ] ]
]

{ #category : #hooks }
T3Visual >> newAnimation [
	^ canvas newAnimation
		duration: 500 milliSeconds;
		yourself
]

{ #category : #'game logic' }
T3Visual >> newDraw [
	| label box |
	label := RSLabel new
		text: 'Draw!';
		position: 1.5 asPoint * self cellSize;
		yourself.
	box := self boxFor: label.
	canvas addAll: {box. label}
	
	
	
]

{ #category : #'game logic' }
T3Visual >> newGame [
	| matrix allLines lines |
	canvas shapes copy do: #remove.
	canvas animations do: #stop.
	self newScore.
	matrix := game board matrix.
	allLines := RSGroup new.
	lines := self simpleLines: matrix rowCount direction: [ :a :b | a @ b ].
	allLines addAll: lines.
	lines := self simpleLines: matrix columnCount direction: [ :a :b | b @ a ].
	allLines addAll: lines.
	canvas addAll: allLines.
	self newLineAnimation: allLines.
	canvas zoomToFit.
	canvas signalUpdate.
]

{ #category : #accessing }
T3Visual >> newLine [
	^ RSLine new
		capRound;
		yourself
]

{ #category : #hooks }
T3Visual >> newLineAnimation: lines [
	lines do: [ :line | 
		self newAnimation
			from: line position;
			to: line endPoint;
			on: line set: #endPoint:.
		self newAnimation
			from: line position;
			to: line startPoint;
			on: line set: #startPoint:.
		 ].
]

{ #category : #'game logic' }
T3Visual >> newPlay: evt [
	self addPlay: evt player position: evt position.
	canvas signalUpdate.
]

{ #category : #'game logic' }
T3Visual >> newScore [
	| c labels label |
	c := playersCanvas canvas.
	c animations do: #stop.
	c shapes do: #remove.
	
	labels := { game playerA. game playerB } collect: [ :p | 
		| l1 l2 g  |
		l1 := RSLabel new 
			text: p symbol, ':';
			color: Color white;
			fontSize: 15;
			yourself.
		l2 := RSLabel new 
			text: p wins;
			color: Color white;
			fontSize: 10;
			yourself.
		g := { l1. l2 } asGroup.
		RSHorizontalLineLayout new alignLabel; gapSize: 20; on: g.
		
		(g asShapeFor: p)
			color: Color gray;
			padding: (Margin left: 10 right: 10 top: 1  bottom: 2 );
			draggable;
			yourself.
		 ].
	RSHorizontalLineLayout on: labels.
	c addAll: labels.
	label := c shapeFromModel: game currentPlayer.
	c newAnimation
		repeat;
		duration: 1 seconds;
		scale: (NSScale linear
			domain: #(0 0.5 1);
			range: {Color gray. (Color colorFrom: '404040'). Color gray});
		on: label set: #color:.
		
	c zoomToFit.
	c signalUpdate.
		
]

{ #category : #'game logic' }
T3Visual >> newWinner: evt [
	| line pos s |
	pos := self fixPositions: evt positions.
	s := self cellSize.
	line := self newLine
		color: Color red;
		startPoint: pos first * s;
		yourself.
	
	(canvas animationFrom: { 
		canvas transitionAnimation
			when: RSAnimationStartEvent do: [ canvas add: line ];
			duration: 500 milliSeconds;
			from: line startPoint;
			to: pos last*s;
			on: line set: #endPoint:;
			when: RSAnimationEndEvent do: [ 
				self clean.
				self showWinner: evt ].
	}) delay: 500 milliSeconds.


	
]

{ #category : #accessing }
T3Visual >> oColor [
	^ Color white
]

{ #category : #hooks }
T3Visual >> showWinner: evt [
	| shapes center pos n boardCenter scale label block |
	pos := evt positions.
	center := (pos first + pos last) / 2.0 -0.5.
	shapes := pos collect: [ :p | self addPlay: evt player position: p duration: 0 milliSeconds ].
	n := game dimension.
	boardCenter := n asPoint / 2.0* self cellSize.
	scale := (self cellSize * n) / self cellSize * 0.75.
	label := nil.
	block := [ 
		label ifNil: [ 
			label := RSLabel new
				text: 'Winner!';
				fontSize: 10;
				addedIn: canvas.
			RSLocation new below; move: label on: shapes first.
			canvas signalUpdate.
		]
	].
	shapes do: [ :s | | p |
		p := center * self cellSize.
		(canvas animationFrom: { 
			canvas transitionAnimation
				delay: 400 milliSeconds;
				duration: 400 milliSeconds;
				from: s position;
				to: p;
				on: s set: #position:.
			canvas transitionAnimation
				duration: 300 milliSeconds;
				onStepDo: [ :t |
					s matrix
						loadIdentity;
						translation: (p interpolateTo: boardCenter at: t);
						scaleBy: (1 interpolateTo: scale at: t).
					s resetPath; resetBBox.
					 ].
		})	when: RSAnimationEndEvent do: block.
	]
		
]

{ #category : #hooks }
T3Visual >> simpleLines: n direction: block [
	^ (1 to: n-1) collect: [ :i |
		self newLine
			startPoint: (block value: 0 value: i) * self cellSize;
			endPoint: (block value: n  value: i) * self cellSize;
			yourself ].
	
]

{ #category : #initialization }
T3Visual >> subMenu [
	^ self newMenu
		addItem: [ :item |
			item
				name: '3x3';
				action: [ game dimension: 3 ] ];
		addItem: [ :item |
			item
				name: '4x4';
				action: [ game dimension: 4 ] ];
		addItem: [ :item |
			item
				name: '10x10';
				action: [ game dimension: 10 ] ];
		addItem: [ :item |
			item
				name: 'New Game';
				action: [ game newGame  ] ]
]

{ #category : #initialization }
T3Visual >> subMenuOponents [
	^ self newMenu
		addItem: [ :item |
			item
				name: 'Random machine';
				action: [ game playerB: (T3RandomPlayer new symbol: 'o') ] ];
		addItem: [ :item |
			item
				name: 'Againts Friend';
				action: [ game playerB: (T3Player new symbol: 'o') ] ].
]

{ #category : #accessing }
T3Visual >> xColor [
	^ Color black
]
