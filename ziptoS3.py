import os
import zipfile
import boto3
import create_layer_version
import main

def zip_subfolder_contents(bucket, i, dependence):
    s3_client = boto3.client('s3')
    folder_path = "./dependencies"
    if not os.path.isdir(folder_path):
        print(f'Error: "{folder_path}" is not a valid directory.')
        return
    s3_bucket = bucket

    subfolder_path = os.path.join(folder_path, dependence)
    if os.path.isdir(subfolder_path):
        zip_filename = f'{dependence}.zip'
        with zipfile.ZipFile(zip_filename, 'w', zipfile.ZIP_DEFLATED) as zipf:
            for root, _, files in os.walk(subfolder_path):
                for file in files:
                    file_path = os.path.join(root, file)
                    arcname = os.path.relpath(file_path, subfolder_path)
                    zipf.write(file_path, arcname)

        s3_key = f'layers/{zip_filename}'
        s3_client.upload_file(zip_filename, s3_bucket, s3_key)
        print(f'Zip file "{zip_filename}" uploaded to S3: s3://{s3_bucket}/{s3_key}')
        zipf.close()
        os.remove(zip_filename)
        create_layer_version.create_layer_version_backend(i, bucket, s3_key, dependence, main.runtime)
