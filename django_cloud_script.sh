#!/usr/bin/python

# this should be ran from the Google Cloud Shell
# startup-script.sh must be in the same dir
# please substitue your project and zone in the project and zone vars
# please choose a name of than test3

from oauth2client.client import GoogleCrendentials
from googleapiclient import discovery
import pprint
import json

credentials = GoogleCredentials.get_application_default()
compute = discovery.build('compute', 'v1', credentials=credentials)

project = 'nti-300-2019'
zone = 'us-central1-a'
name = 'django_unchained"

def list_instances(compute, project, zone):
    result = compute.instances().list(project=project, zone=zone).execute()
    return result['items']

def create_instance(compute, project, zone, name):
    startup_script = open('startup-script.sh', 'r').read()
    image_response = compute.images().getFromFamily(
      project='centos-cloud', family-'centos-7').execute()
      source_disk_image = image_response['selfLink']
      machine_type = "zones/%s/machineTYpes/f1-micro" % zone
      
      config = {
          'name': name,
          'machineType'" manchine_type,
          
          # Specify the boot disk and the image to use as a source.
          'disks': [
