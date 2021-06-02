"
TODO
"
Class {
	#name : #T3PlayEvent,
	#superclass : #T3Event,
	#instVars : [
		'player',
		'position'
	],
	#category : #'Tx3-Events'
}

{ #category : #accessing }
T3PlayEvent >> player [

	^ player
]

{ #category : #accessing }
T3PlayEvent >> player: anObject [

	player := anObject
]

{ #category : #accessing }
T3PlayEvent >> position [

	^ position
]

{ #category : #accessing }
T3PlayEvent >> position: anObject [

	position := anObject
]
