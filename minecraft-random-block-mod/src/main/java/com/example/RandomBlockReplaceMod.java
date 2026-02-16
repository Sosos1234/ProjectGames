package com.example;

import net.fabricmc.api.ModInitializer;
import net.fabricmc.fabric.api.event.player.PlayerBlockBreakEvents;
import net.minecraft.core.BlockPos;
import net.minecraft.core.registries.BuiltInRegistries;
import net.minecraft.world.level.Level;
import net.minecraft.world.level.block.Block;
import net.minecraft.world.level.block.Blocks;
import net.minecraft.world.level.block.state.BlockState;
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
			if (world.isClientSide) {
				return;
			}

			BlockState replacement = chooseReplacementState(world, pos);
			world.setBlock(pos, replacement, Block.UPDATE_ALL);
		});
	}

	private static void populateReplacementPool() {
		REPLACEMENT_STATES.clear();

		for (Block block : BuiltInRegistries.BLOCK) {
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

	private static BlockState chooseReplacementState(Level world, BlockPos pos) {
		for (int attempt = 0; attempt < MAX_PICK_ATTEMPTS; attempt++) {
			BlockState candidate = REPLACEMENT_STATES.get(world.getRandom().nextInt(REPLACEMENT_STATES.size()));
			if (candidate.canSurvive(world, pos)) {
				return candidate;
			}
		}

		return Blocks.STONE.getDefaultState();
	}
}
