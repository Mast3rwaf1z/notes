# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.16

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/mikkel/Desktop/OS/Workshop2

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/mikkel/Desktop/OS/Workshop2

# Include any dependencies generated for this target.
include CMakeFiles/bbfs.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/bbfs.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/bbfs.dir/flags.make

CMakeFiles/bbfs.dir/bbfs.c.o: CMakeFiles/bbfs.dir/flags.make
CMakeFiles/bbfs.dir/bbfs.c.o: bbfs.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/mikkel/Desktop/OS/Workshop2/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/bbfs.dir/bbfs.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/bbfs.dir/bbfs.c.o   -c /home/mikkel/Desktop/OS/Workshop2/bbfs.c

CMakeFiles/bbfs.dir/bbfs.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/bbfs.dir/bbfs.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/mikkel/Desktop/OS/Workshop2/bbfs.c > CMakeFiles/bbfs.dir/bbfs.c.i

CMakeFiles/bbfs.dir/bbfs.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/bbfs.dir/bbfs.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/mikkel/Desktop/OS/Workshop2/bbfs.c -o CMakeFiles/bbfs.dir/bbfs.c.s

CMakeFiles/bbfs.dir/log.c.o: CMakeFiles/bbfs.dir/flags.make
CMakeFiles/bbfs.dir/log.c.o: log.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/mikkel/Desktop/OS/Workshop2/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object CMakeFiles/bbfs.dir/log.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/bbfs.dir/log.c.o   -c /home/mikkel/Desktop/OS/Workshop2/log.c

CMakeFiles/bbfs.dir/log.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/bbfs.dir/log.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/mikkel/Desktop/OS/Workshop2/log.c > CMakeFiles/bbfs.dir/log.c.i

CMakeFiles/bbfs.dir/log.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/bbfs.dir/log.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/mikkel/Desktop/OS/Workshop2/log.c -o CMakeFiles/bbfs.dir/log.c.s

# Object files for target bbfs
bbfs_OBJECTS = \
"CMakeFiles/bbfs.dir/bbfs.c.o" \
"CMakeFiles/bbfs.dir/log.c.o"

# External object files for target bbfs
bbfs_EXTERNAL_OBJECTS =

bbfs: CMakeFiles/bbfs.dir/bbfs.c.o
bbfs: CMakeFiles/bbfs.dir/log.c.o
bbfs: CMakeFiles/bbfs.dir/build.make
bbfs: /usr/lib/x86_64-linux-gnu/libfuse.so
bbfs: CMakeFiles/bbfs.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/mikkel/Desktop/OS/Workshop2/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking C executable bbfs"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/bbfs.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/bbfs.dir/build: bbfs

.PHONY : CMakeFiles/bbfs.dir/build

CMakeFiles/bbfs.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/bbfs.dir/cmake_clean.cmake
.PHONY : CMakeFiles/bbfs.dir/clean

CMakeFiles/bbfs.dir/depend:
	cd /home/mikkel/Desktop/OS/Workshop2 && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/mikkel/Desktop/OS/Workshop2 /home/mikkel/Desktop/OS/Workshop2 /home/mikkel/Desktop/OS/Workshop2 /home/mikkel/Desktop/OS/Workshop2 /home/mikkel/Desktop/OS/Workshop2/CMakeFiles/bbfs.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/bbfs.dir/depend

