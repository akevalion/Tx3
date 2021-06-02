"
TODO
"
Class {
	#name : #T3Event,
	#superclass : #Announcement,
	#instVars : [
		'game'
	],
	#category : #'Tx3-Events'
}

{ #category : #accessing }
T3Event >> game [

	^ game
]

{ #category : #accessing }
T3Event >> game: anObject [

	game := anObject
]
