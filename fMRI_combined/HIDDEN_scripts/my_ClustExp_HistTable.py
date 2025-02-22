#!/usr/bin/env python

import sys, os, glob, subprocess, csv, re, shutil, argparse, signal, textwrap
import random

########################################################################
## definitions

## check for rectiness of mvm table
def data_is_rect(mdata):
    if mdata == None: return 1
    if len(mdata) == 0: return 1
    rlen = len(mdata[0])
    for row in mdata:
        if len(row) != rlen: return 0
    return 1

## 3dMVM and 3dLME table extraction function
def mvm_lme_extract(hist_in):

    ## split the column headers from the table
    mvm_hist = hist_in.split("-dataTable")[1]
    mvm_hdr = mvm_hist.split("InputFile")[0]+"InputFile"
    mvm_hdr = mvm_hdr.split()
    mvm_tab = mvm_hist.split("InputFile")[1]
    mvm_tab = mvm_tab.splitlines()[0]
    mvm_tab = mvm_tab.split()

    ## turn into table
    mvm_tab = [mvm_tab[n:n+len(mvm_hdr)] for n in range(0,len(mvm_tab),
                                                        len(mvm_hdr))]
    ## check for rectiness and return
    if data_is_rect(mvm_tab):
        return (mvm_tab, mvm_hdr)
    else:
        print("Data table is not rectangular")
        sys.exit(1)

########################################################################
## parse command line arguments / build help

parser = argparse.ArgumentParser(prog=str(sys.argv[0]),
                                 formatter_class=argparse.RawDescriptionHelpFormatter, 
                                 description=textwrap.dedent(''' \
## Purpose: 
Extract the data table from history of datasets from 3dttest++, 3dMVM, or 3dLME. 
From AFNI: Breadcrumbsafni/src/discoraj/ClusterExplorer/ClustExp_HistTable.py
                                                             
## Outputs:
Named with your -prefix and "_GroupTable.csv"
This table (.csv) containing information parsed from the statistics dataset history.
May include subject ID, any group or other variables, and input datasets.
Can use this script to help make the table for @ClustExp_CatLab
                                                             
## Options:
'''), epilog=textwrap.dedent(''' \
                             
## See more:
- https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/tutorials/ClusterExplorer/Introduction.html
- https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/programs/alpha/ClustExp_HistTable.py_sphx.html 
                             '''))
parser._action_groups.pop()
required = parser.add_argument_group("required")
optional = parser.add_argument_group("optional")

required.add_argument("-StatDSET", type=str, required=True, 
                      help="Statistics dataset.")
optional.add_argument("-in_path", type=str, default="./", 
                      help=("Input folder if you don't want the "+
                            "current working directory. [./]"))
optional.add_argument("-prefix", type=str, default="GroupOut", 
                      help="Name for output (no path). [GroupOut]")
optional.add_argument("-session", type=str, default="./", 
                      help=("Output parent folder if you don't want the "+
                            "current working directory. [./]"))
optional.add_argument("-overwrite", action="store_true", default=False,
                      help="Remove previous folder with same PREFIX")
optional.add_argument("-rm_after", type=str, default="-CLUSTSIM", 
                      help=("Remove options characters appended to the "+
                            "statistics dataset history"))
parser.add_argument("-help", action="help", help="Show this help.")

## if nothing, show help
if len(sys.argv) == 1:
    parser.print_help()
    sys.exit(1)

########################################################################
## do the parsing

args = parser.parse_args()
in_path = os.path.abspath(args.in_path)
StatFile = os.path.join(in_path, args.StatDSET)
prefix = args.prefix
session = os.path.abspath(args.session)
rm_after = args.rm_after

## verify some stuff before continuing
if "/" in prefix:
    print("")
    print("Error: "+prefix+" contains a path!")
    print("-prefix must not include a path.")
    print("Use -session to add a path.")
    print("")
    sys.exit(1)

## make sure the input data sets are good
afni_cmd = ("3dinfo -exists "+StatFile)
if subprocess.check_output(afni_cmd, shell=True)[0] == "0":
    print("")
    print("Error: "+StatFile+" is not loadable!")
    print("")
    sys.exit(1)

## make sure there is enough history in the stat file to parse
hist_cmd = "3dinfo -history "+StatFile
hist_all = subprocess.check_output(hist_cmd, shell=True, encoding="utf-8")
if not ("3dttest++" in hist_all or "3dMVM" or "3dLME" in hist_all):
    print("")
    print("Error: "+StatFile+" does not have an intact history!")
    print("Are you sure it is DIRECTLY from 3dttest++ or 3dMVM?")
    print("")
    sys.exit(1)

########################################################################
## make output file name and overwrite if necessary
    
OutGroupTab  = session+"/"+prefix+".csv"

## remove previous if asked
if args.overwrite:
    try:
        os.remove(OutGroupTab)
    except OSError:
        pass

if os.path.isfile(OutGroupTab):
    print("")
    print("Output file exists!")
    print(OutGroupTab)
    print("You may want -overwrite")
    print("")
    sys.exit(1)

########################################################################
## parse history from stats image
    
## get the whole history
hist_cmd = "3dinfo -history "+StatFile
hist_all = subprocess.check_output(hist_cmd, shell=True, encoding="utf-8")

