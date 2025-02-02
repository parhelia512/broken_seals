tool
extends TerrainLevelGenerator

var lseed = 0

func setup(world : TerrainWorld, level_seed : int, spawn_mobs : bool, library: TerrainLibrary) -> void:
	lseed = level_seed

func _generate_chunk(chunk: TerrainChunk) -> void:
	chunk.channel_ensure_allocated(TerrainChunkDefault.DEFAULT_CHANNEL_TYPE, 1)
	chunk.channel_ensure_allocated(TerrainChunkDefault.DEFAULT_CHANNEL_ISOLEVEL, 0)
	
	var s : OpenSimplexNoise = OpenSimplexNoise.new()
	s.seed = lseed
	
	for x in range(-chunk.margin_start, chunk.size_x + chunk.margin_end):
		for z in range(-chunk.margin_start, chunk.size_x + chunk.margin_end):
			var vx : int = x + (chunk.position_x * chunk.size_x)
			var vz : int = z + (chunk.position_z * chunk.size_z)
			
			var val : float = (s.get_noise_2d(vx, vz) + 2)
			val *= val
			val *= 20.0

			chunk.set_voxel(val, x, z, TerrainChunkDefault.DEFAULT_CHANNEL_ISOLEVEL)

			if val < 50:
				chunk.set_voxel(2, x, z, TerrainChunkDefault.DEFAULT_CHANNEL_TYPE)
			elif val > 70:
				chunk.set_voxel(4, x, z, TerrainChunkDefault.DEFAULT_CHANNEL_TYPE)
