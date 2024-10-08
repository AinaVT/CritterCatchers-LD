class_name Utils
extends Object


static func get_critter_at_point(point: Vector2) -> Critter:
	return get_critters_at_point(point).front()


static func get_critters_at_point(point: Vector2) -> Array[Critter]:
	var results: Array[Critter] = []
	var params := PhysicsPointQueryParameters2D.new()
	params.collide_with_areas = true
	params.collide_with_bodies = false
	params.collision_mask = 0x1
	params.position = point
	var tree := Engine.get_main_loop() as SceneTree
	var state := tree.root.get_viewport().world_2d.direct_space_state
	var result := state.intersect_point(params)
	for info in result:
		var collider: Area2D = info.get("collider")
		if !collider: continue
		var critter := collider.owner
		if critter is Critter:
			results.append(critter)
			
	return results
