"
TODO
"
Class {
	#name : #T3Player,
	#superclass : #Object,
	#instVars : [
		'symbol',
		'wins',
		'game'
	],
	#category : #Tx3
}

{ #category : #public }
T3Player >> addWins [
	wins := wins + 1.
]

{ #category : #accessing }
T3Player >> game: aGame [
	game := aGame
]

{ #category : #initialization }
T3Player >> initialize [
	super initialize.
	wins := 0
]

{ #category : #public }
T3Player >> play [
]

{ #category : #accessing }
T3Player >> symbol [

	^ symbol
]

{ #category : #accessing }
T3Player >> symbol: anObject [

	symbol := anObject
]

{ #category : #accessing }
T3Player >> wins [
	^ wins
]
