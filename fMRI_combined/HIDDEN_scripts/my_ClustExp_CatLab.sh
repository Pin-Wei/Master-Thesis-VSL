#!/bin/tcsh

###########################################################################
## 07/20/2017 Justin Rajendra
## script to concatenate and relabel a group of images.
## may be useful later for group level extraction

### need to check for duplicate image names

###########################################################################
## parse command line arguments

## get the current program name
set prog = `basename $0`

## set the defaults
set LabelFile = ""
set prefix = ""

## show help
if ( $#argv < 2 ) then
    goto SHOW_HELP
endif

set narg = 1
@ amax = $#argv - 0

while ( $narg <= $amax )
    if ( "$argv[$narg]" == "-input" ) then
        @ narg ++
        set LabelFile = `echo $argv[$narg]`
    else if ( "$argv[$narg]" == "-prefix" ) then
        @ narg ++
        set prefix = `echo $argv[$narg]`
    else if ( "$argv[$narg]" == "-help" || "$argv[$narg]" == "-h" ) then
        goto SHOW_HELP
    else
        goto SHOW_HELP
    endif
    @ narg ++
end

###########################################################################
## check the arguments

## make sure you specified input and output
if ( $LabelFile == "" ) then
    echo ; echo Error: -input file name not specified! ; echo ; exit 1
endif

if ( $prefix == "" ) then
    echo ; echo Error: -prefix not specified! ; echo ; exit 1
endif

###########################################################################
## do the work

## fix funky text files
file_tool -overwrite -show_file_type  -show_bad_char -infiles $LabelFile \
          -prefix delete.me00.2D

## give a chance for interuption after the temp files are created
onintr CLEAN_BAD

## read in the labels
set labels = (`awk 'BEGIN { FS = "[ \t\n,]+" } { print $1 }' delete.me00.2D`)

## read in the images (need 2 lines for the subbrik selectors)
awk 'BEGIN { FS = "[ \t\n,]+" } { print $2 }' delete.me00.2D > delete.me01.2D
set images = "`cat delete.me01.2D`"

## make sure the number of labels matches the number of images
if ( "$#labels" != "$#images" ) then
    echo
    echo "ERROR: Length of labels and datasets do not match!"
    echo "Labels: $#labels"
    echo "Datasets: $#images"
    echo "The input table must be missing an entry."
    goto CLEAN_BAD
endif

## make sure that all of the data sets loadable
3dinfo -exists `awk '{print $1}' delete.me01.2D` > delete.me02.2D
set all_load = `awk '{ sum += $1 } END { print sum }' delete.me02.2D`
if ( "$#labels" != $all_load ) then
    echo
    echo "ERROR: At least 1 data set is not loadable or is missing!"
    goto CLEAN_BAD
endif

## make sure that all of the data sets are in the same grid
3dinfo -same_grid `awk '{print $1}' delete.me01.2D` > delete.me02.2D
set all_same = `awk '{ sum += $1 } END { print sum }' delete.me02.2D`
if ( "$#labels" != $all_same ) then
    echo
    echo "ERROR: At least 1 data set is not in the same grid!"
    goto CLEAN_BAD
endif

## make sure that all of the data sets have one subbrik
3dinfo -nv `awk '{print $1}' delete.me01.2D` > delete.me02.2D
set num_brik = `awk '{ sum += $1 } END { print sum }' delete.me02.2D`
if ( "$#labels" != $num_brik ) then
    echo
    echo "ERROR: At least 1 data set has more than one subbrik!"
    goto CLEAN_BAD
endif

## combine the images
## tcat doesn't work with the subbrik selectors so use 3dcalc for now
# 3dTcat -overwrite -prefix delete.me00.nii.gz "$images"
3dcalc -a "$images" -expr 'a' -prefix delete.me00.nii.gz

## give the propper labels, save out as prefix
3drefit -relabel_all_str "${labels}" delete.me00.nii.gz
3dcopy delete.me00.nii.gz $prefix

## cleanup and exit
\rm delete.me00.nii.gz delete.me00.2D delete.me01.2D delete.me02.2D
echo
exit 0

###########################################################################
CLEAN_BAD:
    echo
    echo Cleaning up!
    # \rm -vf delete.me00.nii.gz delete.me00.2D delete.me01.2D delete.me02.2D
    echo
    exit 1

###########################################################################
SHOW_HELP:
cat << EOF

   ----------------------------------------------------------------------------
   $prog - helper script to concatenate and label a group of data sets.

      Takes a text file with 2 columns with no header line.
      (there can be more columns, that will be ignored)
      On each row:

      The 1st column is the label for each data set e.g. subject ID.
      Labels may be at most 64 characters.
      The same subject ID can be used more than once as in the case of
      a within subject analysis design.

      The 2nd column is the data set for that label (with path if needed).
      Columns can be separated by white space or a single comma.

      The data sets must be a single subbrik or with a single subbrik selector!
      All data sets must be in the same template space.

      Creates an output data set that includes each input data set as a labeled
      subbrik.
      This may be useful for extracting individual level ROI data for a group
      level analysis later with perhaps ClustExp_StatParse.py.

   -----------------------------------------------------------------------------
   options:

      -prefix PREFIX    : output file name
      -input FILE       : name of file containing the labels and data sets table
      -help             : show this help

   -----------------------------------------------------------------------------
   examples:

   $prog -prefix disco -input subjects.csv

   -----------------------------------------------------------------------------
   Justin Rajendra 07/20/2017

EOF

exit 0
