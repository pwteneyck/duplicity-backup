# duplicity-backup
For backing up (anything) using duplicity. Meant to be run as a cron job. Note: Glacier Deep Archive costs run at about $1/TB/month for storage, but about $100/TB for downloading/transferring the data out of AWS's network.

# Setup

## AWS configuration

1. Create a bucket to store backups in (`$BUCKET_NAME`)
2. Create an IAM user that `duplicity` will use to access S3
3. Create a minimal-access IAM policy for access to that bucket:

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:ListBucketMultipartUploads",
                "s3:AbortMultipartUpload",
                "s3:RestoreObject",
                "s3:ListBucket",
                "s3:DeleteObject",
                "s3:ListMultipartUploadParts"
            ],
            "Resource": [
                "arn:aws:s3:::$BUCKET_NAME",
                "arn:aws:s3:::*/*"
            ]
        }
    ]
}
```

## Local configuration
1. `cp *.sh $(DESIRED_INSTALL_DIRECTORY)`
2. `cp .conf $(DESIRED_INSTALL_DIRECTORY)`
3. Fill in the config values:
* `BACKUP_DIR`: the local directory to back up
* `BUCKET_NAME`: the S3 bucket to store backups in
* `AWS_ACCESS_KEY_ID`: the access key for the IAM user/role that `duplicity` will use to make AWS calls
* `AWS_SECRET_ACCESS_KEY`: the secret key associated with the IAM role

## Usage

**Backup:** `./backup.sh`
**Restore:** `./restore.sh` (UNTESTED)
