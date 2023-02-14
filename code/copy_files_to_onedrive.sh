# Copy large files not included in git repo to OneDrive.
# Peter Hickey
# 2023-02-02

# Project specific variables ---------------------------------------------------

REMOTE="WEHIOneDrive"
PROJECT="G000304_Broomfield"
PROJECT_ROOT="/stornext/Projects/score/Analyses/${PROJECT}"
LOCAL_PATH="${PROJECT_ROOT}/extdata"
REMOTE_PATH="SCORE/G000304_Broomfield/git_large_files/${PROJECT}"

# Create destination directory (it it doesn't exist already) -------------------

rclone mkdir ${REMOTE}:${REMOTE_PATH}

# Copy directories and their contents from local to remote ---------------------

DIRS=( FastQC vireo emptyDrops SCEs )
for DIR in "${DIRS[@]}"
do
   echo "Copying ${DIR}"
   rclone copy --progress ${LOCAL_PATH}/${DIR} ${REMOTE}:${REMOTE_PATH}/${DIR}
   echo ""
done
