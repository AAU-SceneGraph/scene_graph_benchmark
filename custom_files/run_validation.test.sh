set -e

python tools/demo/demo_image.py --config_file checkpoints/causal_tde/rel_danfeiX_FPN50_nm.yaml --img_file custom_images/francesco_example/3.jpg --save_file custom_images/francesco_example/3_out.jpg --device ${1:-cuda} --visualize_relation MODEL.ROI_RELATION_HEAD.DETECTOR_PRE_CALCULATED False DATASETS.LABELMAP_FILE "VG-SGG-dicts-danfeiX-clipped.json" DATA_DIR data/VG OUTPUT_DIR custom_images/SGs MODEL.ROI_RELATION_HEAD.USE_BIAS True MODEL.ROI_RELATION_HEAD.FILTER_NON_OVERLAP True MODEL.ROI_HEADS.DETECTIONS_PER_IMG 64 MODEL.ROI_RELATION_HEAD.SHARE_BOX_FEATURE_EXTRACTOR False MODEL.ROI_RELATION_HEAD.NEURAL_MOTIF.OBJ_LSTM_NUM_LAYERS 0 MODEL.ROI_RELATION_HEAD.NEURAL_MOTIF.EDGE_LSTM_NUM_LAYERS 2 TEST.IMS_PER_BATCH 2