import pandas as pd
import os
import sys

def calculate_dur(df):
    return df['Shut-down']-df['Show-up']

# def event_name(df):
#     return str(int(df['Triplet']))+str(int(df['Label']))

TASK = ['vsl','slowVSL']
Subjs = input("\nInput a list of subject ID (3d): ").split()
# Subj_ID = int(sys.argv[1])

for Subj_ID in Subjs:

    if Subj_ID[0] == '0':
        PREFIX = 'PW' #Rapid event-related
    elif Subj_ID[0] == '1':
        PREFIX = 'Slow'

    PATH = 'logs//{:}//'.format(PREFIX+Subj_ID)
    FILE = '{:}_{:}.xlsx'.format(Subj_ID, 'jigg_task')
    if not os.path.isdir(PATH):
        os.mkdir(PATH)
        os.rename('logs//'+FILE, PATH+FILE)
    elif not os.path.isfile(PATH+FILE):
        os.rename('logs//'+FILE, PATH+FILE)

    sheet_list = ['RUN_{:}'.format(run) for run in range(1,11)]
    R = 1
    for sheet in sheet_list:
        Data = pd.read_excel(PATH+FILE, sheet_name=sheet, engine='openpyxl')
        Onset = round(Data['Show-up']-Data['Trigger'][0], 1)
        Duration = [1 for x in Onset]
        # if PREFIX == 'PW':
        #     Duration = [1 for x in Onset]
        # elif PREFIX == 'Slow':
        #     Duration = Data.apply(calculate_dur, axis=1)
        # Event = Data.apply(event_name, axis=1)
        Triplet_dict = {1:'A', 2:'B', 3:'C', 4:'D'}
        Label_dict = {1:'1st', 2:'2nd', 3:'3rd'}
        Event1 = Data.Triplet.apply(lambda x: Triplet_dict[x])
        Event2 = Data.Label.apply(lambda x: Label_dict[x])
        Event = Event1+'-'+Event2
        Stim = Data.Item.apply(lambda x: str(x)+'.png')
        EventOnset = pd.DataFrame({'onset':Onset, 'duration':Duration,
                                   'trial_type':Event,
                                   # 'trial_type-triplet':Event1, 'trial_type-label':Event2,
                                   'task':Data['Task'], 'stim_file':Stim})
        EventOnset = EventOnset[EventOnset['task']==0]
        EventOnset = EventOnset.drop('task', axis=1)
        EventOnset.to_csv(PATH +'//sub-{:02d}_task-{:}_run-{:02d}_events.v2.tsv'.format(int(Subj_ID), TASK[int(Subj_ID[0])], R), sep='\t', index=False)
        R += 1
