#! /usr/bin/env bash

retval=0

array=( nan napi node-addon-api )
for i in "${array[@]}"
do
	pushd $i;

  if ! npm run test;
  then
    if [[ $retval == 0  ]]
    then
      echo "Test failed"
      retval=1
    fi
  fi

  popd;
done

exit ${retval}