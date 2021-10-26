#!/bin/bash

source '/home/pwt/.duplicity/.conf'

export BACKUP_DIR
export BUCKET_NAME
export AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY

duplicity --name 'hello-world-backup'  \
	--no-encryption \
	--progress \
	--s3-use-deep-archive \
	--s3-use-new-style \
	--s3-use-multiprocessing \
	--asynchronous-upload \
	--verbosity i \
	--log-file "/home/pwt/.duplicity/backup-$(date "+%Y%m%d-%H%M%S").log" \
	"$BACKUP_DIR" \
	"boto3+s3://$BUCKET_NAME/$HOSTNAME"

unset BACKUP_DIR
unset BUCKET_NAME
unset AWS_ACCESS_KEY
unset AWS_SECRET_ACCESS_KEY
