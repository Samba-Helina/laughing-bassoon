extends Resource

# These flags specify how the spell acts
# Change these into the following format:
# export(int, FLAGS, "FLAG1", "FLAG2", FLAG3"...) var name = 0
# This will change them to allow multiple choices
export(Flags.CURR_TARGET) var target
export(Flags.SPELL_TYPE) var type
#This Directory will hold all the animation and hitbox resources
export(String, DIR) var resource_dir
# In the future change into these. Could be fa
export(String, FILE) var animations
export(String, FILE) var hitbox1
