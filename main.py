import analise
import data
import install_dependence
import threading
import shutil
import os
runtime = data.response['Parameter']['Value']
bucket = data.response2['Parameter']['Value']

def installdependence(dependence):
        install_dependence.install_dependencies(dependence, bucket, dependence.strip().split('==')[0])

if __name__ == '__main__':
    if os.path.exists("dependencies"):
        shutil.rmtree("./dependencies")
        print(f'Folder dependencies and its contents have been deleted.')
    else:
        print(f'Folder dependencies does not exist.')
    analise.extract_layers_in_txtfile(runtime,"requirements.txt")
    data.get_non_existing_dependences()
    # print("Not Matched : ",data.requirements_in_file)
    # print("matched : ", data.matched_requirements)
    # print(data.non_existing_elements)
    # print(data.layer_names)
    threads = []
    for dependency in data.non_existing_elements:
        thread = threading.Thread(target=installdependence, args=(dependency,))
        try:
            threads.append(thread)
            thread.start()
        except Exception as e:
             print(e)            
    for thread in threads:
        thread.join()
    analise.remove_duplicate_lines('matched_arns.txt')
    data.success_log.close()
    data.error_log.close()


