#!/bin/bash

# Script to describe all containers in all namesapces within a cluster

oc get ns | cut -d " " -f 1 > namespaces.txt

input="namespaces.txt"

while IFS= read -r namespace 
do
  if [[ "$namespace" != "NAME" ]]; then
  
  echo "***************** Looking at $namespace **********************"
  echo "*************************** $namespace ************************" >> ClusterDescription.txt
  oc get po -n $namespace | cut -d " " -f 1 > "listOfPods.txt"
  oc describe ns $namespace >> ClusterDescription.txt
  echo **************************************************************** >> ClusterDescription.txt

  podNames='listOfPods.txt'
  while read podName; do 
      if [[ "$podName" != "NAME" ]]; then
      oc describe po $podName -n $namespace >> ClusterDescription.txt
  done < "$podNames"
  fi  
  
  # Clean up
  rm -rf listOfPods.txt
  
done < "$input"
