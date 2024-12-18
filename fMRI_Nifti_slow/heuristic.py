import os


def create_key(template, outtype=('nii.gz',), annotation_classes=None):
    if template is None or not template:
        raise ValueError('Template must be a valid format string')
    return template, outtype, annotation_classes


def infotodict(seqinfo):
    """
    Heuristic evaluator for determining which runs belong where
    allowed template fields - follow python string module:
    - item: index within category
    - subject: participant id
    - seqitem: run number during scanning
    - subindex: sub index within group
    """
    T1w = create_key('sub-{subject}/anat/sub-{subject}_T1w')
    T2w = create_key('sub-{subject}/anat/sub-{subject}_T2w')
    func = create_key('sub-{subject}/func/sub-{subject}_task-slowVSL_run-{item:02d}_bold')
    fmap_mag_LR  = create_key('sub-{subject}/fmap/sub-{subject}_acq-LR_magnitude')
    fmap_mag_RL  = create_key('sub-{subject}/fmap/sub-{subject}_acq-RL_magnitude')
    fmap_phase_LR  = create_key('sub-{subject}/fmap/sub-{subject}_acq-LR_phasediff')
    fmap_phase_RL  = create_key('sub-{subject}/fmap/sub-{subject}_acq-RL_phasediff')

    info = {T1w: [], T2w: [], func: [],
            fmap_mag_LR: [], fmap_mag_RL: [], fmap_phase_LR: [], fmap_phase_RL: []}
    # last_run = len(seqinfo)

    for s in seqinfo: # each row of dicominfo.tsv
        # `s` is a namedtuple with fields equal to the names of the columns
        """The namedtuple `s` contains the following fields:
        * total_files_till_now
        * example_dcm_file
        * series_id
        * dcm_dir_name
        * unspecified2
        * unspecified3
        * dim1
        * dim2
        * dim3
        * dim4
        * TR
        * TE
        * protocol_name
        * is_motion_corrected
        * is_derived
        * patient_id
        * study_description
        * referring_physician_name
        * series_description
        * image_type
        """
        if ('T1' in s.dcm_dir_name):
            info[T1w].append(s.series_id)
        elif ('T2' in s.dcm_dir_name):
            info[T2w].append(s.series_id)
        elif ('bold' in s.protocol_name):
            info[func].append(s.series_id)
        elif ('gre_field_mapping_LR' in s.protocol_name):
            if ('M' in s.image_type):
                info[fmap_mag_LR].append(s.series_id)
            elif ('P' in s.image_type):
                info[fmap_phase_LR].append(s.series_id)
        elif ('gre_field_mapping_RL' in s.protocol_name):
            if ('M' in s.image_type):
                info[fmap_mag_RL].append(s.series_id)
            elif ('P' in s.image_type):
                info[fmap_phase_RL].append(s.series_id)
    return info
