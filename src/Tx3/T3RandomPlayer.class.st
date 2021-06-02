"
TODO
"
Class {
	#name : #T3RandomPlayer,
	#superclass : #T3Player,
	#category : #Tx3
}

{ #category : #public }
T3RandomPlayer >> play [
	game hasEnded ifTrue: [ ^ self ].
	[ 
	| m n positions |
	(Delay forMilliseconds: 500) wait.
	m := game board matrix.
	n := game dimension.
	positions := (1 to: n) flatCollect: [ :k | (1 to: n) collect: [ :j| k @ j ] ].
	positions := positions reject: [ :p | (m at: p y at: p x) notNil ].
	
	game putOnBoard: positions atRandom 
	  ] fork.
]
