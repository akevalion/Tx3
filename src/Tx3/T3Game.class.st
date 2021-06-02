"
TODO
"
Class {
	#name : #T3Game,
	#superclass : #Object,
	#instVars : [
		'playerA',
		'playerB',
		'board',
		'score',
		'announcer'
	],
	#category : #Tx3
}

{ #category : #announcer }
T3Game >> announce: anEvent [
	announcer ifNil: [ ^ self ].
	anEvent game: self.
	announcer announce: anEvent.
 
]

{ #category : #accessing }
T3Game >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #accessing }
T3Game >> board [

	^ board
]

{ #category : #accessing }
T3Game >> board: anObject [

	board := anObject
]

{ #category : #public }
T3Game >> currentPlayer [
	^ score turn
		ifTrue: [ playerA ]
		ifFalse: [ playerB ]
]

{ #category : #public }
T3Game >> dimension [
	^ board matrix rowCount
]

{ #category : #public }
T3Game >> dimension: aNumber [
	board dimension: aNumber.
	self newGame.
]

{ #category : #testing }
T3Game >> hasEnded [
	^ score hasEnded
]

{ #category : #initialization }
T3Game >> initialize [
	super initialize.
	self 
		board: (T3Board new: 3);
		score: (T3Score new);
		playerA: (T3Player new symbol: 'x');
		playerB: (T3Player new symbol: 'o').
]

{ #category : #public }
T3Game >> isDraw [
	| res |
	res := board draw.
	res ifTrue: [ 
		self score addDraws.
		self announce: T3DrawEvent new ].
	^ res.

]

{ #category : #public }
T3Game >> isThereAWinner [
	| positions res current |
	current := self currentPlayer.
	positions := self board winnerPositions: current symbol.
	res := positions isNotNil.
	positions ifNotNil: [ 
		current addWins.
		self announce: (T3WinnerEvent new
			positions: positions;
			player: current;
			yourself)
		 ].
	^ res

]

{ #category : #public }
T3Game >> newGame [
	board newGame.
	score hasEnded: false.
	self announce: T3NewGameEvent new.
	self currentPlayer play.
]

{ #category : #accessing }
T3Game >> playerA [

	^ playerA
]

{ #category : #accessing }
T3Game >> playerA: anObject [
	playerA := anObject.
	self setUpPlayer: playerA.
]

{ #category : #accessing }
T3Game >> playerB [

	^ playerB
]

{ #category : #accessing }
T3Game >> playerB: anObject [
	playerB := anObject.
	self setUpPlayer: playerB.
]

{ #category : #public }
T3Game >> putOnBoard: aPoint [
	
	self hasEnded 
		ifTrue: [ ^ self newGame ].
	(self board put: aPoint symbol: self currentPlayer symbol) 
		ifFalse: [ ^ self ].
	self announce: (T3PlayEvent new
		player: self currentPlayer;
		position: aPoint;
		yourself).
	score hasEnded: (self isThereAWinner or: [ self isDraw ]).
	score turn: score turn not.
	self announce: T3TurnEvent new.
	self currentPlayer play

]

{ #category : #accessing }
T3Game >> score [

	^ score
]

{ #category : #accessing }
T3Game >> score: anObject [

	score := anObject
]

{ #category : #accessing }
T3Game >> setUpPlayer: player [
	player game: self.
	self currentPlayer = player ifTrue: [ player play ].
]

{ #category : #announcer }
T3Game >> when: anAnnouncementClass do: aValuable [
	self announcer when: anAnnouncementClass do: aValuable

]
