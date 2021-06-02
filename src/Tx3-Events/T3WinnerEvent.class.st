"
TODO
"
Class {
	#name : #T3WinnerEvent,
	#superclass : #T3Event,
	#instVars : [
		'positions',
		'player'
	],
	#category : #'Tx3-Events'
}

{ #category : #accessing }
T3WinnerEvent >> player [

	^ player
]

{ #category : #accessing }
T3WinnerEvent >> player: anObject [

	player := anObject
]

{ #category : #accessing }
T3WinnerEvent >> positions [

	^ positions
]

{ #category : #accessing }
T3WinnerEvent >> positions: anObject [

	positions := anObject
]
