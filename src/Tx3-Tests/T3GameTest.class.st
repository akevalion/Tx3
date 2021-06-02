"
A T3GameTest is a test class for testing the behavior of T3Game
"
Class {
	#name : #T3GameTest,
	#superclass : #TestCase,
	#category : #'Tx3-Tests'
}

{ #category : #tests }
T3GameTest >> test01Basic [
	| g val |
	g := T3Game new.
	val := 1.
	g when: T3NewGameEvent do: [ :evt | val := val + 1 ].
	g newGame.
	self assert: val equals: 2.
	g dimension: 4.
	self assert: g dimension equals: 4.
	self assert: val equals: 3.
]

{ #category : #tests }
T3GameTest >> test02PutValue [
	| g player |
	g := T3Game new.
	player := nil.
	g when: T3PlayEvent do: [ :evt | player := evt player. ].
	g newGame.
	g putOnBoard: 1@1.
	
	self assert: player symbol equals: 'x'.
	self deny: g isDraw.
	self deny: g isThereAWinner.
]
