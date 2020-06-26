#!/bin/bash

mkdir ../zippedDicoms # create a folder in the directory above that will contain the desired output (i.e., output directory)

dicomNames="*" # get all the dicoms

for f in $dicomNames; do # loop through the dicoms
subjFolder=$(echo $f|cut -d '/' -f1) # extract the subject ID (e.g., bblid_scanid)
mkdir ../zippedDicoms/${subjFolder} # create a subdirectory in your output directory that will contain the scans for this person
mkdir ../zippedDicoms/${subjFolder}/DICOM # create a subdirectory in the abovementioned subdirectory that will contain the dicoms
cp -r ${subjFolder}/RESOURCES ../zippedDicoms/${subjFolder}
scanFolder="${subjFolder}/SCANS/*/" # get the specific dicoms for this subject
    for s in $scanFolder; do # loop through this subject's scans
    scanNumber=$(echo $s|cut -d '/' -f3) # get their scan number
    mkdir ../zippedDicoms/${subjFolder}/DICOM/${scanNumber} # make a new directory in the DICOM subdirectory made above for this scan
    cp ${subjFolder}/SCANS/${scanNumber}/DICOM/*.dcm ../zippedDicoms/${subjFolder}/DICOM/${scanNumber} # move the relevant scans into this directory
    zip -r ../zippedDicoms/${subjFolder}/DICOM/${scanNumber}/${scanNumber}.zip ../zippedDicoms/${subjFolder}/DICOM/${scanNumber} # zip this folder
    mv ../zippedDicoms/${subjFolder}/DICOM/${scanNumber}/${scanNumber}.zip ../zippedDicoms/${subjFolder}/DICOM/${scanNumber}/${scanNumber}.dicom.zip; # rename it to dicom.zip
    rm ../zippedDicoms/${subjFolder}/DICOM/${scanNumber}/*.dcm
  done
done
