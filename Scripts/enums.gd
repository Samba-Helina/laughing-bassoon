# This file contains enums we would like to use elsewhere
class_name Flags
enum CURR_TARGET {TARGET_ACTOR=1, TARGET_OBJECT=2, TARGET_COORD=4}
enum SPELL_TARGET {TARGET_COORD=1, TARGET_SELF=2, TARGET_ALLY=4, TARGET_ENEMY=8}
enum SPELL_TYPE {INSTANT=1, PROJECTILE=2, CHANNEL=4}
enum COLLISION_FLAGS {PLAYER = 1, PLAYER_WEAPON = 2, ENEMY = 4, ENEMY_WEAPON = 8, WALL = 16}
