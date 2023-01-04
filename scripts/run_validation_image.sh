#!/bin/bash

set -e # exit on first error

device=cuda
o_threshold=0
r_threshold=0
model_config="causal_tde/rel_danfeiX_FPN50_nm.yaml"
labelmap="VG-SGG-dicts-danfeiX-clipped.json"
while getopts d:i:o:e:r:c:l: flag
do
    case "${flag}" in
        d) device=${OPTARG};;
        i) image=${OPTARG};;
        o) output=${OPTARG};;
        e) o_threshold=${OPTARG};;
        r) r_threshold=${OPTARG};;
        c) model_config=${OPTARG};;
        l) labelmap=${OPTARG};;
    esac
done

python --version

python tools/demo/generate_sg.py --config_file checkpoints/$model_config --device $device --input $image --visualize_attr --visualize_relation --min_obj_score ${o_threshold} --min_rel_score ${r_threshold} MODEL.ROI_RELATION_HEAD.DETECTOR_PRE_CALCULATED False DATASETS.LABELMAP_FILE $labelmap DATA_DIR data/VG MODEL.ATTRIBUTE_ON True MODEL.RELATION_ON True TEST.OUTPUT_RELATION_FEATURE True MODEL.ROI_RELATION_HEAD.USE_BIAS True MODEL.ROI_RELATION_HEAD.FILTER_NON_OVERLAP True MODEL.ROI_HEADS.DETECTIONS_PER_IMG 64 MODEL.ROI_RELATION_HEAD.SHARE_BOX_FEATURE_EXTRACTOR False MODEL.ROI_RELATION_HEAD.NEURAL_MOTIF.OBJ_LSTM_NUM_LAYERS 0 MODEL.ROI_RELATION_HEAD.NEURAL_MOTIF.EDGE_LSTM_NUM_LAYERS 2 TEST.IMS_PER_BATCH 2
python tools/demo/annotate_image.py --config_file checkpoints/$model_config --device $device --img_file $image --visualize_attr --visualize_relation --min_obj_score ${o_threshold} --min_rel_score ${r_threshold} MODEL.ROI_RELATION_HEAD.DETECTOR_PRE_CALCULATED False DATASETS.LABELMAP_FILE $labelmap DATA_DIR data/VG MODEL.ATTRIBUTE_ON True MODEL.RELATION_ON True TEST.OUTPUT_RELATION_FEATURE True MODEL.ROI_RELATION_HEAD.USE_BIAS True MODEL.ROI_RELATION_HEAD.FILTER_NON_OVERLAP True MODEL.ROI_HEADS.DETECTIONS_PER_IMG 64 MODEL.ROI_RELATION_HEAD.SHARE_BOX_FEATURE_EXTRACTOR False MODEL.ROI_RELATION_HEAD.NEURAL_MOTIF.OBJ_LSTM_NUM_LAYERS 0 MODEL.ROI_RELATION_HEAD.NEURAL_MOTIF.EDGE_LSTM_NUM_LAYERS 2 TEST.IMS_PER_BATCH 2
python tools/demo/export_graphviz.py --img_file ${image/%".jpg"/".SG.json"}