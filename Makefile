# The compiler: g++ for C++ programs
CXX = g++

# Get the Git version
GIT_VERSION := "$(shell git describe --abbrev=0 --tags)"

# Compiler flags:
CXX_FLAGS = --std=c++17 -g -Wall -Wextra -O3 -DVERSION=\"$(GIT_VERSION)\"
OPENMP = -fopenmp

# Source and object directories
SRC_DIR = ./src
OBJ_DIR = ./obj
INC_DIR = ./inc

# All output target executables
TARGETS = sudoku_main

# All object files (to be automatically handled)
SOURCES = $(wildcard $(SRC_DIR)/*.cpp)
OBJECTS = $(SOURCES:$(SRC_DIR)/%.cpp=$(OBJ_DIR)/%.o)

# Dependencies list
DEPENDENCIES = \
	$(SRC_DIR)/SudokuBoard.cpp \
	$(SRC_DIR)/SudokuBoardDeque.cpp \
	$(SRC_DIR)/SudokuTest.cpp \
	$(SRC_DIR)/SudokuSolver.cpp \
	$(SRC_DIR)/SudokuSolver_SequentialBacktracking.cpp \
	$(SRC_DIR)/SudokuSolver_SequentialBruteForce.cpp \
	$(SRC_DIR)/SudokuSolver_ParallelBruteForce.cpp \
	$(SRC_DIR)/Node.cpp \
	$(SRC_DIR)/SudokuSolver_SequentialDLX.cpp \
	$(SRC_DIR)/SudokuSolver_ParallelDLX.cpp \
	$(SRC_DIR)/SudokuSolver_SequentialForwardChecking.cpp

# Default target
all: $(TARGETS)

# Rule to build the final executable
sudoku_main: $(OBJECTS)
	$(CXX) $(CXX_FLAGS) $(OPENMP) -I $(INC_DIR) -o $@ $^

# Rule to build object files from source files
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	@mkdir -p $(OBJ_DIR)  # Create obj directory if it doesn't exist
	$(CXX) $(CXX_FLAGS) $(OPENMP) -I $(INC_DIR) -c $< -o $@

# Clean up build files
clean:
	rm -rf $(OBJ_DIR) $(TARGETS) solution.txt

.PHONY: all clean
