package com.example;

import net.fabricmc.api.ModInitializer;
import net.fabricmc.fabric.api.event.player.PlayerBlockBreakEvents;
import net.minecraft.block.Block;
import net.minecraft.block.BlockState;
import net.minecraft.block.Blocks;
import net.minecraft.registry.Registries;
import net.minecraft.util.math.BlockPos;
import net.minecraft.world.World;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.ArrayList;
import java.util.List;

public class RandomBlockReplaceMod implements ModInitializer {
	public static final String MOD_ID = "randomblockreplace";
	private static final int MAX_PICK_ATTEMPTS = 24;
	private static final List<BlockState> REPLACEMENT_STATES = new ArrayList<>();

	public static final Logger LOGGER = LoggerFactory.getLogger(MOD_ID);

	@Override
	public void onInitialize() {
		populateReplacementPool();
		LOGGER.info("Loaded {} replacement states.", REPLACEMENT_STATES.size());

		PlayerBlockBreakEvents.AFTER.register((world, player, pos, state, blockEntity) -> {
			if (world.isClient()) {
				return;
			}

			BlockState replacement = chooseReplacementState(world, pos);
			world.setBlockState(pos, replacement, Block.NOTIFY_ALL);
		});
	}

	private static void populateReplacementPool() {
		REPLACEMENT_STATES.clear();

		for (Block block : Registries.BLOCK) {
			BlockState state = block.getDefaultState();
			if (state.isAir()) {
				continue;
			}
			if (!state.getFluidState().isEmpty()) {
				continue;
			}
			REPLACEMENT_STATES.add(state);
		}

		if (REPLACEMENT_STATES.isEmpty()) {
			LOGGER.warn("No valid replacement blocks found, using stone fallback only.");
			REPLACEMENT_STATES.add(Blocks.STONE.getDefaultState());
		}
	}

	private static BlockState chooseReplacementState(World world, BlockPos pos) {
		for (int attempt = 0; attempt < MAX_PICK_ATTEMPTS; attempt++) {
			BlockState candidate = REPLACEMENT_STATES.get(world.getRandom().nextInt(REPLACEMENT_STATES.size()));
			if (candidate.canPlaceAt(world, pos)) {
				return candidate;
			}
		}

		return Blocks.STONE.getDefaultState();
	}
}
