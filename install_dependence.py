import subprocess;
import shutil;
import data;
import ziptoS3
def log_message(log_file, message):
    print(message)
    log_file.write(message + '\n')

def install_dependencies(dependency, bucket, i):
    folder_name = f'dependencies/{dependency}'
    command = ['pip', 'install', dependency, '-t', folder_name]
    try:
        subprocess.check_call(command, stdout=data.success_log, stderr=data.error_log)
        log_message(data.success_log, f'Successfully installed {dependency} in {folder_name}')
        ziptoS3.zip_subfolder_contents(bucket, i, dependency)
    except subprocess.CalledProcessError as e:
        log_message(data.error_log, f'Failed to install {dependency}. Error: {e}')
        data.not_installing_dependence.write(dependency)

