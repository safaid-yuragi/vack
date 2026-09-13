#!/usr/bin/env sh

LYS=$(which lys)
PROJ="vack"

OBJECTS_DIR=./.build/objects
WORK_DIR=./.build/work
BIN=./bin/

compile() {
	if [ "$#" -ne 1 ]; then
		echo "usage: compile <lys>"
	fi

	replaced=$(printf "${1}" | sed 's/.lys/.o/g' | sed 's/src\///')

	echo "$LYS" compile "${1}" -c --output "${OBJECTS_DIR}/${replaced}" --work-dir "./.build/work"
	"$LYS" compile "${1}" -c --output "${OBJECTS_DIR}/${replaced}" --work-dir "${WORK_DIR}"
}

link_executable() {
	compilers=("gcc" "clang" "cc")
	compiler=""
	
	for cm in "${compilers[@]}"; do
		if command -v "${cm}" >/dev/null 2>&1; then
			compiler="${cm}"
		fi
	done

	if [ "${cm}" = "" ]; then
		echo "Linker 'gcc' or 'clang' or 'cc' not found. Please install them"
		exit 1
	fi

	objects="$(find ./.build/objects -type f -name "*.o")"

	echo "${compiler}" -o "${BIN}/${PROJ}" "${objects}"
	"${compiler}" -o "${BIN}/${PROJ}" "${objects}"
}


initialize() {
	if [ -d ".build" ]; then
		return
	fi
	if [ -d "bin/" ]; then
		return
	fi

	mkdir -p "${OBJECTS_DIR}"
	mkdir -p "${WORK_DIR}"
	mkdir -p "${BIN}"
	echo "Successfully initialized: ${OBJECTS_DIR}, ${BIN}"
}



if [ "${1}" = "build" ]; then
	initialize
	for f in "$(find ./src -type f -name '*.lys')"; do
		compile "${f}"
	done
	link_executable
elif [ "${1}" = "clean" ]; then
	rm -rvf "./.build" "bin"

else
	echo "${0} [build|clean]"
fi

