import boto3
lambda_client = boto3.client('lambda')
ssm_client = boto3.client('ssm')
response = ssm_client.get_parameter(Name='PROJECT_NAME_RUNTIME', WithDecryption=False)
response2 = ssm_client.get_parameter(Name='PROJECT_NAME_S3_BUCKET', WithDecryption=False)
matched_requirements = []
non_existing_elements = []
layer_names = []
with open('requirements.txt', 'r') as file:
        requirements_in_file = [line.strip() for line in file]

def get_non_existing_dependences():
    global non_existing_elements
    non_existing_elements = [element for element in requirements_in_file if element not in matched_requirements]

success_log = open('success.log', 'a')
error_log = open('error.log', 'a')
not_installing_dependence = open('error_dependence.txt', 'a')