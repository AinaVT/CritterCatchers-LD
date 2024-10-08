class_name SelfFreeingParticles
extends GPUParticles2D


func _ready() -> void:
	one_shot = true
	emitting = true
	finished.connect(_on_particles_end)


func _on_particles_end() -> void:
	queue_free()