########################################################################
## 3dttest++
if "3dttest++" in hist_all:

    ## assumptions of defaults
    labelB = "NA"

    ## setA read until next argument ("-")
    setA = hist_all.split("-setA")[1]
    setA = setA.split(rm_after)[0] ## My customize!
    setA = setA.split("\n")[0]        ## split to next command in history
    setA = setA.split()

    ## check for long form
    if ("+tlrc" not in setA[0]) and (".nii" not in setA[0]):

        ## chop off the label
        labelA = setA[0]
        setA = setA[1:len(setA)]

        ## turn into table and check for rectiness
        setA_tab = [setA[n:n+2] for n in range(0, len(setA), 2)]
        if not data_is_rect(setA_tab):
            print("Data table is not rectangular")
            sys.exit(1)

        ## transpose
        setA_tab = [list(x) for x in zip(*setA_tab)]

        ## make label array to match the number of subjects
        labA_arr = [labelA] * int(len(setA)/2)

        ## setB
        if "-setB" in hist_all:
            setB = hist_all.split("-setB")[1]

            setB = setB.split("-")[0]   ## split to next argument
            setB = setB.split("\n")[0]   ## split to next command in history
            setB = setB.split()

            ## chop off the label
            labelB = setB[0]
            setB = setB[1:len(setB)]

            ## turn into table and check for rectiness
            setB_tab = [setB[n:n+2] for n in range(0,len(setB),2)]
            if not data_is_rect(setB_tab):
                print("Data table is not rectangular")
                sys.exit(1)

            ## transpose
            setB_tab = [list(x) for x in zip(*setB_tab)]

            ## make label array to match the number of subjects
            labB_arr = [labelB] * (len(setB)/2)

            ## combine
            labels_out = labA_arr+labB_arr
            subj_out = setA_tab[0]+setB_tab[0]
            dset_out = setA_tab[1]+setB_tab[1]
            tab_out = [labels_out,subj_out,dset_out]

        else:   ## no setB
            tab_out = [labA_arr,setA_tab[0],setA_tab[1]]

        ######################################
        ## transpose array
        tab_out = [list(x) for x in zip(*tab_out)]

        ## write out
        subj_table = [["Group","Subj","InputFile"]]
        for dset in tab_out:
            if dset[-1].startswith(('"',"'")):   ## remove quotes
                dset[-1] = dset[-1][1:-1]
            subj_table.append([dset[0],dset[1],dset[2]])

        ## write out data table with headers
        wtr = csv.writer(open(OutGroupTab,'w'), delimiter=',',
                         lineterminator='\n')
        for row in subj_table : wtr.writerow(row)

    ######################################
    ## short form
    else:
        ## labels
        if "-labelA" in hist_all:
            labelA = hist_all.split("-labelA")[1]
            labelA = labelA.split()[0]
        else:
            labelA = "SetA"

        ## make array to match the number of subjects
        labA_arr = [labelA] * len(setA)

        ## setB if there is one
        if "-setB" in hist_all:
            setB = hist_all.split("-setB")[1]
            setB = setB.split("-")[0]
            setB = setB.split()

            ## label
            if "-labelB" in hist_all:
                labelB = hist_all.split("-labelB")[1]
                labelB = labelB.split()[0]
            else:
                labelB = "SetB"

            labB_arr = [labelB] * len(setB)
            labels_out = labA_arr+labB_arr
            subj_out = setA+setB
            tab_out = [labels_out,subj_out]

        else:   ## no -setB
            labels_out = labA_arr
            subj_out = setA
            model_T = labelA
            tab_out = [labels_out,subj_out]
        ## end -setB check

        ## transpose array
        tab_out = [list(x) for x in zip(*tab_out)]

        ## write out
        subj_table = [["Group","InputFile"]]
        for dset in tab_out:
            if dset[-1].startswith(('"',"'")):   ## remove quotes
                dset[-1] = dset[-1][1:-1]
            subj_table.append([dset[0],dset[1]])

        ## write out data table with headers
        wtr = csv.writer(open(OutGroupTab,'w'),delimiter=',',
                         lineterminator='\n')
        for row in subj_table : wtr.writerow(row)

##  end 3dttest++ check

########################################################################
## 3dMVM/3dLME
elif "3dMVM" in hist_all or "3dLME" in hist_all:
    print(mvm_lme_extract(hist_all))

    ## extract mvm/lme
    mvm_tab, mvm_hdr = mvm_lme_extract(hist_all)

    ## write out data table with headers
    wtr = csv.writer(open(OutGroupTab,'w'),delimiter=',',
                     lineterminator='\n')
    wtr.writerow(mvm_hdr)
    for row in mvm_tab:
        if row[-1].startswith(('"',"'")):
            row[-1] = row[-1][1:-1]
            wtr.writerow(row)
        else:
            wtr.writerow(row)

##  end 3dMVM/3dLME check
else:
    print("No model information!!")
    sys.exit(1)
## end 3dttest++ and 3dMVM/3dLME check

########################################################################
## done!
    
# print("")
print("Output is here: "+OutGroupTab.replace("/media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/Group_analysis", ""))
print("")

sys.exit(0)