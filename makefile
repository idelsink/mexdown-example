# makefile for all documentation
# ignore the following directories:
ignore = mexdown shared output shippable

###########################
# mexdown global makefile #
###########################
# only edit if you know what you're doing; the point of no return
directories=$(shell find . -maxdepth 1 -type d -not -name ".*" -printf '%P\n')
directories := $(filter-out $(ignore),$(directories))

# make all
all:$(directories)

# make specific target
$(directories):
	$(MAKE) -C $@
.PHONY: $(directories)

ifdef OUT
override OUT:=$(shell readlink -m $(OUT))
endif
copy:
	$(foreach dir,$(directories),$(MAKE) -C $(dir) copy OUT=$(OUT) && ) true

# clean build folder
clean:
	$(foreach dir,$(directories),$(MAKE) -C $(dir) clean && ) true

# purge build folder
purge:
	$(foreach dir,$(directories),$(MAKE) -C $(dir) purge && ) true
