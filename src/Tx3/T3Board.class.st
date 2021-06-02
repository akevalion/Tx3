"
TODO
"
Class {
	#name : #T3Board,
	#superclass : #Object,
	#instVars : [
		'matrix'
	],
	#category : #Tx3
}

{ #category : #'instance creation' }
T3Board class >> new: aNumber [
	^ self new
		dimension: aNumber;
		yourself
]

{ #category : #public }
T3Board >> allPositions [
	<script: '(self new: 3) allPositions inspect '>
	| allPositions n |
	n := matrix rowCount.
	allPositions := OrderedCollection new.
	allPositions addAll: ((1 to: n) copy
		collect: [ :r | (1 to: n) collect: [ :c | c @ r ]]).
	allPositions addAll: ((1 to: n) copy
		collect: [ :r | (1 to: n) collect: [ :c | r @ c ]]).
		
	allPositions add: ((1 to: n) collect: [:i | i @ i ]).
	allPositions add: ((1 to: n) collect: [:i | (n+1-i) @ i ]).
	^ allPositions
]

{ #category : #accessing }
T3Board >> dimension: aNumber [
	self matrix: (Array2D rows: aNumber columns: aNumber)
]

{ #category : #testing }
T3Board >> draw [
	^ matrix allSatisfy: #notNil
]

{ #category : #accessing }
T3Board >> matrix [

	^ matrix
]

{ #category : #accessing }
T3Board >> matrix: anObject [

	matrix := anObject
]

{ #category : #'instance creation' }
T3Board >> newGame [
	self matrix: (Array2D rows: matrix rowCount columns: matrix columnCount)
]

{ #category : #public }
T3Board >> put: aPoint symbol: aSymbol [
	| value |
	(aPoint y between: 1 and: matrix rowCount) ifFalse: [ ^ false ].
	(aPoint x between: 1 and: matrix columnCount) ifFalse: [ ^ false ].
	
	value := matrix at: aPoint y at: aPoint x.
	value ifNotNil: [ ^ false ].

	matrix at: aPoint y at: aPoint x put: aSymbol.
	^ true
	
]

{ #category : #testing }
T3Board >> tictactoe: positions with: aSymbol [
	^ positions allSatisfy: [ :p | (matrix at: p y at: p x) = aSymbol ]
]

{ #category : #public }
T3Board >> winnerPositions: aSymbol [
	^ self allPositions 
		detect: [ :positions | self tictactoe: positions with: aSymbol ] 
		ifNone: [ nil ]
]
