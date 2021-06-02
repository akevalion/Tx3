"
TODO
"
Class {
	#name : #T3Examples,
	#superclass : #Object,
	#category : #'Tx3-Roassal3'
}

{ #category : #examples }
T3Examples >> example01 [
	<script: 'self new example01'>
	| g w1 w2 w3 |
	g := T3Game new.
	w1 := g open.
	w1 position: 100@100.
	w2 := g open.
	w2 position: 700@100.
	w3 := g open.
	w2 position: 1300@100.
]

{ #category : #examples }
T3Examples >> example02 [
	<script: 'self new example02'>
	| g w1 w2 |
	g := T3Game new.
	g board dimension: 4.
	g open
]

{ #category : #examples }
T3Examples >> example03 [
	<script: 'self new example03'>
	| g w1 w2 |
	g := T3Game new.
	g board dimension: 10.
	g open
]

{ #category : #examples }
T3Examples >> example04 [
	<script: 'self new example04'>
	| g |
	g := T3Game new.
	g open
]
