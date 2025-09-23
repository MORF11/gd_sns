extends RigidBody2D

func _integrate_forces(state):
	var contact_count = state.get_contact_count()
	print(contact_count)
	for i in range(contact_count):
		var contact_pos = state.get_contact_local_position(i)
		var collider = state.get_contact_collider_object(i)
		print("Контакт с: ", collider, " в позиции: ", contact_pos)

#
#func _on_body_entered(body: Node) -> void:
	#var contacts = get_contacts()
	#for contact in contacts:
		#print("Точка контакта: ", contact.position)
