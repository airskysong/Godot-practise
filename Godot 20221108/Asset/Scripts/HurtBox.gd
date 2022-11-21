extends Area2D

signal hurt

func hurt():
	emit_signal("hurt")
