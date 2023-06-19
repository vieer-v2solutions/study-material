import data
def create_layer_version_backend(layer_name, s3_bucket, s3_key, description, runtime):
    try:
        response = data.lambda_client.publish_layer_version(
            LayerName=layer_name,
            Content={
                'S3Bucket': s3_bucket,
                'S3Key': s3_key
            },
            Description=description,
            CompatibleRuntimes=[runtime]
        )
        version = response['Version']
        layer_arn = response['LayerVersionArn']
        print(f"New version '{version}' created for layer '{layer_name}' (ARN: {layer_arn}).")
        with open('matched_arns.txt', 'a') as file:
            file.write('\n'+layer_arn )
    except Exception as e:
        print(f"An error occurred while creating a new layer version: {str(e)}")



