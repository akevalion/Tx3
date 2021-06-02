"
TODO
"
Class {
	#name : #T3Score,
	#superclass : #Object,
	#instVars : [
		'draws',
		'turn',
		'hasEnded'
	],
	#category : #Tx3
}

{ #category : #public }
T3Score >> addDraws [
	draws := draws + 1
]

{ #category : #accessing }
T3Score >> draws [

	^ draws
]

{ #category : #accessing }
T3Score >> draws: anObject [

	draws := anObject
]

{ #category : #accessing }
T3Score >> hasEnded [

	^ hasEnded
]

{ #category : #accessing }
T3Score >> hasEnded: anObject [

	hasEnded := anObject
]

{ #category : #initialization }
T3Score >> initialize [
	super initialize.
	self
		turn: true;
		draws: 0.
]

{ #category : #accessing }
T3Score >> turn [

	^ turn
]

{ #category : #accessing }
T3Score >> turn: anObject [

	turn := anObject
]
