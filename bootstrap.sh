#!/bin/sh

# Usage: curl -s https://raw.githubusercontent.com/usagi/vcpkg_chii/master/bootstrap.sh | sh

BASE='https://raw.githubusercontent.com/usagi/vcpkg_chii/master/cmake/'
FILES='vcpkg_chii.cmake vcpkg_chii_enable.cmake vcpkg_chii_auto_triplet.cmake vcpkg_chii_auto_toolchain_file.cmake vcpkg_chii_find_package.cmake'

echo 'vcpkg_chii/bootstrap.sh: [ LOG ] Congraturations, the bootstrap of vcpkg_chii be started.'

which curl >/dev/null 2>&1
HAS_CURL=$?
if [ $HAS_CURL -ne 0 ]; then
    echo 'vcpkg_chii/bootstrap.sh: [ FATAL ] Could not found `curl` command.'
    return 1
fi

if [ ! -d cmake ]; then
  echo 'vcpkg_chii/bootstrap.sh: [ LOG ] cmake directory is not found, thus the bootstrap try to create it.'
  mkdir cmake
  if [ ! -d cmake ]; then
    echo 'vcpkg_chii/bootstrap.sh: [ FATAL ] Could not create the cmake directory.'
    exit 2
  fi
  echo 'vcpkg_chii/bootstrap.sh: [ LOG ] `mkdir cmake` was succeeded.'
fi

cd cmake
if [ $? -ne 0 ]; then
  echo 'vcpkg_chii/bootstrap.sh: [ FATAL ] `cd cmake` was failed.'
  exit 4
fi
echo 'vcpkg_chii/bootstrap.sh: [ LOG ] `cd cmake` was succeeded.'

COUNT_OF_FILES=$(echo ${FILES} | tr ' ' '\n' | wc -l)

CURL_ARGUMENT=''

for INDEX in $(seq ${COUNT_OF_FILES}); do
  FILE=$(echo $FILES | cut -d ' ' -f ${INDEX})
  URI="${BASE}${FILE}"
  CURL_ARGUMENT="${CURL_ARGUMENT} -O ${URI}"
done

echo "vcpkg_chii/bootstrap.sh: [ LOG ] Begin download the ${COUNT_OF_FILES} .cmake files..."

curl ${CURL_ARGUMENT}
if [ $? -ne 0 ]; then
  echo 'vcpkg_chii/bootstrap.sh: [ FATAL ] `curl` was failed.'
  exit 3
fi

echo 'vcpkg_chii/bootstrap.sh: [ LOG ] Completed, you can use `include(cmake/vcpkg_chii.cmake)` in your CMakeLists.txt and use vcpkg_chii features!'
echo 'vcpkg_chii/bootstrap.sh: [ LOG ] ( See also the example <https://github.com/usagi/vcpkg_chii/blob/master/example/CMakeLists.txt#L1>. )'
