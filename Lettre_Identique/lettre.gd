extends Node

const alphabet = ['a', 'b', 'c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']

func get_random_letter():
	return alphabet[randi_range(0,alphabet.size()-1)]

func get_random_letter_exclude(exclude):
	var temp_alphabet = alphabet
	temp_alphabet.erase(exclude)
	return temp_alphabet[randi_range(0,temp_alphabet.size()-1)]
	

