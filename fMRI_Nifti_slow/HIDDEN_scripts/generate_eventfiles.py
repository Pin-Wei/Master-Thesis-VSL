import pandas as pd
import os
import sys

# def calculate_dur(df):
#     return df['Shut-down']-df['Show-up']

# def event_name(df):
#     return str(int(df['Triplet']))+str(int(df['Label']))

TASK = ['vsl','slowVSL'][1]
if Subj_ID[0] == '0':
    PREFIX = 'PW' #Rapid event-related
elif Subj_ID[0] == '1':
    PREFIX = 'Slow'

TOP_DIR = '/media/data2/pinwei/SL_hippocampus/behavioral_data/'
PATH = os.path.join(TOP_DIR, 'logs', PREFIX+Subj_ID)
FILE = '{:}_{:}.xlsx'.format(Subj_ID, 'jigg_task')
if not os.path.isdir(PATH):
    os.mkdir(PATH)
    os.rename(os.path.join('logs', FILE), os.path.join(PATH, FILE))
elif not os.path.isfile(os.path.join(PATH, FILE)):
    os.rename(os.path.join('logs', FILE), os.path.join(PATH, FILE))

sheet_list = ['RUN_{:}'.format(run) for run in range(1,11)]
R = 1
for sheet in sheet_list:
    Data = pd.read_excel(os.path.join(PATH, FILE), sheet_name=sheet, engine='openpyxl')
    Onset = round(Data['Show-up']-Data['Trigger'][0], 1)
    Duration = [1 for x in Onset] ###
    Triplet_dict = {1:'A', 2:'B', 3:'C', 4:'D'}
    Label_dict = {1:'1st', 2:'2nd', 3:'3rd'}
    Event1 = Data.Triplet.apply(lambda x: Triplet_dict[x])
    Event2 = Data.Label.apply(lambda x: Label_dict[x])
    Event = Event1+'-'+Event2
    Stim = Data.Item.apply(lambda x: str(x)+'.png')
    RT = Onset+Data['RT']*Data['Press']
    EventOnset = pd.DataFrame({'onset':Onset, 'duration':Duration,
                                'trial_type':Event,
                                'task':Data['Task'], 
                                'reaction':Data['Press'], 'RT':RT, 
                                'stim_file':Stim})
    
    keep = ['onset', 'duration', 'trial_type', 'stim_file']
    Onset_pure = EventOnset[EventOnset['task']==0].loc[:, keep]
    Onset_all = EventOnset.loc[:, keep]
    Onset_task = EventOnset[EventOnset['task']==1].loc[:, keep]
    RT_Hit = EventOnset[(EventOnset['task']==1) & (EventOnset['reaction']==1)]
    RT_Hit['onset'] = RT_Hit['RT']
    RT_Hit = RT_Hit.loc[:, keep]
    Onset_miss = EventOnset[(EventOnset['task']==1) & (EventOnset['reaction']==0)].loc[:, keep]
    RT_FA = EventOnset[(EventOnset['task']==0) & (EventOnset['reaction']==1)]
    RT_FA['onset'] = RT_FA['RT']
    RT_FA = RT_FA.loc[:, keep]

    desc_list = ['events.v2', 'events.v3', 'targets', 'Hit', 'miss', 'FA']
    for x, df in enumerate([Onset_pure, Onset_all, Onset_task, RT_Hit, Onset_miss, RT_FA]):
        desc = desc_list[x]
        fn = 'sub-{:02d}_task-{:}_run-{:02d}_{:}.tsv'.format(int(Subj_ID), TASK[int(Subj_ID[0])], R, desc)
        df.to_csv(os.path.join(PATH, fn), sep='\t', index=False)

    R += 1

