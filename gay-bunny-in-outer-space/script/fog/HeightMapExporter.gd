extends Node

@export var terrain: Terrain3D

func _ready() -> void:
	var result: Error = terrain.data.export_image("height_map.res", Terrain3DRegion.TYPE_HEIGHT)
	if (result != Error.OK):
		print("Failed to export terrain height map: " + error_string(result))
