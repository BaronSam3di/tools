#!/bin/bash

# Script to describe all containers in all namesapces cluster

oc get ns | cut -d " " -f 1 > namespaces.txt

input="namespaces.txt"

while IFS= read -r namespace 
do
  if [[ "$namespace" != "NAME" ]]; then
  echo "***************** Looking at $namespace **********************"
  echo "*************************** $namespace ************************" >> ClusterDescription.txt
  oc get po -n $namespace >> ClusterDescription.txt
  echo **************************************************************** >> ClusterDescription.txt
  fi  
done < "$input"
