import data
def check_layers_exist(runtimes, layers):
    layer_names = [layer['LayerName'] for layer in data.lambda_client.list_layers()['Layers']]
    with open('matched_arns.txt', 'w') as matched_file:
        for layer_name in layers:
            if layer_name in layer_names:
                print(f'Layer "{layer_name}" exists.')
                layer_versions_response = data.lambda_client.list_layer_versions(LayerName=layer_name)
                layer_versions = layer_versions_response['LayerVersions']
                if layer_versions:
                    for version in layer_versions:
                        layer_version_arn = version['LayerVersionArn']
                        layer_version_runtime = version['CompatibleRuntimes']
                        layer_description = get_layer_description(data.lambda_client, layer_version_arn)
                
                        print(f'  - Version {version["Version"]} Description: {layer_description}')

                        check_requirement_match(runtimes, layer_version_arn, layer_description, matched_file, layer_version_runtime)
                else:
                    print(f'  - No versions found for layer "{layer_name}"')


def get_layer_description(lambda_client, layer_version_arn):
    response = lambda_client.get_layer_version_by_arn(Arn=layer_version_arn)
    return response['Description']


def check_requirement_match(runtimes, layer_version_arn, description, matched_file, layer_runtime):
    matched_requirements = [requirement for requirement in data.requirements_in_file if requirement in description and runtimes in layer_runtime]
    if matched_requirements:
        for requirement in matched_requirements:
            print(f"    - Requirement '{requirement}' matches in the description.")
            data.matched_requirements.append(requirement)
        matched_file.write(f"{layer_version_arn}\n")
    else:
        print("- No matched requirements found.")

def extract_layers_in_txtfile(runtime, file_path):
    dependencies = []
    with open(file_path, 'r') as file:
        for line in file:
            dependency = line.strip().split('==')[0]
            dependencies.append(dependency)
    data.layer_names = dependencies
    check_layers_exist(runtime,dependencies)


def remove_duplicate_lines(file_path):
    lines_seen = set()
    output_lines = []
    with open(file_path, 'r') as file:
        for line in file:
            if line.strip() not in lines_seen:
                lines_seen.add(line.strip())
                output_lines.append(line)

    with open(file_path, 'w') as file:
        file.writelines(output_lines)